(defun mistkafka-js/toggle-indent-level ()
  "Toggle js indent in 4 or 2"
  (interactive)
  (if (= js-indent-level 2)
      (mistkafka-js/set-indent-level 4)
    (mistkafka-js/set-indent-level 2)))

(defun mistkafka-js/set-indent-level (indent)
  (setq-default js-indent-level indent)
  (setq-default js2-basic-offset indent)
  (setq-default js-switch-indent-offset indent)
  (message "js indent is set to %d" indent))

(defun mistkafka-js/toggle-js2-warnings ()
  "Just toggle js2-mode warnings.
Sometimes, I need show errors but without warnings"
  (interactive)
  (setq js2-mode-show-strict-warnings (not js2-mode-show-strict-warnings))
  (if (called-interactively-p 'any)
      (message "warnings %s"
               (if js2-mode-show-strict-warnings
                   "enabled"
                 "disabled"))))
