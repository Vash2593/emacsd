;;;;;;;;;;;;;;;;;
;; Compilation ;;
;;;;;;;;;;;;;;;;;
;; Stop on the first error
(setq compilation-scroll-output 'first-error)
(add-hook 'compilation-mode-hook
          (lambda ()
             (global-set-key (kbd "<f6>") 'previous-error)
             (global-set-key (kbd "<f7>") 'next-error))
          )

(setq compile-command "make -j3")
(setq-default display-buffer-reuse-frames t) ;; FIXME: Wrong place
