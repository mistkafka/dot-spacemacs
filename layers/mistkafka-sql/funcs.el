(defun insert-safe-sqls ()
  "INSERT region's update/delete sqls' select sql."
  (interactive)
  (let ((sqls (buffer-substring (region-beginning) (region-end))))
    (with-temp-file "/tmp/temp.sql"
      (insert sqls))
    (goto-char (region-beginning))
    (goto-char (line-beginning-position))
    (insert "\n")
    (insert (shell-command-to-string "node ~/tmp/safe-sql.js /tmp/temp.sql"))
    (insert "\n")))
