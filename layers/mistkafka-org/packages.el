(defconst mistkafka-org-packages
  '(
    org
    )
  )

(defun mistkafka-org/post-init-org ()
  (setq habitica-uid "6d9dd62e-34fa-4ce7-a73b-d780dd5ec4f5")
  (setq habitica-token "8dec866c-342d-4baa-876d-47cd34938a54")
  (setq habitica-turn-on-highlighting t)
  (setq habitica-show-streak t)
  (with-eval-after-load 'org
    (progn
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
      ;; (require 'ox-publish)
      ;; (setq org-publish-project-alist
      ;;       '(
      ;;         ("gitpage"
      ;;          :base-directory "~/mistkafka.github.io/org/"
      ;;          :base-extension "org"
      ;;          :publishing-directory "~/mistkafka.github.io/_posts/"
      ;;          :recursive t
      ;;          :publishing-function org-html-publish-to-html
      ;;          :html-extension "html"

      ;;          :body-only t
      ;;          :with-toc nil
      ;;          :section-numbers nil
      ;;          )
      ;;         ))
      ;; org文件显示文本格式化后的样式
      (setq org-hide-emphasis-markers t)

      ;; <<<<<<<<<<<<<<<<<<<< org-crypt begin
      ;; 加密文章
      ;; "http://coldnew.github.io/blog/2013/07/13_5b094.html"
      ;; org-mode 設定
      (require 'org-crypt)

      ;; 當被加密的部份要存入硬碟時，自動加密回去
      (org-crypt-use-before-save-magic)

      ;; 設定要加密的 tag 標籤為 secret
      (setq org-crypt-tag-matcher "secret")

      ;; 避免 secret 這個 tag 被子項目繼承 造成重複加密
      ;; (但是子項目還是會被加密喔)
      (setq org-tags-exclude-from-inheritance (quote ("secret")))

      ;; 用於加密的 GPG 金鑰
      ;; 可以設定任何 ID 或是設成 nil 來使用對稱式加密 (symmetric encryption)
      (setq org-crypt-key "193E92ED")
      ;; >>>>>>>>>>>>>>>>>>>> org-crypt end

      ;; <<<<<<<<<<<<<<<<<<<< org-pomodoro
      ;; http://guleilab.com/2016/05/05/OrgPomodoroNotifier/
      (add-hook 'org-pomodoro-finished-hook
                (lambda ()
                  (system-dialog "Pomodoro completed!" "Time for a break.")))
      (add-hook 'org-pomodoro-break-finished-hook
                (lambda ()
                  (system-dialog "Pomodoro Short Break Finished" "Ready for Another?")))
      (add-hook 'org-pomodoro-long-break-finished-hook
                (lambda ()
                  (system-dialog "Pomodoro Long Break Finished" "Ready for Another?")))
      (add-hook 'org-pomodoro-killed-hook
                (lambda ()
                  (system-dialog "Pomodoro Killed" "One does not simply kill a pomodoro!")))
      )))
