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

(defun mistkafka/private-get-git-root-path (current-path)
  "get the CURRENT-PATH's git root path"
      (vc-call-backend (vc-responsible-backend current-path) 'root current-path))

(defun mistkafka/private-get-file-name-in-project ()
  "Get current buffer file name in the current git project"
  (let* ((filename (mistkafka/private-get-file-name))
         (project-path (expand-file-name (mistkafka/private-get-git-root-path filename))))
    (setq filename (replace-regexp-in-string project-path "/" filename))))

(defun mistkafka/private-get-file-name-in-jsroot ()
  "Get the current buffer file's js path. It's a hardcode implemented!"
  (let ((filename (mistkafka/private-get-file-name))
        (rootmark "/js/"))
    (setq filename (substring filename
                              (+ (string-match rootmark filename)
                               (length rootmark))))))

(defun mistkafka/private-copy-file-name-to-clipboard (filename)
  "Utils, copy FILENAME to clipboard"
  (when filename
    (kill-new filename)
    (message "Copied filename '%s' to the clipboard" filename)))

(defun mistkafka/copy-file-name-in-system-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (mistkafka/private-copy-file-name-to-clipboard
   (mistkafka/private-get-file-name)))

(defun mistkafka/copy-file-name-in-project-to-clipboard ()
  "Copy the current buffer file name in the current git project to the clipboard"
  (interactive)
  (mistkafka/private-copy-file-name-to-clipboard
   (mistkafka/private-get-file-name-in-project)))

(defun mistkafka/copy-file-name-in-jsroot-to-clipboard ()
  "Copy the current buffer file's js path to the clipboard. It's a hardcode implemented!"
  (interactive)
  (mistkafka/private-copy-file-name-to-clipboard
   (mistkafka/private-get-file-name-in-jsroot)))

(defun mistkafka/copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (mistkafka/private-copy-file-name-to-clipboard
   (file-name-nondirectory (mistkafka/private-get-file-name))))

(defun mistkafka/copy-current-file-to-current-path-like-target ()
  "Copy current file to target path, use current path as the template."
  (interactive)
  (let ((current-file-path (mistkafka/private-get-file-name))
        (target-file-path)
        (target-file-directory))
    (setq target-file-path (ivy-read "Target Path: " nil
                                     :initial-input current-file-path))
    (setq target-file-directory (file-name-directory target-file-path))
    (unless (file-exists-p target-file-directory)
      (dired-create-directory target-file-directory))
    (copy-file current-file-path target-file-path)
    (message "Copy current file to %s" target-file-path)))

(defun mistkafka/insert-currrent-date ()
  (interactive)
  (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

(defun mistkafka/insert-currrent-datetime ()
  (interactive)
  (insert (shell-command-to-string "echo -n $(date '+%Y-%m-%d %H:%M:%S')")))

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

(defun mistkafka/write-file-without-confirm (filename)
  "write file without directory does'nt exists confirm"
  (unless filename
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir)))))

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

;; http://guleilab.com/2016/05/05/OrgPomodoroNotifier/
;; system notify
(defun system-notify (title message)
  (call-process "terminal-notifier"
                nil 0 nil
                "-group" "Emacs"
                "-title" title
                "-message" message
                "-activate" "org.gnu.Emacs"))

(defun system-dialog (title message)
  (call-process "osascript"
                nil 0 nil
                "-e" (format "display dialog \"%s\" with title \"%s\"" message title)))

(defun mistkafka/kill-all-secret-buffer ()
  (interactive)
  (mapcar
   (lambda (buffer)
     (when (s-ends-with? ".gpg" (buffer-name buffer))
       (kill-buffer buffer)))
   (buffer-list))
  (message "已清除所有gpg buffer"))

;; TODO: 抛弃vim改用emacs，range-things不易
;;
;; (defun mistkafka/private-do-range-things (begin-str, end-str)
;;   "Range the string at point with wrapper begin with BEGIN-STR, and end with END-STR"
;;   (push-mark (point))
;;   (search-backward begin-str)
;;   (push-mark (point) nil t)
;;   (forward-char)
;;   (search-forward end-str)
;;   (backward-char))

;; (defun mistkafka/private-range-things (things &optional end-str)
;;   "Range the string at point with wrapper THINGS.
;; If END-STR is gavend THINGS as the begin-str"
;;   (let ((begin-str things))
;;     (unless end-str
;;       (setq end-str things))
;;     (mistkafka/private-do-range-things begin-str end-str)))

;; (defun mistkafka/range-things (things)
;;   "Range the string at point with wrapper THING"
;;   (interactive "sWrapper with things:")
;;   (mistkafka/private-range-things things))


;; copy from: http://oremacs.com/2015/04/19/git-grep-ivy/
(defun mistkafka/counsel-git-grep-function (string &optional _pred &rest _u)
  "Grep in the current git repository for STRING."
  (split-string
   (shell-command-to-string
    (format
     "git --no-pager grep --full-name -n --no-color -i -e \"%s\""
     string))
   "\n"
   t))
(defun mistkafka/counsel-git-grep-current-dir ()
  "Grep for a string in the current git repository."
  (interactive)
  (let ((default-directory (locate-dominating-file
                            default-directory ".git"))
        (insert default-directory)
        (val (ivy-read "pattern: " 'mistkafka/counsel-git-grep-function))
        lst)
    (when val
      (setq lst (split-string val ":"))
      (find-file (car lst))
      (goto-char (point-min))
      (forward-line (1- (string-to-number (cadr lst)))))))

(defun mistkafka/apple-speech--region/at-point-word/user-input ()
  "Speech region content.
Or word at point.
Or prompt user input."
  (interactive)
  (let ((content))
    (cond ((region-active-p) (setq content (buffer-substring-no-properties
                          (region-beginning)
                          (region-end))))
           ((word-at-point) (setq content (word-at-point)))
           (t (setq content (ivy-read "Speech Content: " nil))))

    (call-process "osascript"
                  nil 0 nil
                  "-e" (format "say \"%s\"" content))))
