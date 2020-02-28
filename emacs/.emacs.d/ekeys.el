;;; Global keybindings.

;; Quick switching to certain activities.
(global-set-key (kbd "C-c k") 'know)
(global-set-key (kbd "C-c p") 'prog)
(global-set-key (kbd "C-c g") 'gtd)
;(global-set-key (kbd "C-c b") 'tobuy)
(global-set-key (kbd "C-c b") 'sr-speedbar-toggle)

;; Text editing and browsing.
(global-set-key (kbd "C-w")               'backward-kill-word)
(global-set-key (kbd "C-x C-k")           'kill-region)
(global-set-key (kbd "C-x t")             'beginning-of-buffer)
(global-set-key (kbd "C-x e")             'end-of-buffer)
(global-set-key (kbd "M-o")               'other-window)
(global-set-key (kbd "C-%")               'jump-to-matching-paren)
(global-set-key (kbd "C-x C-M-l")         'downcase-region) ; Instead of C-x C-l
(global-set-key (kbd "C-x C-M-u")         'upcase-region)   ; Instead of C-x C-u

;; Unset disastrous stuff that is easily hit by accident.
(global-unset-key (kbd "C-x M-l")) ; Was downcase-word
(global-unset-key (kbd "C-x C-l")) ; Was downcase-region (especially annoying).
(global-unset-key (kbd "C-<f10>")) ; (toggle-menu-bar-mode-from-frame &optional ARG)
(global-unset-key (kbd "S-<f10>")) ; (toggle-menu-bar-mode-from-frame &optional ARG)
(global-unset-key (kbd "M-<f10>")) ; (toggle-menu-bar-mode-from-frame &optional ARG)

;; Help on current word.
(global-set-key [f1] (lambda () (interactive)  (manual-entry  (current-word))))

;; Programming keys common to all or almost all modes.
(global-set-key [C-f3] 'next-error)
(global-set-key [C-f4] 'previous-error)
(global-set-key [f9]   'compile)
(global-set-key (kbd "C-<f9>")   '(lambda ()
                                    (interactive)
                                    (ignore-errors
                                      (process-kill-without-query
                                       (get-buffer-process
                                        (get-buffer "*compilation*"))))
                                    (recompile)))

;; Misc functions.
(global-set-key (kbd "<f10>")   'menu-bar-open)
(global-set-key (kbd "S-<f10>") 'toggle-menu-bar-mode-from-frame)
(global-set-key (kbd "C-<f10>") 'toggle-menu-bar-mode-from-frame)
(global-set-key (kbd "M-<f10>") 'toggle-menu-bar-mode-from-frame)
(global-set-key (kbd "S-<f7>")  'previous-emacs-buffer) ; Shift+f7
(global-set-key (kbd "S-<f8>")  'next-emacs-buffer) ; Shift+f8

;; Switching to different fancy input methods.
(global-set-key [f6] '(lambda () (interactive) (set-input-method "cyrillic-dvorak")))
(global-set-key [f7] '(lambda () (interactive) (if (equal default-input-method "japanese")
						    (set-input-method "japanese-hiragana")
						    (if (equal default-input-method "japanese-hiragana")
							(set-input-method "japanese-katakana")
						        (set-input-method "japanese")))))
(global-set-key [f8] '(lambda () (interactive) (set-input-method "greek")))

;; Buffers, frames and windows.
(global-set-key (kbd "C-x 7") 'make-frame)
(global-set-key (kbd "C-x &") 'make-frame)

;; Projects (sets of buffers and frames).
(global-set-key (kbd "C-c 8 s") 'project-save)
(global-set-key (kbd "C-c * s") 'project-save)
(global-set-key (kbd "C-c 8 l") 'project-load)
(global-set-key (kbd "C-c * l") 'project-load)
(global-set-key (kbd "C-c 8 a") 'project-save-as)
(global-set-key (kbd "C-c * a") 'project-save-as)

;; Quitting.
;; Require C-x C-c prompt. I've closed too often by accident.
;; http://www.dotemacs.de/dotfiles/KilianAFoth.emacs.html
(global-set-key [(control x) (control c)]
		(function
		 (lambda () (interactive)
		   (cond ((y-or-n-p "Quit? ")
			  (save-buffers-kill-emacs))))))

;; org-mode, remember-mode
(define-key global-map (kbd "C-c L") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(global-set-key        (kbd "C-c r") 'remember)
(global-set-key        (kbd "C-c R") 'wicked/remember-review-file)

;; Insert data into buffers.
(global-set-key (kbd "C-c d") 'insert-date)
(global-set-key (kbd "C-c t") 'insert-time)

;; Insert UUIDs.
(global-set-key (kbd "C-c u t") 'insert-uuid1)
(global-set-key (kbd "C-c u r") 'insert-uuid4)


;; Add Russian y/n (dvorak).
(define-key query-replace-map "е" 'act)
(define-key query-replace-map "д" 'quit)

;; Misc.
(global-set-key (kbd "<f5>") 'call-last-kbd-macro)
