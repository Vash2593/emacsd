(require-or-install 'org)
(setq org-default-notes-files "~/notes.org")
(global-set-key (kbd "C-c c") 'org-capture)

(setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline "~/notes.org" "Tasks")
         "* TODO %?\n %T\n %a")
        ("n" "Notes" entry (file+headline "~/notes.org" "Notes")
         "* %?\n%T\n")
        ("s" "Scheduled Tasks" entry (file+headline "~/notes.org" "Tasks")
         "* TODO %?\nSCHEDULED: %^t\n %a")
        ("d" "Deadline Tasks" entry (file+headline "~/notes.org" "Tasks")
         "* TODO %?\nDEADLINE: %^t\n %a")
        )
      )

;; Agenda
(setq org-agenda-files '("~/notes.org" "~/my.org.gpg"))
(global-set-key (kbd "C-c a L") 'org-timeline)


;; Take a note when an item is switched to DONE
(setq org-log-done 'note)

;; Export ui for export in org-mode
(setq org-export-dispatch-use-expert-ui t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (clojure . t)
   (C . t)
   (perl . t)
   (ruby . t)
   (sh . t)
   (python . t)
   (emacs-lisp . t)
   (R . t)
   (ocaml . t)
   ))

;; Fontify
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(global-set-key (kbd "C-c a") 'org-agenda)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (sh . t)
   (R . t)
   (perl . t)
   (ruby . t)
   (python . t)
   (js . t)
   (haskell . t)
   (clojure . t)
   (ditaa . t)))
(setq org-confirm-babel-evaluate nil)
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

(add-hook 'org-mode-hook (lambda () (org-indent-mode)))
