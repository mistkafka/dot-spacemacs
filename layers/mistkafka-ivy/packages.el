(defconst mistkafka-ivy-packages '(
                                   ivy))

(defun mistkafka-ivy/post-init-ivy ()
  (setq ivy-re-builders-alist
        '((counsel-M-x . ivy--regex-fuzzy)
          (t . ivy--regex-ignore-order)))
  (setq ivy-initial-inputs-alist nil))
