;;; «Look».

;; Disable startup message.
(setq inhibit-startup-message t)

;; Disable toolbars.
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)

;; General modes (modeline contents etc).
(line-number-mode 1)
(column-number-mode 1)
(mouse-wheel-mode 1)
(blink-cursor-mode 0)

;; Syntax highlight.
(global-font-lock-mode t)

;; Whitespace highlight.
(show-ws-highlight-trailing-whitespace)

(tabbar-mode)
(setq tabbar-buffer-groups-function
      (lambda (buffer)
        (list "All buffers")))

;; Stolen from Maru Dubshinki.
;; http://en.wikipedia.org/wiki/User:Marudubshinki/.emacs
;; Using cursor color to indicate some modes.  If you sometimes find
;; yourself inadvertently overwriting some text because you are in
;; overwrite mode but you didn't expect so, this might prove as useful
;; to you as it is for me.  It changes cursor color to indicate
;; read-only, insert and overwrite modes:
(setq hcz-set-cursor-color-color ""
      hcz-set-cursor-color-buffer "")
(defun hcz-set-cursor-color-according-to-mode ()
  "change cursor color according to some minor modes."
  ;; set-cursor-color is somewhat costly, so we only call it when
  ;; needed:
  (let ((color
	 (if buffer-read-only "grey"
	   (if overwrite-mode "red"
	     "blue"))))
    (unless (and
	     (string= color hcz-set-cursor-color-color)
	     (string= (buffer-name) hcz-set-cursor-color-buffer))
      (set-cursor-color (setq hcz-set-cursor-color-color color))
      (setq hcz-set-cursor-color-buffer (buffer-name)))))
(add-hook 'post-command-hook 'hcz-set-cursor-color-according-to-mode)

;; Highlight current line.
(setq hl-line-face 'highlight)
(global-hl-line-mode t)
(set-face-foreground 'default "SteelBlue")
(set-background-color "black")
(set-face-background 'hl-line "#0d1828")
(set-face-background 'highlight "#0d1828")

;; Highlight region until some operation.
(setq transient-mark-mode t)

;; Fix junk characters in shell mode.
(add-hook 'shell-mode-hook
          'ansi-color-for-comint-mode-on)

;; Nasty default misconfiguration in 23.0.50.
(setq frame-inherited-parameters '(background-color foreground-color font))

;; Fonts (works with Emacs 23.0.60+)
;(set-default-font "FreeMono-12:bold")
(set-default-font "Terminus-16")
;(set-fontset-font "fontset-default" 'latin '("FreeMono" . "ISO10646-1"))
(set-fontset-font "fontset-default" 'cyrillic-iso8859-5 '("terminus" . "ISO10646-1"))
(set-fontset-font "fontset-default" 'greek-iso8859-7 '("terminus" . "ISO10646-1"))
; '(default ((t (:stipple nil :background "Black" :foreground "SteelBlue" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :family "terminus"))) t)

; Somehow Muse ignores default fonts.
'(
(set-face-font 'muse-header-1 "Terminus-24:bold")
(set-face-font 'muse-header-2 "Terminus-22:bold")
(set-face-font 'muse-header-3 "Terminus-20:bold")
(set-face-font 'muse-header-4 "Terminus-18:bold")
(set-face-font 'muse-header-5 "Terminus-16:bold")
)

;; This is alleged to make Emacs frames (X windows) fade out when
;; losing focus.  http://stackoverflow.com/questions/10914772/
;; It does not, however.
(set-frame-parameter (selected-frame) 'alpha '(100 60))
(push (cons 'alpha '(100 60)) default-frame-alist)
