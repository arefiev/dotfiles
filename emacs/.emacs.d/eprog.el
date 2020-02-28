;;; Programming.

;; Hideshow mode (hides and shows semantic blocks of code, e. g. function bodies).
(defadvice goto-line (after expand-after-goto-line
                            activate compile)
  "hideshow-expand affected block when using goto-line in a collapsed buffer"
  (save-excursion
    (hs-show-block)))
(add-hook 'hs-minor-mode-hook
          '(lambda ()
             (define-key hs-minor-mode-map "\C-ch" 'hs-hide-block)
             (define-key hs-minor-mode-map "\C-cs" 'hs-show-block)))
(add-hook 'hs-minor-mode-hook
          '(lambda ()
             (define-key hs-minor-mode-map "\C-ch" 'hs-hide-block)
             (define-key hs-minor-mode-map "\C-cs" 'hs-show-block)))
; , where x is code, comments, t (both), or nil (neither).
(setq hs-isearch-open 't)

;; sr-speedbar (SpeedBar in the same frame).
(setq sr-speedbar-right-side nil)

;; Hideshow for programming.
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'js-mode-hook         'hs-minor-mode)
(add-hook 'js2-mode-hook        'hs-minor-mode)
(add-hook 'php-mode-hook        'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'c++-mode-hook        'hs-minor-mode)
(add-hook 'c-mode-hook          'hs-minor-mode)
(add-hook 'nxml-mode-hook       'hs-minor-mode)
(add-hook 'scheme-mode-hook     'hs-minor-mode)

;; Use tabs only in certain major modes.
(setq indent-tabs-mode nil
      tab-width 4)
(add-hook 'java-mode-hook       '(lambda () (setq indent-tabs-mode nil)) t)
(add-hook 'perl-mode-hook       '(lambda () (setq indent-tabs-mode nil)) t)
(add-hook 'emacs-lisp-mode-hook '(lambda () (setq indent-tabs-mode nil)) t)
(add-hook 'js-mode-hook         '(lambda () (setq indent-tabs-mode nil)) t)
(add-hook 'js2-mode-hook        '(lambda () (setq indent-tabs-mode nil)) t)
(add-hook 'php-mode-hook        '(lambda () (setq indent-tabs-mode nil)) t)
(add-hook 'perl-mode-hook       '(lambda () (setq indent-tabs-mode nil)) t)
(add-hook 'c++-mode-hook        '(lambda () (setq indent-tabs-mode nil)) t)
(add-hook 'c-mode-hook          '(lambda () (setq indent-tabs-mode t  )) t) ; Linux style!
(add-hook 'nxml-mode-hook       '(lambda () (setq indent-tabs-mode nil)) t)
(add-hook 'scheme-mode-hook     '(lambda () (setq indent-tabs-mode nil)) t)

(add-hook 'css-mode-hook 'css-color-mode)

;; Zen SGML macros.
(add-hook 'sgml-mode-hook 'zencoding-mode)
(add-hook 'nxml-mode-hook 'zencoding-mode)
(add-hook 'html-mode-hook 'zencoding-mode)

;; Perlcritic mode where it is available.

(setq perlcritic-verbose t)
;(eval-after-load "cperl-mode"
;  '(add-hook 'cperl-mode-hook
;             (lambda ()
;               (block pcmb
;                 (perlcritic-mode)
;                 (set-variable perlcritic-verbose t)
;                 ))))
;(eval-after-load "perl-mode"
;  '(add-hook 'perl-mode-hook
;             (lambda ()
;               (block pcmb
;                 (perlcritic-mode)
;                 (set-variable perlcritic-verbose t)
;                 ))))


;; yasnippet http://code.google.com/p/yasnippet/
;; Handy mode that expands various macros on tab.
(yas/initialize)
(yas/load-directory "~/.elisp/yasnippet/snippets/text-mode/")
(set-face-background 'yas/field-highlight-face "black")

;; Superior inferior Lisp mode for Common Lisp.
;(setq inferior-lisp-program "/usr/bin/sbcl")
;(slime-setup)

;; haskell-mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook
          '(lambda ()
             (setq show-trailing-whitespace t)
             (local-set-key "\C-c\C-t"
                            'inferior-haskell-type)
             (local-set-key "\C-c\C-c\C-l"
                            'hs-lint)))
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))

;; js2-mode http://code.google.com/p/js2-mode/
;(autoload 'js2-mode "js2" nil t)
;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook 'js2-leave-mirror-mode t)
;; Stolen from http://emacswiki.org/emacs/Js2Mode on 2012-10-01.
;; After js2 has parsed a js file, we look for jslint globals decl comment ("/* global Fred, _, Harry */") and
;; add any symbols to a buffer-local var of acceptable global vars
;; Note that we also support the "symbol: true" way of specifying names via a hack (remove any ":true"
;; to make it look like a plain decl, and any ':false' are left behind so they'll effectively be ignored as
;; you can;t have a symbol called "someName:false"
(add-hook
 'js2-post-parse-callbacks
 (lambda ()
   (when (> (buffer-size) 0)
     (let ((btext (replace-regexp-in-string
                   ": *true" " "
                   (replace-regexp-in-string "[\n\t ]+" " " (buffer-substring-no-properties 1 (buffer-size)) t t))))
       (mapc (apply-partially 'add-to-list 'js2-additional-externs)
             (split-string
              (if (string-match "/\\* *global *\\(.*?\\) *\\*/" btext) (match-string-no-properties 1 btext) "")
              " *, *" t))))))

; Make some faces:
(make-face 'font-lock-operator-face)
(make-face 'font-lock-parentheses-face)
(setq font-lock-operator-face 'font-lock-operator-face)
(setq font-lock-parentheses-face 'font-lock-parentheses-face)

; Some explanation of the regexp.
; \\< means beginning of the word.
; All regexp/face declarations are either (regexp . face) or (regexp groupn face [method])
; [^_] is there because Emacs counts _ as word border and we want SUCH_IDENTIFIERS_578
(let ((todo-regexp
       "\\<\\(TODO\\|TEMP\\|TEST\\|HACK\\|FIXME\\|DEBUG\\|ARCH\\)[: ;.,!?\/\n]")
      (hex-regexp
       "[^_]\\<\\(0x[0-9a-fA-F]+\\)\\>[^_]")
      (dec-float-regexp
       "[^_]\\<\\([0-9]+\\(\\.[0-9]+\\)?\\)\\>[^_]")
      (parens-regexp
       "\\([\\[\\](){}]+\\)") )
  (font-lock-add-keywords
   'c++-mode
   (list
    (cons parens-regexp font-lock-parentheses-face)
    ;("\\([0-9]+\\(\\.[0-9]+\\)?\\)" . font-lock-builtin-face)
    `( ,dec-float-regexp         1 font-lock-builtin-face)
    `( ,hex-regexp               1 font-lock-builtin-face)
    `( ,todo-regexp              1 font-lock-warning-face prepend)
    ))
  (font-lock-add-keywords
   'c-mode
   (list ;("\\([.+-=&!|%*,><]+\\)" 1 font-lock-operator-face 'prepend)
    (cons parens-regexp font-lock-parentheses-face)
    `( ,dec-float-regexp         1 font-lock-builtin-face)
    `( ,hex-regexp               1 font-lock-builtin-face)
    `( ,todo-regexp              1 font-lock-warning-face prepend)
    ))
  (font-lock-add-keywords
   'python-mode
   (list ;("\\([.+-=&!|%*,><]+\\)" 1 font-lock-operator-face 'prepend)
    (cons parens-regexp font-lock-parentheses-face)
    `( ,dec-float-regexp         1 font-lock-builtin-face)
    `( ,hex-regexp               1 font-lock-builtin-face)
    `( ,todo-regexp              1 font-lock-warning-face prepend)
    ))
  (font-lock-add-keywords
   'php-mode
   (list ;("\\([.+-=&!|%*,><]+\\)" 1 font-lock-operator-face 'prepend)
    (cons parens-regexp font-lock-parentheses-face)
    ;("\\([0-9]+\\(\\.[0-9]+\\)?\\)" . font-lock-builtin-face)
    `( ,dec-float-regexp         1 font-lock-builtin-face)
    `( ,hex-regexp               1 font-lock-builtin-face)
    `( ,todo-regexp              1 font-lock-warning-face prepend)
    ))
  (font-lock-add-keywords
   'javascript-mode
   (list ;("\\([.+-=&!|%*,><]+\\)" 1 font-lock-operator-face 'prepend)
    (cons parens-regexp font-lock-parentheses-face)
    `( ,dec-float-regexp         1 font-lock-builtin-face)
    `( ,hex-regexp               1 font-lock-builtin-face)
    `( ,todo-regexp              1 font-lock-warning-face prepend)
    ))
  (font-lock-add-keywords
   'js2-mode
   (list ;("\\([.+-=&!|%*,><]+\\)" 1 font-lock-operator-face 'prepend)
    (cons parens-regexp font-lock-parentheses-face)
    `( ,dec-float-regexp         1 font-lock-builtin-face)
    `( ,hex-regexp               1 font-lock-builtin-face)
    `( ,todo-regexp              1 font-lock-warning-face prepend)
    ))
  (font-lock-add-keywords
   'perl-mode
   (list ;("\\([.+-=&!|%*,><]+\\)" 1 font-lock-operator-face 'prepend)
    (cons parens-regexp font-lock-parentheses-face)
    `( ,dec-float-regexp         1 font-lock-builtin-face)
    `( ,hex-regexp               1 font-lock-builtin-face)
    `( ,todo-regexp              1 font-lock-warning-face prepend)
    ))
  (font-lock-add-keywords
   'haskell-mode
   (list  ;("\\([.+-=&!|%*,><]+\\)" 1 font-lock-operator-face 'prepend)
    `( ,dec-float-regexp         1 font-lock-builtin-face)
    `( ,hex-regexp               1 font-lock-builtin-face)
    `( ,todo-regexp              1 font-lock-warning-face prepend)
    ))
  (font-lock-add-keywords
   'latex-mode
   (list
    `( ,todo-regexp              1 font-lock-warning-face prepend)
    ))
  (font-lock-add-keywords
   'muse-mode
   (list
    `( ,todo-regexp              1 font-lock-warning-face prepend)
    ))
  )

;(set-variable 'font-lock-keywords-alist nil)
(set-face-foreground 'font-lock-operator-face "gray66")
(set-face-foreground 'font-lock-parentheses-face "gray44")

;; perl-mode
(add-hook
 'perl-mode-hook
 '(lambda ()
    (defun buffer-exists (buffer)
      (not (eq nil
               (get-buffer buffer))))
    (define-key perl-mode-map "\C-c\C-f"
      (lambda ()
        (interactive)
        (let* ((perldoc-name "*Perldoc*")
               (word (anything-at-point)))
          (if (buffer-exists perldoc-name) (kill-buffer perldoc-name))
          (display-message-or-buffer
           (shell-command-to-string (concat "perldoc -f " word))
           perldoc-name)
          (if (buffer-exists perldoc-name)
              (with-current-buffer perldoc-name
                (help-mode)
                (toggle-read-only 1)))
          )))

    ;; Stupid auto-compose-mode cannot be disabled in perl-mode
    ;; because the fucking buffer is forcedly composed with
    ;; an explicit call to compose-region!
    ;; EXTREMELY annoying.  Fuck you, perl-mode.
    (setq perl-prettify-symbols nil)
    (defun perl--font-lock-compose-symbol () ())
    (defun perl--font-lock-symbols-keywords () ())
))

;; perl-completion
'(add-hook
 'cperl-mode-hook
 (lambda ()
   (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
     (auto-complete-mode t)
     (make-variable-buffer-local 'ac-sources)
     (setq ac-sources
           '(ac-source-perl-completion)))))

(add-hook
 'cperl-mode-hook
 (lambda ()
   (require 'perl-completion)
   (perl-completion-mode t)))

;; Show current function name in the mode line.
(add-hook
 'cperl-mode-hook
 'which-func-mode)

;; Programming in some languages is annoying without the subword mode.
(add-hook 'python-mode-hook 'subword-mode)
(add-hook 'js-mode-hook 'subword-mode)
(add-hook 'js2-mode-hook 'subword-mode)
(add-hook 'haskell-mode-hook 'subword-mode)
(add-hook 'c++-mode-hook 'subword-mode)
(add-hook 'c++-mode-hook 'subword-mode)
(add-hook 'conf-unix-mode-hook 'subword-mode)
(add-hook 'conf-windows-mode-hook 'subword-mode)
(add-hook 'cmake-mode-hook 'subword-mode)
(add-hook 'go-mode-hook 'subword-mode)

;; python-mode stuff.
;(add-hook 'python-mode-hook 'pymacs)
(add-hook
 'python-mode-hook
 (lambda ()
   ;(let ((debug-on-error nil))
   ;  (with-demoted-errors
   ;      "Ropemacs not found"
   ;    (require 'ropemacs)))
   (copy-face 'font-lock-builtin-face 'py-builtins-face)
   ;; Somehow except and raise are exception syntax while try and
   ;; finally are not.  That's retarded.
   (copy-face 'font-lock-builtin-face 'py-exception-name-face)
   ;; None of python-mode's business.
   (copy-face 'font-lock-warning-face 'py-XXX-tag-face)
   ;; Strange default behaviour, very annoying.  Fix it.
   ;(define-key python-mode-map (kbd "RET") 'py-newline-and-dedent)
   (define-key python-mode-map (kbd "RET") 'newline)
   (define-key python-mode-map (kbd "C-m") 'newline)
   (define-key python-mode-map (kbd "C-x <right>") 'py-shift-region-right)
   (define-key python-mode-map (kbd "C-x <left>") 'py-shift-region-left)
   ;; Very shitty underscore handling.
   (set-variable 'py-underscore-word-syntax-p nil) ; Does not work!
   (setq py-underscore-word-syntax-p nil) ; Does not work!
   ;; Do not auto-indent when I start writing a comment, it's annoying.
   (set-variable 'py-indent-comments nil) ; Does not work!
   (setq py-indent-comments nil) ; Does not work!
   )
 'append)

(autoload 'pylint "pylint")
; Until https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=799728 is fixed
(autoload 'pylint-add-menu-items "pylint")
(autoload 'pylint-add-key-bindings "pylint")

(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      ; pycheckers runs epylint, pyflakes and pep8
      (list "/home/gris/bin/pycheckers" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; Set as a minor mode for Python
(add-hook 'python-mode-hook '(lambda () (flymake-mode)))

;; Fuck guido and fuck his opinion on how an Emacs mode should behave.
;; Not his fucking business.
(condition-case nil
    (modify-syntax-entry ?_ "_" python-mode-syntax-table)
  (error nil))
(setq py-underscore-word-syntax-p nil)


;;(setq py-underscore-word-syntax-p nil)
;;(setq py-indent-comments nil)

;; coffee-mode for CoffeeScript.
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(add-hook 'coffee-mode-hook
          '(lambda ()
             (setq show-trailing-whitespace t)
             (local-set-key (kbd "M-r")
                            'coffee-compile-buffer)
             (local-set-key (kbd "M-S-r")
                            'coffee-compile-region)))


;;; Various C++ coding standards (there are so many of them!).

;; Positive Technologies C++ Coding Style.docx
(defconst pt-cc-official-style
  '("stroustrup"
    (c-offsets-alist . ((innamespace . [4]))))) ; All namespaces use same indentation level.
(c-add-style "pt-cc-official-style" pt-cc-official-style)

;; ?
(defconst pt-cc-siem-style
  '("stroustrup"
    (c-offsets-alist . ((innamespace . [0]))))) ; All namespaces use same indentation level.
(c-add-style "pt-cc-siem-style" pt-cc-siem-style)

(setq my-cc-style "pt-cc-siem-style") ; Must be redefined per project (?) or per host (?).
(add-hook 'c-mode-hook '(lambda () (c-set-style "linux")))
(add-hook 'c++-mode-hook '(lambda () (c-set-style my-cc-style)))
(add-hook 'c++-mode-hook '(lambda () (local-set-key (kbd "C-c C-r") (c-state-cache-init))))

(add-hook
 'go-mode-hook
 '(lambda ()
    (set-variable 'tab-width 4 t)
    (local-set-key (kbd "C-c f") 'gofmt)
    (add-hook 'before-save-hook #'gofmt-before-save)
    ))
