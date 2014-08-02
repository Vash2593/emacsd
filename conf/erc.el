;;;;;;;;;
;; Erc ;;
;;;;;;;;;

(require-or-install 'erc)
(require 'erc-tex) ;; Local package
(require 'erc-youtube)
(require-or-install 'erc-image)
(require-or-install 'erc-tweet)

(erc-tex-mode)
(erc-smiley-mode)
(setq erc-log-channels-directory "~/.erc/logs/")
(setq erc-save-buffer-on-part t)
(setq erc-hide-timestamps nil)
(setq erc-log-insert-log-on-open nil)

(add-to-list 'erc-modules 'image)
(add-to-list 'erc-modules 'tweet)
(add-to-list 'erc-modules 'youtube)
; (erc-update-modules)

(defun erc-mode-hook-fct()
  (erc-log-mode)
  (set-input-method "TeX")
  )
(add-hook 'erc-mode-hook 'erc-mode-hook-fct)
