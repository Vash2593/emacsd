;; -*- mode: Lisp eval: (rainbow-mode) -*-
(deftheme moarel
  "A theme.")
;; See http://www.emacswiki.org/emacs/color-theme-black-purple.el
(let ((class '((class color) (min-colors 89))))
  (custom-theme-set-faces
   'moarel
   `(default ((,class (:background "black" :foreground "#999"))))
   `(cursor ((t (:background "#6600ff"))))
   ;; Magit
   `(secondary-selection ((, class (:foreground "#00a"))))
   `(magit-header ((, class (:foreground "tomato" :background "black"))))
   `(magit-diff-add ((, class (:background "black" :foreground "#0f0"))))
   `(magit-diff-del ((, class (:background "black" :foreground "#f00"))))
   `(magit-log-head-label-tags ((, class (:background "black" :foreground "#f33" :box 1))))
   `(magit-diff-hunk-header ((, class (:background "#222"))))
   `(diff-header ((, class (:background "#222"))))
   `(magit-diff-file-header ((, class (:background "#002"))))
   `(diff-file-header ((, class (:background "#002"))))
   `(magit-item-highlight ((t (:background "#111"))))
   `(magit-section-title ((t (:background "#330033" :background "black"))))
   `(magit-log-sha1 ((t (:foreground "#f33" ))))
   `(magit-log-graph ((t (:foreground "tomato")))) ;; FIXME: Ugly
   `(magit-log-head-label-remote ((t (:background "black" :foreground "#060" :box 1))))
   `(magit-log-head-label-local ((t (:background "black" :foreground "#00a" :box 1))))
   `(magit-menu-selected-option ((t (:foreground "orange"))))
   `(diff-indicator-added ((, class (:background "black" :foreground "#0f0"))))
   `(diff-added ((, class (:background "black" :foreground "#0f0"))))
   `(diff-indicator-removed ((, class (:background "black" :foreground "#f00"))))
   `(diff-removed ((, class (:background "black" :foreground "#f00"))))

   `(ediff-even-diff-B ((, class (:background "#101010" :foreground "#0f0"))))
   `(ediff-odd-diff-B ((, class (:background "#101010" :foreground "#f00"))))

   `(ediff-even-diff-A ((, class (:background "#101010" :foreground "#f00"))))
   `(ediff-odd-diff-A ((, class (:background "#101010" :foreground "#0f0"))))
   ))
(provide-theme 'moarel)
