(defconst mistkafka-js-packages
  '(
    js2-mode
    js
    ))

(defun mistkafka-js/post-init-js ()
  (setq js-indent-level 2)
  )

(defun mistkafka-js/post-init-js2-mode ()
  (progn
    (with-eval-after-load 'js2-mode
      (progn
        (setq-default js-indent-level 2)
        (setq-default js2-basic-offset 2)
        (setq-default js-switch-indent-offset 2)
        (setq-default js2-mode-show-strict-warnings nil)))))
