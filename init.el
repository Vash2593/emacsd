;; -*- mode: Lisp eval: (rainbow-mode) -*-
;; Emacs configuration
;; Time-stamp: <2014-07-06 13:09:32 vash>

;; Bootstrap
(load-file "~/.emacs.d/conf/functions.el")
(load-file "~/.emacs.d/conf/paths.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (moarel)))
 '(custom-safe-themes
   (quote
    ("8a0bf18d99c8cd208c4a00388c83496afa149a66e14aba9cdd7f5b7334a8842d" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Ok, let's start all module needed.
;; For all systems, load these configuration files.
(load-file "~/.emacs.d/conf/minor-global.el")
(load-file "~/.emacs.d/conf/ibuffer.el")
(load-file "~/.emacs.d/conf/general.el")
(load-file "~/.emacs.d/conf/pers.el")
(load-file "~/.emacs.d/conf/global.el")
(load-file "~/.emacs.d/conf/face.el")
(load-file "~/.emacs.d/conf/erc.el")
(when (string= system-name "alia")
  (progn
    (load-file "~/.emacs.d/conf/compilation.el")
    (load-file "~/.emacs.d/conf/ediff.el")
    (load-file "~/.emacs.d/conf/eshell.el")
    (load-file "~/.emacs.d/conf/flymake.el")
    (load-file "~/.emacs.d/conf/ggtags.el")
    (load-file "~/.emacs.d/conf/git.el")
    (load-file "~/.emacs.d/conf/java.el")
    (load-file "~/.emacs.d/conf/log.el")
    (load-file "~/.emacs.d/conf/org-mode.el")
    (load-file "~/.emacs.d/conf/prog.el")
    (load-file "~/.emacs.d/conf/protobuf.el")
    (load-file "~/.emacs.d/conf/sauron.el")
    (load-file "~/.emacs.d/conf/shell.el")
    (load-file "~/.emacs.d/conf/yasnippet.el")
    (load-file "~/.emacs.d/conf/triggers.el")
    (load-file "~/.emacs.d/conf/emms.el")
    )
  )
