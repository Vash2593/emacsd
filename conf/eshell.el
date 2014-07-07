;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Eshell Configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; FIXME: Clean

(setq eshell-cmpl-cycle-completions nil
      eshell-save-history-on-exit t
      eshell-cmpl-dir-ignore "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.git\\|\\.idea\\)/\\'")
(add-hook 'eshell-mode-hook
          '(lambda ()
             (setenv "PAGER" "cat") ;; Set the pager
             (setenv "PATH" "$HOME/.bin:$HOME/git/various/bin::/opt/bin:$HOME/.opt/bin:$HOME/.opt/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin/:/sbin/")
             (local-set-key (kbd "C-l") 'eshell/clear)
             (local-set-key (kbd "M-j") 'recenter-top-bottom)
             (local-set-key (kbd "C-u") 'eshell/clear-line)
             ))

;; Bookmark integration
(defun pcomplete/eshell-mode/bmk ()
  "Completion for `bmk'"
  (pcomplete-here (bookmark-all-names)))
(defun eshell/bmk (&rest args)
  "Integration between EShell and bookmarks.
For usage, execute without arguments."
  (setq args (eshell-flatten-list args))
  (let ((bookmark (car args))
        filename name)
    (cond
     ((eq nil args)
      (format "Usage:
* bmk BOOKMARK to
** either change directory pointed to by BOOKMARK
** or bookmark-jump to the BOOKMARK if it is not a directory.
* bmk . BOOKMARK to bookmark current directory in BOOKMARK.
Completion is available."))
     ((string= "." bookmark)
      ;; Store current path in EShell as a bookmark
      (if (setq name (car (cdr args)))
          (progn
            (bookmark-set name)
            (bookmark-set-filename name (eshell/pwd))
            (format "Saved current directory in bookmark %s" name))
        (error "You must enter a bookmark name")))
     (t
       ;; Check whether an existing bookmark has been specified
       (if (setq filename (cdr (car (bookmark-get-bookmark-record bookmark))))
           ;; If it points to a directory, change to it.
           (if (file-directory-p filename)
               (eshell/cd filename)
             ;; otherwise, just jump to the bookmark
             (bookmark-jump bookmark))
         (error "%s is not a bookmark" bookmark))))))
(put 'set-goal-column 'disabled nil)
(require-or-install 'eshell)

(defun call-git (&rest args)
  "Call git with args"
  (setq args (eshell-stringify-list (eshell-flatten-list args)))
  (shell-command-to-string (mapconcat 'identity (cons "git" args) " "))
  )
(defun eshell/git (&rest args)
  "Git and Magit integration for eshell"
  (setq args (eshell-stringify-list (eshell-flatten-list args)))
  (setq cmd-name (elt args 0))
  (pcase cmd-name
    (`"st"     (magit-status "."))
    (`"l"      (magit-log-long "--graph"))
    (`"t"      (magit-log "--graph"))
    (`"rf"     (magit-reflog "HEAD"))
    (`"reflog" (magit-reflog "HEAD"))
    (_         (call-git args))
    )
  ) ;; FIXME: Test it

;; Redefine the cat function, while we want a new line after a bitmap display
(defun eshell/cat (&rest args)
  "Implementation of cat in Lisp.
If in a pipeline, or the file is not a regular file, directory or
symlink, then revert to the system's definition of cat."
  (setq args (eshell-stringify-list (eshell-flatten-list args)))
  (if (or eshell-in-pipeline-p
	  (catch 'special
	    (dolist (arg args)
	      (unless (or (and (stringp arg)
			       (> (length arg) 0)
			       (eq (aref arg 0) ?-))
			  (let ((attrs (eshell-file-attributes arg)))
			    (and attrs (memq (aref (nth 8 attrs) 0)
					     '(?d ?l ?-)))))
		(throw 'special t)))))
      (let ((ext-cat (eshell-search-path "cat")))
	(if ext-cat
	    (throw 'eshell-replace-command
		   (eshell-parse-command (eshell-quote-argument ext-cat) args))
	  (if eshell-in-pipeline-p
	      (error "Eshell's `cat' does not work in pipelines")
	    (error "Eshell's `cat' cannot display one of the files given"))))
    (eshell-init-print-buffer)
    (eshell-eval-using-options
     "cat" args
     '((?h "help" nil nil "show this usage screen")
       :external "cat"
       :show-usage
       :usage "[OPTION] FILE...
Concatenate FILE(s), or standard input, to standard output.")
     (dolist (file args)
       (if (string= file "-")
	   (throw 'eshell-external
		  (eshell-external-command "cat" args))))
     (let ((curbuf (current-buffer)))
       (dolist (file args)
	 (with-temp-buffer
	   (insert-file-contents file)
	   (goto-char (point-min))
	   (while (not (eobp))
	     (let ((str (buffer-substring
			 (point) (min (1+ (line-end-position))
				      (point-max)))))
	       (with-current-buffer curbuf
		 (eshell-buffered-print str)))
	     (forward-line)))))
     (eshell-flush)
     ;; if the file does not end in a newline, do not emit one
     )))

(defun eshell/clear ()
  "Clear the buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))
(defun eshell-view-file (file)
  "A version of `view-file' for FILE which properly respects the eshell prompt."
  (interactive "fView file: ")
  (unless (file-exists-p file) (error "%s does not exist" file))
  (let ((had-a-buf (get-file-buffer file))
        (buffer (find-file-noselect file)))
    (if (eq (with-current-buffer buffer (get major-mode 'mode-class))
            'special)
        (progn
          (switch-to-buffer buffer)
          (message "Not using View mode because the major mode is special"))
      (let ((undo-window (list (window-buffer) (window-start)
                               (+ (window-point)
                                  (length (funcall eshell-prompt-function))))))
        (switch-to-buffer buffer)
        (view-mode-enter (cons (selected-window) (cons nil undo-window))
                         'kill-buffer)))))
(defun eshell/less (&rest args)
  "Invoke `view-file' on ARGS. \"less +42 foo\" will go to \\
line 42 in the buffer for foo.."
  (while args
    (if (string-match "\\`\\+\\([0-9]+\\)\\'" (car args))
        (let* ((line (string-to-number (match-string 1 (pop args))))
               (file (pop args)))
          (eshell-view-file file)
          (goto-line line))
      (eshell-view-file (pop args)))))
(defalias 'eshell/more 'eshell/less)
(defalias 'eshell/most 'eshell/less)
(defun eshell/clear-line ()
  "Clear the current line in an eshell buffer."
  (interactive)
  (eshell-bol)
  (kill-line)
    )
(defun string/starts-with (s begins)
  "returns non-nil if string S starts with BEGINS.  Else nil."
  (cond ((>= (length s) (length begins))
         (string-equal (substring s 0 (length begins)) begins))
        (t nil)))
;; (defun eshell/g (&rest args)
;;   "A git integration for eshell. Need magit"
;;   (setq args (eshell-stringify-list (eshell-flatten-list args)))
;;   (if (> (length args) 0)
;;       (progn
;;         (setq cmd-name (elt args 0))
;;         (pcase cmd-name
;;           (`"l"             (magit-log-long "--graph"))
;;           (`"t"             (magit-log  "--graph"))
;;           (`"rl"            (magit-reflog "HEAD"))
;;           )
;; ;        (if (string/starts-with "log" cmd-name)
;; ;            (magit-log-long "--graph"))
;; ;        (if (string/starts-with "tree" cmd-name)
;; ;            (magit-log '("--graph" "--no-merges")))
;; ;        (if (or
;; ;             (string/starts-with "reflog" cmd-name)
;; ;             (string= cmd-name "rl"))
;; ;            (magit-reflog (elt args 1)))
;; ;      (if (string= (elt args 0) "log")
;; ;          (magit-log '("--graph" "--no-merges"))
;; ;          (apply 'magit-log (last args (- (length args) 1)))
;; ;        )
;;       )
;;   ))

;(eshell) ;; Load eshell
;(kill-buffer "*eshell*") ;; Kill eshell
;; End define my override functions.
;; Override eshell/cat
;; For end-of-file newline
(defun eshell/cat (&rest args)
  "Implementation of cat in Lisp.
If in a pipeline, or the file is not a regular file, directory or
symlink, then revert to the system's definition of cat."
  (setq args (eshell-stringify-list (eshell-flatten-list args)))
  (if (or eshell-in-pipeline-p
	  (catch 'special
	    (dolist (arg args)
	      (unless (or (and (stringp arg)
			       (> (length arg) 0)
			       (eq (aref arg 0) ?-))
			  (let ((attrs (eshell-file-attributes arg)))
			    (and attrs (memq (aref (nth 8 attrs) 0)
					     '(?d ?l ?-)))))
		(throw 'special t)))))
      (let ((ext-cat (eshell-search-path "cat")))
	(if ext-cat
	    (throw 'eshell-replace-command
		   (eshell-parse-command (eshell-quote-argument ext-cat) args))
	  (if eshell-in-pipeline-p
	      (error "Eshell's `cat' does not work in pipelines")
	    (error "Eshell's `cat' cannot display one of the files given"))))
    (eshell-init-print-buffer)
    (eshell-eval-using-options
     "cat" args
     '((?h "help" nil nil "show this usage screen")
       :external "cat"
       :show-usage
       :usage "[OPTION] FILE...
Concatenate FILE(s), or standard input, to standard output.")
     (dolist (file args)
       (if (string= file "-")
	   (throw 'eshell-external
		  (eshell-external-command "cat" args))))
     (let ((curbuf (current-buffer)))
       (dolist (file args)
	 (with-temp-buffer
	   (insert-file-contents file)
	   (goto-char (point-min))
	   (while (not (eobp))
	     (let ((str (buffer-substring
			 (point) (min (1+ (line-end-position))
				      (point-max)))))
	       (with-current-buffer curbuf
		 (eshell-buffered-print str)))
	     (forward-line)))))
     (eshell-flush)
     ;; if the file does not end in a newline, do not emit one
     )))
;;**** Git Completion
