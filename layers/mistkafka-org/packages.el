(defconst mistkafka-org-packages
  '(
    org
    )
  )

(defun mistkafka-org/post-init-org ()
  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d@/!)")
                (sequence "PROJECT(p)" "|" "DONE(d@/!)" "CANCELLED(c@/!)")
                (sequence "WAITING(w@/!)" "DELEGATED(e!)" "HOLD(h)" "|" "CANCELLED(c@/!)")))
        org-todo-repeat-to-state "NEXT")

  (setq org-todo-keyword-faces
        (quote (("NEXT" :inherit warning)
                ("PROJECT" :inherit font-lock-string-face))))

  ;; config logbook
  ;; Save clock data and notes in the LOGBOOK drawer
  (setq org-clock-into-drawer t)
  ;; Save state changes in the LOGBOOK drawer
  (setq org-log-into-drawer t)
  ;; Removes clocked tasks with 0:00 duration
  (setq org-clock-out-remove-zero-time-clocks t)

  ;; Show clock sums as hours and minutes, not "n days" etc.
  (setq org-time-clocksum-format
        '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

  ;; org-publish-project
  (require 'ox-publish)
  (setq org-publish-project-alist
        '(
          ("gitpage"
           :base-directory "~/mistkafka.github.io/org/"
           :base-extension "org"
           :publishing-directory "~/mistkafka.github.io/_posts/"
           :recursive t
           :publishing-function org-html-publish-to-html
           :html-extension "html"

           :body-only t
           :with-toc nil
           :section-numbers nil
           )
          ))
  ;; org文件显示文本格式化后的样式
  (setq org-hide-emphasis-markers t)
  )
