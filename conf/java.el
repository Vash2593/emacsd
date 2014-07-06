;;;;;;;;;;
;; Java ;;
;;;;;;;;;;

;; Require ;;
(require 'eclim) ;; Local
(require 'eclimd) ;; Local
(require 'ffap-java) ;; Local

;;;;;;;;;;;;;;;;;;;
;; Bind some key ;;
;;;;;;;;;;;;;;;;;;;
(defun java-mode-keys
    (progn
      (local-set-key (kbd "C-c i") 'eclim-java-import-organize)
      ))
(add-hook 'java-mode-hook 'java-mode-keys)


;; Package configuration variables
;(setq eclim-root-dir "~/dl/eclipse/")
;(setq eclim-executable "~/dl/eclipse/plugins/org.eclim_2.2.5/bin/eclim")
;(setq eclimd-default-workspace "~/git/") ;; Default Workspace for eclim

;; Ffap for java
(add-to-list 'ffap-java/source-directories "~/git/dctc/src/core/java")
(add-to-list 'ffap-java/source-directories "~/git/dctc/src/core/test")
(add-to-list 'ffap-java/source-directories "~/git/dctc/src/dctc/java")
(add-to-list 'ffap-java/source-directories "~/git/dctc/src/dctc/test")
