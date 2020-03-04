
(defun chomp (str)
  "Chomp leading and tailing whitespace from STR."
  (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'"
                       str)
    (setq str (replace-match "" t t str)))
  str)

(defun insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun insert-time ()
  (interactive)
  (insert (format-time-string "%H:%M:%S")))

(defun insert-uuid1 ()
  (interactive)
  (let ((uuid (shell-command-to-string "uuidgen -t")))
    (insert (chomp uuid))))

(defun insert-uuid4 ()
  (interactive)
  (let ((uuid (shell-command-to-string "uuidgen -r")))
    (insert (chomp uuid))))
