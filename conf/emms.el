;;;;;;;;;;
;; Emms ;;
;;;;;;;;;;

;; Require
(add-to-list 'load-path "~/git/emms/lisp")
(require-or-install 'emms)
(require 'emms-cover) ;; Local
(setq emms-browser-covers 'emms-cover-find) ;;
(require 'emms-lukhas-setup) ;; Local

;; Needed everywhere
(global-set-key (kbd "C-<f8>") 'emms-pause)
(global-set-key (kbd "C-<f9>") 'emms-previous)
(global-set-key (kbd "C-<f10>") 'emms-next)
(global-set-key (kbd "C-<f2>") 'emms-volume-lower)
(global-set-key (kbd "C-<f3>") 'emms-volume-raise)

;; Insert new musics
(emms-add-directory-tree "~/music/")
(emms-add-directory-tree "~/.torrent")
;; Delete old musics
(emms-cache-sync)
;; Covers
