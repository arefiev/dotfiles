;; load-path for stuff

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq load-path
      (append
      (list "~/.emacs.d/"
            "~/.elisp/"
	    "~/.elisp/yasnippet/"
	    "~/bin/"
            "~/.elisp/org-opml/"
            "/usr/share/emacs/site-lisp/haskell-mode"
            )
            load-path))

(defun make-local-hook (hook)
 (message "make-local-hook is obsolete in the new order (emacs24)"))

;; require stuff
(dolist (library '(
    slime hideshow show-wspace muse-mode muse-html ido haskell-mode hs-lint
    yasnippet remember org subword template zencoding-mode mon-css-color auto-complete
    python-mode cmake-mode minimap yaml-mode
  ))
  (condition-case nil
    (require library)
  (error
    "Cannot load" library))
)

;; load functions and local packages
(load "~/.elisp/misc.el")
(load "~/.elisp/pretty-json.el")
(load "~/.elisp/cyrillic-dvorak.el")
(load "~/.elisp/runic-elder-futhark.el")
;(load "~/.elisp/buffer-list-operations.el")
;(load "~/.elisp/syntax-highlight.el")
;(load "~/.elisp/dos-to-unix.el")
;(load "~/.elisp/smooth-scrolling.el")

;; FUCK YOU electric mode.
(electric-indent-mode -1)

;; load my config sections
(load "~/.emacs.d/eosdp.el")  ; os-dependent
(load "~/.emacs.d/efeel.el")  ; feel
(load "~/.emacs.d/etext.el")  ; text functions
(load "~/.emacs.d/ekeys.el")  ; global key definitions
(load "~/.emacs.d/esyst.el")  ; for system stuff like encodings
(load "~/.emacs.d/eprog.el")  ; for programming stuff
(load "~/.emacs.d/emuse.el")  ; muse, planner etc
(load "~/.emacs.d/eorgm.el")  ; org-mode, remember etc
(load "~/.emacs.d/elook.el")  ; look

;; Load ropemacs for python-mode
;(condition-case nil
;    (progn
;      (add-to-list 'load-path "~/.elisp/ropemode")
;      (autoload 'pymacs-apply "pymacs")
;      (autoload 'pymacs-call  "pymacs")
;      (autoload 'pymacs-eval  "pymacs" nil t)
;      (autoload 'pymacs-exec  "pymacs" nil t)
;      (autoload 'pymacs-load  "pymacs" nil t)
;      (pymacs-load "ropemacs" "rope-")
;      (setq ropemacs-enable-autoimport t)
;      )
;  (error
;   (message "Cannot load Pymacs.")))

(condition-case nil
    (require 'coffee-mode)
  (error
    (message "Cannot load coffee-mode.")))

;; for christ's sake, follow symlinks without bugging me
(setq vc-follow-symlinks t)

;; Load local which can override any definitions from the above configs.
(load "~/.emacs.d/local.el")

;;; start gnuserv so other apps can knock
(message "Starting Emacs server!")
(server-start)
(message "Emacs server started!")
