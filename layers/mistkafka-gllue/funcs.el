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
