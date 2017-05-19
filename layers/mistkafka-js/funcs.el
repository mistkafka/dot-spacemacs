(defun mistkafka-js/set-indent-level (indent)
  (interactive "n")
  (setq-default js-indent-level indent)
  (setq-default js2-basic-offset indent))
