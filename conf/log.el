;;;;;;;;;;
;; Logs ;;
;;;;;;;;;;
(defun log4j-mode-hook-fct()
  (auto-revert-tail-mode)
  )
(add-hook 'log4j-mode-hook 'log4j-mode-hook-fct)

(add-to-list 'auto-mode-alist '(".log4j" . log4j-mode))
