
;; Which Function Mode Config

;;
;; copy from zilong
;;
;; http://emacsredux.com/blog/2014/04/05/which-function-mode/
;; (which-function-mode)
;; ;; when editing js file, this feature is very useful
;; (setq-default header-line-format
;;               '((which-func-mode ("" which-func-format " "))))
;;
;; is very slow in python


;; Frame Title Config

;;
;;
(setq frame-title-format
      '("" " Emacs - "
        (:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name)) "%b"))))
