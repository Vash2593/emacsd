;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load path for Emacs ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")))
;; The melpa repo
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(setq elpa-dir "~/.emacs.d/elpa/")
(setq package-user-dir elpa-dir)

(require-or-install 'tramp) ;; We need tramp for the next line
(let ((default-directory elpa-dir))
      (normal-top-level-add-subdirs-to-load-path))
(let ((default-directory "~/.emacs.d/lisp"))
  (normal-top-level-add-subdirs-to-load-path))
(load-file "~/.emacs.d/lisp/personal-functions.el")
;; FIXME: (load-file "~/.emacs.d/ws-trim.el")
;(load-file "~/.emacs.d/doc-mode.el")
;(add-to-list 'load-path "~/git/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/lisp/multiple-cursors")
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/erc-5.3-extras")
(add-to-list 'load-path "~/git/expand-region")
(add-to-list 'load-path "~/.opt/share/emacs/24.3.50/lisp/org")
