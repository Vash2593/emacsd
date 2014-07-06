;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General and Location Configurations ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;; {I|Fly}Spell ;;
;;;;;;;;;;;;;;;;;;
;; Set to American the default dictionary
(setq ispell-dictionary "american")

(defun insert-fr-question-mark ()
  (interactive)
  "Insert a question mark « à la mode française »"
  (ucs-insert 160)
  (ucs-insert 63))

(defun insert-fr-colon ()
  (interactive)
  "Insert a colon « à la mode française »"
  (ucs-insert 202) ;; 160
  (ucs-insert 58))

(defun insert-fr-semi-colon ()
  (interactive)
  "Insert a semi-colon « à la mode française »"
  (ucs-insert 160)
  (ucs-insert 59))

(defun insert-fr-quote-marks ()
  (interactive)
  "Insert quotes « à la mode française »"
  ;; Insert the opening mark
  (ucs-insert ?«)
  (ucs-insert 160)
  ;; The closing mark
  (ucs-insert 160)
  (ucs-insert ?»)
  ;; And place the cursor at the right place
  (backward-char 2)
  )
(defun fr-buffer ()
  (interactive)
  (progn
    (local-set-key (kbd "?") 'insert-fr-question-mark)
    (local-set-key (kbd ":") 'insert-fr-colon)
    (local-set-key (kbd ";") 'insert-fr-semi-colon)
    (local-set-key (kbd "\"") 'insert-fr-quote-marks)
    (autopair-mode) ;; Because sucks with french rules
  ))


;; Default input-method is TeX like
(setq default-input-method "TeX") ;; C-\ to toggle the input-method

;; Respect the case words
(setq dabbrev-case-replace nil)
