;;;;;;;;;
;; Git ;;
;;;;;;;;;

;;;;;;;;;;;;
;; MagGit ;;
;;;;;;;;;;;;
(add-to-list 'load-path "~/git/magit/")
(require-or-install 'magit)
(setq magit-log-auto-more t)
(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-c b") 'magit-blame-mode)


;;;;;;;;;;;;;;;;;
;; git-gutter+ ;;
;;;;;;;;;;;;;;;;;
(require-or-install 'git-gutter+)
(global-git-gutter+-mode)
(setq git-gutter+-modified-sign "•")
(setq git-gutter+-added-sign "•")
(setq git-gutter+-deleted-sign "•")
(setq git-gutter+-window-width 1)
(eval-after-load 'git-gutter+
  '(progn
     ;;; Jump between hunks
     (define-key git-gutter+-mode-map (kbd "C-z n") 'git-gutter+-next-hunk)
     (define-key git-gutter+-mode-map (kbd "C-z p") 'git-gutter+-previous-hunk)

     ;;; Act on hunks
     (define-key git-gutter+-mode-map (kbd "C-z v =") 'git-gutter+-show-hunk)
     (define-key git-gutter+-mode-map (kbd "C-z r") 'git-gutter+-revert-hunks)
     ;; Stage hunk at point.
     ;; If region is active, stage all hunk lines within the region.
     (define-key git-gutter+-mode-map (kbd "C-x s") 'git-gutter+-stage-hunks)
     ))


;;;;;;;;;;;;
;; GitHub ;;
;;;;;;;;;;;;
(require-or-install 'gist)
