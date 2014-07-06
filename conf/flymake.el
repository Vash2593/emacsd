(require-or-install 'flymake)
(add-hook 'java-mode-hook 'flymake-mode-on)


(defun my-java-flymake-init ()
  (list "javac" (list (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-with-folder-structure))))

;(add-to-list 'flymake-allowed-file-name-masks '("\\.java$" my-java-flymake-init flymake-simple-cleanup))
