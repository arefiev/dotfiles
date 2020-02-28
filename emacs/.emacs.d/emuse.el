;(setq planner-use-other-window nil) ; Really annoying.
(setq muse-html-extension ".html")
(setq muse-file-extension "")

(setq muse-project-alist
   '(("Knowledge"
      ("~/Muse" :default "Index")
      (:base "html" :path "~/public_html/Muse")
      )
     ("SwordSpell"
      ("~/projects/games/swsp/docs" :default "ideas.txt")
      (:base "html" :path "~/projects/games/swsp/docs")
      )
     ))

(add-hook 'muse-mode-hook
          '(lambda ()
             ;; Make Emacs Muse look better.
             (set-face-foreground 'muse-link     "light sea green")
             (set-face-foreground 'muse-bad-link "light coral")
             (set-face-font 'muse-header-1 "Terminus-24:bold")
             (set-face-font 'muse-header-2 "Terminus-22:bold")
             (set-face-font 'muse-header-3 "Terminus-20:bold")
             (set-face-font 'muse-header-4 "Terminus-18:bold")
             (set-face-font 'muse-header-5 "Terminus-16:bold")
             ;; Commit to repository, an appropriate Makefile should be present.
             (define-key muse-mode-map "\C-c\C-c"
               '(lambda ()
                  (interactive)
                  (message "Commit:\n %s" (shell-command-to-string
                                           (concat "cd "
                                                   (caadr muse-current-project)
                                                   "; make commit ; make push")))))
             ;; Update from repository, an appropriate Makefile should be present.
             (define-key muse-mode-map "\C-c\C-u"
               '(lambda ()
                  (interactive)
                  ;; Project path is (caadr muse-current-project)
                  (message "Update:\n %s" (shell-command-to-string
                                           (concat "cd "
                                                   (caadr muse-current-project)
                                                   "; make update")))))
             (define-key muse-mode-map [9]  'yas/expand)
             (define-key muse-mode-map [tab] 'yas/expand)))
;             (define-key muse-mode-map "\t"
;               '(lambda ()
;                  (interactive)
;                  (yas/expand)))))

(defun know ()
  (interactive)
  (find-file "~/Muse/Index"))

(defun prog ()
  (interactive)
  (find-file "~/Muse/PLIndex"))

(defun tobuy ()
  (interactive)
  (find-file "~/Muse/ToBuy"))


