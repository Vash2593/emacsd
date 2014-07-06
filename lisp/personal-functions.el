;; but: Contains personal function
(defun prev-window ()
  (interactive)
  (other-window -1))
(defun my-move-end-of-line ()
  (interactive)
  (skip-syntax-forward "^<" (line-end-position))
  (skip-syntax-backward " " (line-beginning-position)))
(defun copy-line (&optional arg)
  "Do a kill-line but copy rather than kill.  This function directly calls
kill-line, so see documentation of kill-line for how to use it including prefix
argument and relevant variables.  This function works by temporarily making the
buffer read-only, so I suggest setting kill-read-only-ok to t."
  (interactive "P")
  (toggle-read-only 1)
  (kill-line arg)
  (toggle-read-only 0))
(defun rename-file-and-buffer (new-name)

  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive
   (progn
     (if (not (buffer-file-name))
         (error "Buffer '%s' is not visiting a file!" (buffer-name)))
     (list (read-file-name (format "Rename %s to: " (file-name-nondirectory
                                                     (buffer-file-name)))))))
  (if (equal new-name "")
      (error "Aborted rename"))
  (setq new-name (if (file-directory-p new-name)
                     (expand-file-name (file-name-nondirectory
                                        (buffer-file-name))
                                       new-name)
                   (expand-file-name new-name)))
  ;; If the file isn't saved yet, skip the file rename, but still update the
  ;; buffer name and visited file.
  (if (file-exists-p (buffer-file-name))
      (rename-file (buffer-file-name) new-name 1))
  (let ((was-modified (buffer-modified-p)))
    ;; This also renames the buffer, and works with uniquify
    (set-visited-file-name new-name)
    (if was-modified
        (save-buffer)
      ;; Clear buffer-modified flag caused by set-visited-file-name
      (set-buffer-modified-p nil))
    (message "Renamed to %s." new-name)))
(defun dup-line ()
  "Duplicates the line on which point lies."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let ((begin (point)))
      (forward-line)
      (copy-region-as-kill begin (point))
      (yank)
      (forward-line -1)
      (back-to-indentation))))
(defun kill-current-line ()
  "Deletes the current line"
  (interactive)
  (beginning-of-line)
  (kill-line)
  (kill-line))
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))
(defun standard-minor-mode
  (interactive)
  (lambda ()
    (hs-minor-mode)
    (flyspell-prog-mode)
    (global-set-key (kbd "C-c C-c") 'comment-region)
    (global-set-key (kbd "C-<space> C-c C-c") 'uncomment-region)
    (turn-on-fic-mode)
    (add-hook 'local-write-file-hooks
              (lambda ()
                (copyright-update)))
    (c-toggle-hungry-state) ;; Delete all space before and after the point using
    ))

(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(defun chmod (mode)
  "Set the mode of the current file, in octal, as per the chmod program.
If the current file doesn't exist yet the buffer is saved to create it."
  (interactive "sMode (3 or 4 octal digits): ")
  (or (string-match "[0-3]?[0-7][0-7][0-7]" mode)
      (error "Invalid mode"))
  ;; make sure the file exists
  (unless (file-exists-p (buffer-file-name))
    (save-buffer))
  (set-file-modes (buffer-file-name) (string-to-number mode 8)))
 (eval-after-load "em-ls"
    '(progn
       (defun ted-eshell-ls-find-file-at-point (point)
         "RET on Eshell's `ls' output to open files."
         (interactive "d")
         (find-file (buffer-substring-no-properties
                     (previous-single-property-change point 'help-echo)
                     (next-single-property-change point 'help-echo))))

       (defun pat-eshell-ls-find-file-at-mouse-click (event)
         "Middle click on Eshell's `ls' output to open files.
 From Patrick Anderson via the wiki."
         (interactive "e")
         (ted-eshell-ls-find-file-at-point (posn-point (event-end event))))

       (let ((map (make-sparse-keymap)))
         (define-key map (kbd "RET")      'ted-eshell-ls-find-file-at-point)
         (define-key map (kbd "<return>") 'ted-eshell-ls-find-file-at-point)
         (define-key map (kbd "<mouse-2>") 'pat-eshell-ls-find-file-at-mouse-click)
         (defvar ted-eshell-ls-keymap map))

       (defadvice eshell-ls-decorated-name (after ted-electrify-ls activate)
         "Eshell's `ls' now lets you click or RET on file names to open them."
         (add-text-properties 0 (length ad-return-value)
                              (list 'help-echo "RET, mouse-2: visit this file"
                                    'mouse-face 'highlight
                                    'keymap ted-eshell-ls-keymap)
                              ad-return-value)
         ad-return-value)))
(require 'cl)

(defun server-eshell ()
  "Command to be called by emacs-client to start a new shell.

A new eshell will be created. When the frame is closed, the buffer is deleted or the shell exits,
then hooks will take care that the other actions happen. For example, when the frame is closed,
then the buffer will be deleted and the client disconnected.

Also creates a local binding of 'C-x #' to kill the buffer."
  (lexical-let ((buf (eshell t))
                (client (first server-clients))
                (frame (selected-frame)))
    (labels ((close (&optional arg)
                (when (not (boundp 'cve/recurse))
                  (let ((cve/recurse t))
                    (delete-frame frame)
                    (kill-buffer buf)
                    (server-delete-client client)))))
    (add-hook 'eshell-exit-hook #'close t t)
    (add-hook 'delete-frame-functions #'close t t))
    (local-set-key (kbd "C-x #") (lambda () (interactive) (kill-buffer buf)))
    (delete-other-windows)
    nil))
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
;;  LocalWords:  defun LocalWords ok arg
