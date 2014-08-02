;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load path for Emacs ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")))
;; The melpa repo
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Move elpa dir. Previously to distant server. Too long to start
(setq elpa-dir "~/.emacs.d/elpa/") ;; If file ssh:/emacs@od:emacsd exists load it.
(setq package-user-dir elpa-dir)

;; Set elpa dir to =elpa-dir=.
(let ((default-directory elpa-dir))
  (normal-top-level-add-subdirs-to-load-path))

(let ((default-directory "~/.emacs.d/lisp"))
  (normal-top-level-add-subdirs-to-load-path))
(load-file "~/.emacs.d/lisp/personal-functions.el")
(add-to-list 'load-path "~/.emacs.d/lisp")
;; FIXME: (add-to-list 'load-path "~/.emacs.d/erc-5.3-extras")
;; FIXME: (add-to-list 'load-path "~/git/expand-region")
;; FIXME: (add-to-list 'load-path "~/.opt/share/emacs/24.3.50/lisp/org")
