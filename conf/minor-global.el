(require-or-install 'ace-jump-mode)
(global-set-key (kbd "C-0") 'ace-jump-mode)

(require 'globalff)
(global-set-key (kbd "C-z f") 'globalff)

(require-or-install 'autopair)
(autopair-global-mode)

(require-or-install 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
