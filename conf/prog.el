;;;;;;;;;;;;;;;;;;;;;;;;;
;; Programmation modes ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defun prog-mode-hook-fct ()
  (hs-minor-mode)
  (toggle-truncate-lines)
  (flyspell-prog-mode)
  (setq show-trailing-whitespace t)
  (delete-trailing-whitespace)
;  (save-buffer)
  )
(setq-default c-basic-offset 2)

(global-subword-mode 0) ;; Useful for java buf disable it

;; Hooks
(add-hook 'prog-mode-hook 'prog-mode-hook-fct)
(add-hook 'java-mode-hook (lambda ()
                                (setq c-basic-offset 2)))
(add-hook 'javascript-mode-hook (lambda()
                                  (setq c-basic-offset 2)))
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

