;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modify the face of Emacs ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Delete useless display
(scroll-bar-mode -1)
(tool-bar-mode 0)
;; No menu bar
(menu-bar-mode -1)
;; Show Column/Line
(column-number-mode t)
(line-number-mode t)
;; Default font size
(set-face-attribute 'default nil :height 85)
