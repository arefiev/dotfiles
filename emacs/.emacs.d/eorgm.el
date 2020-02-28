;;; org-mode and remember.el
(setq org-gtd-file "~/Muse/gtd.org")
(setq org-agenda-files (list org-gtd-file "~/Muse/someday.org"))

;; Remove stupid holidays altogether.
(setq calendar-holidays nil)

(setq org-startup-folded nil)

(defun gtd ()
  (interactive)
  (find-file org-gtd-file))

;; From orgmode.org and EmacsWiki.
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-todo-keywords '("TODO" "STARTED" "WAITING" "DONE"))
(setq org-agenda-include-diary t)
(setq org-agenda-include-all-todo t)
(setq org-startup-folded nil)
(setq org-remember-templates
      '(("Tasks" ?t "* TODO %?\n  %i\n  %a" org-gtd-file)
        ("Appointments" ?a "* Appointment: %?\n%^T\n%i\n  %a" org-gtd-file)))

(define-key org-mode-map (kbd "C-c C-t")
  '(lambda ()
     (interactive)
     (org-set-tags)))


;; From Sacha Chua's blog
(eval-after-load 'remember
  '(add-hook 'remember-mode-hook 'org-remember-apply-template))
(setq remember-data-file "~/misc.txt")
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))

(defun wicked/remember-review-file ()
  "Open `remember-data-file'."
  (interactive)
  (find-file-other-window remember-data-file))

