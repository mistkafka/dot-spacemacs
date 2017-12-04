(defconst mistkafka-packages
  '(
    spaceline
    ))

(defun mistkafka-js/post-init-js2-mode ()
  (progn
    (with-eval-after-load 'spaceline-info-mode
      (progn
        (spaceline-toggle-minor-modes-off)))))
