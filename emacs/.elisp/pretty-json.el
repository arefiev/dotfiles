(defun pretty-json ()
  (interactive)
  (letrec ((tmp-file-name "/tmp/.emacs_json_format_tmp")
           (command (concat "python -c 'import json; fd = open(\""
                            tmp-file-name
                            "\"); d = json.load(fd);"
                            "print(json.dumps(d, indent=4))'")))
    (save-excursion
      (if (use-region-p)
          (write-region (region-beginning) (region-end) tmp-file-name)
          (write-region nil nil tmp-file-name))
      (let ((data (shell-command-to-string command)))
        (if (or (and (string= (substring data 0 1) "[")
                     (string= (substring data -2 -1) "]"))
                (and (string= (substring data 0 1) "{")
                     (string= (substring data -2 -1) "}")))
            (if (use-region-p)
                (progn
                  (kill-region (region-beginning) (region-end))
                  (insert data))
                (progn
                  (erase-buffer)
                  (insert data)))
            (message data))))))
