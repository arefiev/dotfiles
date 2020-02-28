;;; System settings.

;; Save temp files to ~./saves,
;; if not, fix it.
;; Also, enable versioning.
(setq backup-by-copying t
      backup-directory-alist '(("." . "~/.saves"))
      delete-old-versions t
      kept-new-versions 2
      kept-old-versions 2
      version-control t)

;; Automatically decompress .tgz etc.
(auto-compression-mode 1)

;; Set calendar style to European calendar style.  True
(setq european-calendar-style t)

;; Assure my window-configuration is kept (?)
(setq pop-up-windows nil)

;; Add newline to the end of file automatically.
(setq require-final-newline t)

;; UTF8 everything.
(setq locale-coding-system            'utf-8)
(set-terminal-coding-system           'utf-8)
(set-keyboard-coding-system           'utf-8)
(set-selection-coding-system          'utf-8)
(prefer-coding-system                 'utf-8)
(setq default-file-name-coding-system 'utf-8)

;; Cut and paste to X buffer.
(setq x-select-enable-clipboard t)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
(setq default-enable-multibyte-characters 1)
;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
(set-language-environment "UTF-8")

;; Number of bytes processed before invoking GC.
(setq gc-cons-threshold 2000000)

;; Enlarge your stack.
(setq max-lisp-eval-depth 4096)
(setq max-specpdl-size    65536)


;;; Dired mode stuff.
;; (no idea where I stole it)
;; We want dired not to make a new buffer if visiting a directory but
;; to use only one dired buffer for all directories.
(defadvice dired-advertised-find-file (around dired-subst-directory activate)
  "Replace current buffer if file is a directory."
  (interactive)
  (let ((orig (current-buffer))
	(filename (dired-get-filename)))
    ad-do-it
    (when (and (file-directory-p filename)
	       (not (eq (current-buffer) orig)))
      (kill-buffer orig))))

; Using the methods above will still create a new buffer if you invoke
; ^ (dired-up-directory). To prevent this:
(eval-after-load "dired"
  ;; don't remove `other-window', the caller expects it to be there
  '(defun dired-up-directory (&optional other-window)
     "Run Dired on parent directory of current directory."
     (interactive "P")
     (let* ((dir (dired-current-directory))
     	    (orig (current-buffer))
     	    (up (file-name-directory (directory-file-name dir))))
       (or (dired-goto-file (directory-file-name dir))
     	   ;; Only try dired-goto-subdir if buffer has more than one dir.
     	   (and (cdr dired-subdir-alist)
     		(dired-goto-subdir up))
     	   (progn
     	     (kill-buffer orig)
     	     (dired up)
     	     (dired-goto-file dir))))))



;;; Desktop saving and stuff.
(setq desktop-autosave-period 300)

;; Saving and loading sessions
;; with desktop-save.
'(  ; <Comment>
(setq desktop-path (list "~/.emacs.d/desktop/"))
(setq auto-save-default t)
(desktop-save-mode)
;(desktop-load-default)
;(desktop-read)
;; Desktop saving timer.
;; Cast cancel-timer on it if it bores you.
(funcall (lambda ()
  (interactive)
  (if (y-or-n-p "Wanna have fun? ")
      (progn
	(run-with-timer
	 desktop-autosave-period
	 desktop-autosave-period
	 (lambda ()
	   ;(desktop-save (car desktop-path))
	   (dta-save-session "last.sess")
	   (message (concat "Desktop autosave.  Next autosave in: "
			    (int-to-string desktop-autosave-period) "."))))))))
; To cancel timers, press C-x C-e here ↓!
; (map nil 'cancel-timer timer-list)
) ; </Comment>

;; Desktop-Aid (dta).
(setq dta-cfg-dir "~/.emacs.d/desktopaid/")
(setq dta-default-cfg "last.sess")
(setq dta-default-auto nil)
(autoload 'dta-hook-up "desktopaid.el" "Desktop Aid" t)
(setq dta-cfg-dir "~/.emacs.d/desktopaid/")
(setq dta-default-cfg "last.sess")
(setq dta-default-auto nil)
(dta-hook-up)

;;;
;;; Switching between projects with the help of Desktop-Aid!
;;;

;; First, some «globals».
(setq project-default (concat dta-cfg-dir dta-default-cfg))
(setq file-that-holds-cur-project-filename "~/.emacs.d/cur_project")
(setq cur-project-filename project-default)

(defun write-cur-project-file (project-filename)
  (with-temp-buffer
    (insert project-filename)
    (when (file-writable-p cur-project-filename)
      (write-region (point-min)
                    (point-max)
                    file-that-holds-cur-project-filename))))

;; Doesn't exist yet?  Let's write last.sess there.
(if (not (file-exists-p file-that-holds-cur-project-filename))
    (write-cur-project-file project-default))

(defun read-cur-project-file ()
  (with-temp-buffer
    (insert-file-contents file-that-holds-cur-project-filename)
    (buffer-string)))
;; Let's open the project from the last time.
(setq cur-project-filename (read-cur-project-file))

(defun project-save-as (project-filename)
  "Save the current session to a new project session file."
  (interactive (list (ido-read-file-name "Project file to write: " dta-cfg-dir)))
  (copy-file project-default project-filename t)
  ; New project is the new current project.
  (write-cur-project-file project-filename)
  (set-variable 'cur-project-filename project-filename)
  (copy-file cur-project-filename project-default t)
  )

(defun project-save ()
  "Save current project session."
  (interactive)
  (dta-save-session project-default)
  (copy-file project-default cur-project-filename t))

(defun project-load (project-filename)
  "Load existing project session file (group of buffers and windows)."
  (interactive (list (ido-read-file-name "Project file to load: " dta-cfg-dir)))
  (if (string= (file-truename project-filename)
               (file-truename cur-project-filename))
      (message (concat (file-name-nondirectory project-filename) " is already loaded."))
    (progn
      (dta-save-session project-default) ; Write "last.sess".
      ;; Save current project for later.
      (unless (string= (file-truename project-default)
                       (file-truename cur-project-filename))
        (copy-file project-default cur-project-filename t))
      ;; Switch to another current project.
      (set-variable 'cur-project-filename project-filename)
      (write-cur-project-file project-filename)
      ;; Kill other frames because DTA forgets to do it.
      (delete-other-frames)
      (dta-switch-session project-filename)
      )))

;; Like with desktop, only more reliable.
(run-with-timer
 desktop-autosave-period
 desktop-autosave-period
 (lambda ()
   (dta-save-session "~/.emacs.d/desktopaid/last.sess")
   (message (concat "Desktop autosave.  Next autosave in: "
		    (int-to-string desktop-autosave-period) "."))))

;; Server stuff.
;(setq server-use-tcp t
;      server-host "local")

;; File types.
(add-to-list 'magic-mode-alist
           '("#title " . muse-mode))
(add-to-list 'magic-mode-alist
           '("From: " . mail-mode))

;; For ido-find-file.
(set-variable 'ido-ignore-files (cons "\\.hi$" ido-ignore-files))


