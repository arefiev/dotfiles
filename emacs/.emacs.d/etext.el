;;; Text operations and such.

;; I hate tabs.
(setq tab-width 4
      c-tab-always-indent t
      tab-always-indent t
      standard-indent 4
      indent-tabs-mode nil)

;; Allocate more memory to undo.
(setq undo-limit        120000
      undo-strong-limit 150000)

;; Enable mode.
(setq delete-selection-mode t)

;; Some text editing stuff.
(put 'narrow-to-region 'disabled nil) ; Enable region narrowing & widening.
(put 'downcase-region 'disabled nil) ; Enable case changes of region text.
(put 'upcase-region 'disabled nil)      ;   "     "
(put 'capitalize-region 'disabled nil)  ;   "     "

;; Parenthesis Stuff.
(show-paren-mode) ;; funkerikke
(setq show-paren-style 'parenthesis)    ; ..with style
(setq blink-matching-paren t)

;; Default non-Latin input method.
(setq default-input-method "cyrillic-dvorak")

;; Supposedly, this turns on flyspell mode for text editing.
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

;; I separate sentences.  Like this.
(setq sentence-end-double-space t)

(defun bkr ()
  "Alias for browse-kill-ring"
  (interactive)
  (browse-kill-ring))

;; Ignore case when searching.
(setq case-fold-search t)
(add-hook 'isearch-mode-hook
	  (function
	   (lambda ()
	     (define-key isearch-mode-map "\C-h" 'isearch-mode-help)
	     (define-key isearch-mode-map "\C-t" 'isearch-toggle-regexp)
	     (define-key isearch-mode-map "\C-c" 'isearch-toggle-case-fold)
	     (define-key isearch-mode-map "\C-j" 'isearch-edit-string))))
(add-hook 'isearch-mode-hook
	  (function
	   (lambda ()
	     (setq case-fold-search t))))


;; SavePlace- this puts the cursor in the last place you edited
;; a particular file.  This is very useful for large files.
(require 'saveplace)
(setq-default save-place t)


;; Templates.
(setq template-default-directory "~/.emacs.d/templates/"
      template-default-directories '("~/.emacs.d/templates/")
      template-auto-insert nil)


;; IDO mode.
;(add-hook
; 'ido-setup-hook
; '(lambda ()
;    (define-key ido-completion-map "\/" 'ido-complete))) ; Because I love hitting «////».


;; Jumps to a matching parenthesis/brace/bracket, much like % does in Vim.
(defun jump-to-matching-paren ()
  "Jumps to a matching parenthesis/brace/bracket, much like % does in Vim."
  (interactive)
  (defun jump-to-matching-paren-loop (s f level)
    (setq found nil
          initial-position (point)
          mps '((?\( . ?\)) (?\[ . ?\]) (?{  . ?} ) (?<  . ?> )
                (?\) . ?\() (?\] . ?\[) (?}  . ?{ ) (?>  . ?< )))
    (block loop
      (condition-case nil ; char-before can throw errors.
          (while (not found)
            (funcall f)
            (setq found
             (progn
               (setq level (cond
                ((eq s            (char-before)      ) (+ level 1))
                ((eq s (cdr (assq (char-before) mps))) (- level 1))
                (t                                        level)))
               (zerop level))))
        ; Handle errors like «beginning-of-buffer».
        ; We should be able to return the cursor back.
        ('error (return-from loop))))
      (unless found
          (progn (message "Matching parenthesis not found!")
                 (goto-char initial-position))))
  (let ((s (char-before)))
    (if (memq s (string-to-list "()[]{}<>"))
        (jump-to-matching-paren-loop s
         (cond ((memq s (string-to-list "([{<"))
                'forward-char)
               ((memq s (string-to-list ">}])"))
                'backward-char))
         1)
      t)))
