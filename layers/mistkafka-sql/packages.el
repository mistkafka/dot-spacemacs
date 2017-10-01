(defconst mistkafka-sql-packages
  '(
    sql
    )
  )

(defun mistkafka-sql/post-init-sql ()
  (setq sql-user "root")
  (setq sql-password "linzg123")
  (setq sql-server "127.0.0.1"))
