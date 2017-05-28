(defun mistkafka/private-get-file-name ()
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    filename))

(defun mistkafka/copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (mistkafka/private-get-file-name)))
    (when filename
      (kill-new filename)
      (message "Copied buffer filename '%s' to the clipboard." filename))))

(defun mistkafka/insert-currrent-date ()
  (interactive)
  (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

(defun mistkafka/apple-open-current-file ()
  "Use apple's command 'open' to open current file"
  (interactive)
  (let* ((filename (mistkafka/private-get-file-name))
         (cmd (format "open %s" filename)))
    (and filename
         (shell-command cmd))))

