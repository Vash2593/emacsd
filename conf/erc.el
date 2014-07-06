;;;;;;;;;
;; Erc ;;
;;;;;;;;;

(require-or-install 'erc)
(require 'erc-tex) ;; Local package
(erc-tex-mode)
(erc-smiley-mode)
(setq erc-log-channels-directory "~/.erc/logs/")
(setq erc-save-buffer-on-part t)
(setq erc-hide-timestamps nil)
(setq erc-log-insert-log-on-open nil)

(defun erc-mode-hook-fct()
  (erc-log-mode)
  (set-input-method "TeX")
  )
(add-hook 'erc-mode-hook 'erc-mode-hook-fct)
