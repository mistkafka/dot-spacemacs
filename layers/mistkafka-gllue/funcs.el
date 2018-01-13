(defun execute-gllue-cli-command (cmd)
  (call-process "gllue-cli"
                nil 0 nil
                cmd))

(defun gllue-cli/merge-request ()
  (interactive)
  (execute-gllue-cli-command "merge-request"))

(defun gllue-cli/login-customer-system (clientIdOrCode)
  (interactive "sClient ID or Code: ")
  (call-process "gllue-cli"
                nil 0 nil
                "login-customer-system" clientIdOrCode))

(defun gllue/open-project-task(id &optional browser)
  "Open gllue project task detail of ID.
If BROWSER is provated, use the BROWSER open the link."
  (interactive "nProject Task Id:")
  (let* ((url (format "%s%d" PROJECT-ROOT-URL id))
         (cmd (format "open \"%s\"" url)))
    (unless browser
      (setq browser "Google Chrome"))
    (setq cmd (format "%s -a \"%s\"" cmd browser))
    (shell-command cmd)))

(defun gllue/open-project-task-at-point()
  (interactive)
  (let ((id (thing-at-point 'word)))
    (when id
        (setq id (string-to-number id)))
    (if (not (equal 0 id))
        (gllue/open-project-task id)
      (message "未捕获任务ID"))))

(defun gllue/fetch-project-task-detail (id)
  (let* ((json-object-type 'hash-table)
         (json-array-type 'list)
         (json-key-type 'string))
    (nth 0 (json-read-from-string
            (shell-command-to-string (format "gllue-cli project-task-detail %s" id))))))

(defun gllue/auto-gen-commit-message ()
  (interactive)
  (let* ((branch (magit-get-current-branch))
         (branch-parts (split-string branch "-"))
         (emoji (nth 1 branch-parts))
         (project-task-id (nth 2 branch-parts)))
    (insert (format ":%s: [#%s] " emoji project-task-id))
    (if (not (equal 0 (string-to-number project-task-id)))
        (insert (gethash "title" (gllue/fetch-project-task-detail project-task-id)))
      (message "不是合法的Project ID，跳过拉取任务Title。"))))

(defun gllue/merge-request ()
  (interactive)
  (ivy-read
   "%d Assigner: "
   GLLUE-ASSIGNERS
   :action (lambda (assigner)
             (let ((id (nth 0 (split-string assigner " "))))
               (shell-command-to-string (format "gllue-cli merge-request -a %s" id))))))

(defun gllue/fetch-project-tasks-with-saved-search ()
  (interactive)
  (let* ((saved-searchs (gllue/fetch-saved-search-of-project-task))
         (saved-searchs-id-table (gllue/get-id-table-of-saved-searchs saved-searchs))
         (ivy-read-collections (gllue/get-ivy-read-collection-of-saved-search saved-searchs))

         (selected-saved-search-str (ivy-read
                                 "%d Which Saved Search? "
                                 ivy-read-collections))
         (selected-saved-search-id-str (nth 0 (split-string
                                           selected-saved-search-str
                                           ":")))
         (selected-saved-search-id (string-to-number selected-saved-search-id-str))

         (selected-saved-search (gethash selected-saved-search-id saved-searchs-id-table))
         (gql (gethash "query" selected-saved-search))
         (project-tasks (gllue/fetch-project-tasks-with-gql gql)))
    (mapc
     (lambda (project-task)
       (insert (gllue/format-projet-task project-task)))
     project-tasks)))

(defun gllue/format-projet-task (project-task)
  (format "* #%d: %s %s\n  :PROPERTIES:\n  :Added By: %s\n  :END:\n\n"
          (gethash "id" project-task)
          (gethash "__name__" (gethash "status" project-task))
          (gethash "title" project-task)
          (gethash "__name__" (gethash "addedBy" project-task))))

;; (setq done-project-task-in-today-gql "owner__eq=%7B%7Buser.id%7D%7D&(is_deleted__eq=1|is_deleted__eq=)&(status__eq=Test|status__eq=Release)&projecttaskcomment_set__content__icontains=mistkafka%3Cmistkafka%40gmail.com%3E&lastUpdateDate__today=")
(setq done-project-task-in-today-gql "owner__eq=%7B%7Buser.id%7D%7D&(is_deleted__eq=1|is_deleted__eq)&(status__eq=Test|status__eq=Release)&lastUpdateDate__this_week&projecttaskcomment_set__content__icontains=mistkafka%3Cmistkafka%40gmail.com%3E")
(defun gllue/insert-done-project-task-in-today ()
  (interactive)
  (let ((project-tasks (gllue/fetch-project-tasks-with-gql done-project-task-in-today-gql)))
    (insert "|-|-|\n")
    (insert "|ID|Title|\n")
    (insert "|-|-|\n")
    (mapc
     (lambda (project-task)
       (insert (format "|%d|%s|\n"
                       (gethash "id" project-task)
                       (gethash "title" project-task))))
     project-tasks)
    (insert "|-|-|")
    (backward-char 2)
    (org-ctrl-c-ctrl-c)))

(defun gllue/get-id-table-of-saved-searchs (saved-searchs)
  (let ((saved-searchs-id-table (make-hash-table)))
    (mapc
     (lambda (saved-search)
       (puthash
        (gethash "id" saved-search)
        saved-search
        saved-searchs-id-table))
     saved-searchs)
    saved-searchs-id-table))

(defun gllue/get-ivy-read-collection-of-saved-search (saved-searchs)
  (mapcar
   (lambda (saved-search)
     (format "%d: %s"
             (gethash "id" saved-search)
             (gethash "__name__" saved-search)))
   saved-searchs))

(defun gllue/fetch-saved-search-of-project-task ()
  (let* ((json-object-type 'hash-table)
         (json-array-type 'vector)
         (json-key-type 'string)
         (from-me)
         (from-share)
         (savedSearch))

    (setq savedSearch (json-read-from-string
                       (shell-command-to-string "gllue-cli get-saved-search-of-model projecttask")))
    (setq savedSearch (gethash "queryfilter" savedSearch))

    (setq from-me (gethash "from_me" savedSearch))
    (setq from-share (gethash "from_share" savedSearch))
    (setq savedSearch (vconcat from-me from-share))))

(defun gllue/fetch-project-tasks-with-gql (gql)
  (let* ((json-object-type 'hash-table)
         (json-array-type 'vector)
         (json-key-type 'string)
         (res))
    (setq res (json-read-from-string
               (shell-command-to-string (format "gllue-cli get-project-task-list \"%s\"" gql))))
    (gethash "list" res)))
