(defun mistkafka/private-get-file-name ()
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    filename))

(defun mistkafka/private-get-find-files (options)
  "execute the `find' command with OPTIONS, return files"
  (let ((tmp-buffer (uuidgen-4))
        files)
    (get-buffer-create tmp-buffer)
    (shell-command (format "find %s" options) tmp-buffer)
    (with-current-buffer tmp-buffer
      (setq files (split-string (buffer-string) "\n"))
      (delete-window)
      (kill-buffer tmp-buffer))
    files))

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

(defun mistkafka/apple-open-current-file (&optional app)
  "Use apple's command 'open' to open current file"
  (interactive)
  (let* ((filename (mistkafka/private-get-file-name))
         (cmd (format "open %s" filename)))
    (if app
        (setq cmd (format "%s -a %s" cmd app)))
    (and filename
         (shell-command cmd))))

(defun mistkafka/pycharm-open-current-file ()
  "open current file with pycharm"
  (interactive)
  (mistkafka/apple-open-current-file "Pycharm"))

;; TODO: 这个方法有如下几个待改进的点：
;;       1. 改成成只需要输入一个字符，如：输入'('或者')'即可知道是要用'()'包裹字符串
;;       2. 开启vim模式。在vim的正常模式下，选中一段文本，然后按下某个字符就会包裹字符串
(defun mistkafka/wrapper-region-with (str)
  "Wrapper region string with a pair char. the str is like '()' or '[]'."
  (interactive "sWrapper with:")
  (if (use-region-p)
      (let* ((input-str (buffer-substring-no-properties (region-beginning) (region-end)))
             (output-str (format "%s%s%s" (substring str 0 1) input-str (substring str 1 2)))
             (from (region-beginning))
             (to (region-end)))
        (save-excursion
          (delete-region from to)
          (goto-char from)
          (insert output-str)))))
