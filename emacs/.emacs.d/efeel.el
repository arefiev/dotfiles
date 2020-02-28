;;; «Feel».

;; Use y/n instead of annoying yes/no.
(fset 'yes-or-no-p 'y-or-n-p)

;; Use text-mode instead of emacs-lisp-mode by default.
(setq default-major-mode 'text-mode)                             

;; No tiny windows.
(setq window-min-height 3)

;; Unless some debugging is made:
(kill-buffer "*Messages*")

;; Instead of yanking at mouse cursor.
(setq mouse-yank-at-point t)

;; scrolling stuff
(setq scroll-conservatively 100
      scroll-preserve-screen-position t
      scroll-margin 8)
;(load "accel" t t) ;;;; accelerate cursor while scrolling

;; Make cursor stay in the same column when scrolling using pgup/dn.
;; Previously pgup/dn clobbers column position, moving it to the
;; beginning of the line.
;; http://www.dotemacs.de/dotfiles/ElijahDaniel.emacs.html
(defadvice scroll-up (around ewd-scroll-up first act)
  "Keep cursor in the same column."
  (let ((col (current-column)))
    ad-do-it
    (move-to-column col)))

;; Partially completing interactive functions on M-x.
(if (>= 24 (string-to-int
	    (car
	     (split-string
	      (nth 3 (split-string (version) " "))
	      "\\." ))))
    (prog1
      (message "Loading partial completion for 24 or newer")
      (setq completion-word-extra-chars '(" " "-"))
      ;(setq completion-styles '(partial-completion initials))
      (setq completion-styles '(partial-completion initials))
      (setq completion-pcm-complete-word-inserts-delimiters t)
      (setq completion-cycle-threshold 3)
      )
    (prog1
      (message "Loading partial completion for 23 or or earlier")
      (partial-completion-mode t)))

;; Avoid mouse cursor when typing.
;(mouse-avoidance-mode 'jump)

;; Intellectually switch buffers.
(require 'iswitchb)
;(iswitchb-default-keybindings)

;; Turn the highly annoying beeps off.
(setq visible-bell t)
(defun dummy-ring-bell-function () "Replaces the default annoying function" 
  nil)
(setq ring-bell-function 'dummy-ring-bell-function)

;; Interactively find files.
(ido-mode t)
(setq ido-default-file-method   'selected-window
      ido-default-buffer-method 'selected-window
      iswitchb-default-method   'samewindow)

;; `inhibit-same-window' -- A non-nil value prevents the same
;;                          window from being used for display.
;;
;; `inhibit-switch-frame' -- A non-nil value prevents any other
;;                           frame from being raised or selected,
;;                           even if the window is displayed there.
;;
;; `reusable-frames' -- Value specifies frame(s) to search for a
;;                      window that already displays the buffer.
;;                      See `display-buffer-reuse-window'.


;; For help pages, *compile* etc to reuse existing windows in frames.
;; Good for two monitors.
;; http://stackoverflow.com/questions/16650937/reuse-compilation-window-in-another-frame
(setq display-buffer-alist nil)
(add-to-list
 'display-buffer-alist
 '("\\*compilation\\*" . (display-buffer-reuse-window
                          ((reusable-frames . t) ; ?
                           (inhibit-same-window . t) ; ??
                           (inhibit-switch-frame . t) ; ???
))))
(setq display-buffer-reuse-frames t) ; TODO TEMP.

