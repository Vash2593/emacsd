;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(require-or-install 'js2-mode)
(require 'uniquify) ;; For better naming style.
(require-or-install 'ffap)
(require-or-install 'hide-comnt)
(require-or-install 'gnuplot)

(global-set-key (kbd "C-z") nil)
(global-unset-key (kbd "C-x 1"))

(global-set-key (kbd "C-c C-/") 'comment-box)
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region) ;; Not by default
(global-set-key (kbd "C-c C-t") 'dup-line)
(global-set-key (kbd "C-c +") 'increment-number-at-point)
(global-set-key (kbd "C-c C-a") 'mark-whole-buffer) ;; Select the whole Buffer
(global-set-key (kbd "C-x 1") 'eshell) ;; Start Eshell
(global-set-key (kbd "C-x c") 'prev-window)
(global-set-key (kbd "C-<tab>") 'hs-hide-level)
(global-set-key (kbd "<backtab>") 'hs-toggle-hiding)

(global-set-key (kbd "C-'") 'find-file-at-point)
(global-set-key (kbd "C-c k") 'kill-current-line) ;; Kill the current line.
(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "C-z k") 'balance-windows)
(global-set-key (kbd "C-c h") 'ff-find-other-file)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)

(global-set-key (kbd "C-c @ L") 'hs-show-all)
(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key [f11] 'toggle-fullscreen)



;; Set the windows move with the meta key
(windmove-default-keybindings nil)

;; Tabulation are evil
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4) ;; Build set it to two when found

;; Revert when file modified on disk.
(global-auto-revert-mode 1)
;; And don't ask for it.
(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))
(global-set-key (kbd "C-z o") 'ffap)


;; Buffer names
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

(add-hook 'write-file-hooks 'time-stamp) ;; Timestamp writing
(display-time)


;;;;;;;;;;;;;;
;; Behavior ;;
;;;;;;;;;;;;;;
;; Change parenthesis match
(show-paren-mode t)
;; View the trailing white space
;; The cursor don't blink
(blink-cursor-mode -1)
;; End file line check
(setq next-line-add-newlines nil)
(setq require-final-newline t)
;; Use wide cursor
(setq x-stretch-cursor t)
;; Re-set the tabular character
(standard-display-ascii ?\t "	")
;; replace yes by y and no by n
(fset 'yes-or-no-p 'y-or-n-p)
;; Display image
(auto-image-file-mode 1)
;; paste where the cursor is instead of where the mouse is
(setq mouse-yank-at-point t)
(setq mouse-yank-at-click nil)
(setq confirm-nonexistent-file-or-buffer nil) ;; Don't ask for create a new file.
