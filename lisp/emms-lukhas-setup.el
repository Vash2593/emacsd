(require 'emms-setup)

(emms-devel)

(setq emms-mode-line-titlebar-function 'emms-mode-line-playlist-current)

(setq emms-show-format "NP: %s")

(setq emms-stream-info-format-string "NS: %s")
(setq emms-stream-default-action "play")
(setq emms-stream-popup-default-height 120)

;(define-emms-simple-player spc '(file) (regexp-opt '(".spc" ".SPC")) "ospc" "-l" "-t " "3:00")

(setq emms-player-list
      '(
        emms-player-mplayer
        emms-player-ogg123
        emms-player-mplayer-playlist
        emms-player-vlc))


(setq emms-player-mplayer-parameters (list "-slave" "-nortc" "-quiet" "-really-quiet"))

;; Icon setup.

(setq emms-mode-line-icon-before-format "["
      emms-mode-line-format " %s]"
      emms-mode-line-icon-color "lightgrey")

(require 'emms-mode-line-icon)

(defun emms-mode-line-icon-function ()
  (concat " "
          emms-mode-line-icon-before-format
          (propertize "NP:" 'display emms-mode-line-icon-image-cache)
          (format emms-mode-line-format (emms-track-get
                                         (emms-playlist-current-selected-track)
                                         'info-title))))

(setq emms-playlist-buffer-name "*EMMS Playlist*"
      emms-playlist-mode-open-playlists t)

;; Libtag support
(require 'emms-info-libtag)
(setq emms-info-functions '(emms-info-libtag))

;; Stolen and adapted from TWB
(defun my-emms-info-track-description (track)
  "Return a description of the current track."
  (if (and (emms-track-get track 'info-artist)
           (emms-track-get track 'info-title))
      (let ((pmin (emms-track-get track 'info-playing-time-min))
            (psec (emms-track-get track 'info-playing-time-sec))
            (ptot (emms-track-get track 'info-playing-time))
            (art  (emms-track-get track 'info-artist))
            (tit  (emms-track-get track 'info-title)))
        (cond ((and pmin psec) (format "%s - %s [%02d:%02d]" art tit pmin psec))
              (ptot (format  "%s - %s [%02d:%02d]" art tit (/ ptot 60) (% ptot 60)))
              (t (emms-track-simple-description track))))))

(setq emms-track-description-function 'my-emms-info-track-description)


;; caching stuff
(setq later-do-interval 0.001
      emms-info-asynchronously nil)

;(global-set-key (kbd "<f2>")   'emms-smart-browse)

(defun my-emms-browser-covers (path size)
  (let* ((files  (directory-files (file-name-directory path)))
         (covr (catch :found
                 (dolist (item files)
                   (if (string-match "^cover_med.jpg$" item)
                       (throw :found item))))))
    (if covr
        (concat (file-name-directory path) covr))))

(setq emms-browser-covers 'my-emms-browser-covers
      emms-browser-default-covers '(nil nil nil))

(emms-browser-make-filter "Musique" (emms-browser-filter-only-dir "~/music"))
(emms-browser-make-filter "Torrent" (emms-browser-filter-only-dir "~/.torrent"))

(defun my-turn-off-covers-for-singles ()
  (if (string= emms-browser-current-filter-name "Singles")
      (setq emms-browser-covers nil)
    (setq emms-browser-covers 'my-emms-browser-covers)))

(add-hook 'emms-browser-filter-changed-hook 'my-turn-off-covers-for-singles)

(provide 'emms-lukhas-setup)
