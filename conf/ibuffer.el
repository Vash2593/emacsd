;;;;;;;;;;;;;
;; IBuffer ;;
;;;;;;;;;;;;;
;; Use it by default
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Modify the default ibuffer-formats
(setq ibuffer-formats
      '((mark modified read-only " "
              (name 18 18 :left :elide)
              " "
              (mode 16 16 :left :elide)
              " "
              filename-and-process)))
;; Set groups
(autoload 'ibuffer "ibuffer" "List buffers." t)
(setq ibuffer-default-sorting-mode 'major-mode)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("Common"
                (or
                 (name . "\\*eshell\\*")
                 (name . "\\*Find\\*")
                 (name . "\\*grep\\*")
                 ))
               ("Git"
                (or
                 (name . "^\\*magit: *")))
               ("dired" (mode . dired-mode))
               ("C,C++"
                (or
                 (mode . c++-mode)
                 (mode . -mode)
                 ))
               ("M4"
                (or
                 (mode . m4-mode)
                 ))
               ("Makefile &Co"
                (or
                 (mode . makefile-mode)
                 (mode . autoconf-mode)
                 )
                )
               ("Java"
                (or
                 (mode . java-mode)
                 ))
               ("JavaScript"
                (or
                 (mode . js2-mode)))
               ("Xml"
                (or
                 (mode . nxml-mode)
                 ))
               ("Shell scripts"
                (or
                 (mode . shell-script-mode)
                 ))
               ("Csv"
                (or
                 (mode . csv-mode)
                 ))
               ("{E,}Lisp"
                (or
                 (mode . emacs-lisp-mode)
                 (mode . lisp-mode)
                 ))
               ("Perl"
                (or
                 (mode . cperl-mode)
                 ))
               ("Python"
                (or
                 (mode . python-mode)
                 ))
               ("Org"
                (or
                 (mode . org-mode)
                 ))
               ("erc" (mode . erc-mode))
               ("Conf"
                (or
                 (mode . conf-mode)
                 (name . "^.*rc")
                 ))
               ("Watch"
                (or
                 (mode . sauron-mode)
                 ))
               ("Net"
                (or
                 (mode . w3m-mode)
                 ))
               ("Wo-Man"
                (or
                 (mode . Man-mode)
                 (name . "\\*Woman*")
                 ))
               ("Documents"
                (or
                 (mode . doc-view-mode)
                 ))
               ("Compilation"
                (or
                 (name . "\\*eclim*")
                 (mode . compilation-mode)
                 ))
               ("Tramp Connections"
                (or
                 (name . "\\*tramp*")
                 ))
               ("Magit"
                (or
                 (name . "\\*magit*")
                 ))
               ("emacs"
                (or
                 (name . "^\\*scratch\\*$")
                 (name . "^\\*Messages\\*$")
                 (name . "\\*Completions\\*")
                 (name . "\\*Backtrace\\*")
                 (name . "\\*Compile-Log\\*")
                 ))
               ))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))
(setq ibuffer-show-empty-filter-groups nil)
(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-auto-mode 1)
             (ibuffer-switch-to-saved-filter-groups "home")))
