(defun mistkafka-js/toggle-indent-level ()
  "Toggle js indent in 4 or 2"
  (interactive)
  (if (= js-indent-level 2)
      (mistkafka-js/set-indent-level 4)
    (mistkafka-js/set-indent-level 2)))

(defun mistkafka-js/set-indent-level (indent)
  (setq-default js-indent-level indent)
  (setq-default js2-basic-offset indent)
  (message "js indent is set to %d" indent))
