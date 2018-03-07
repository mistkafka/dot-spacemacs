;; global-set-key
;; key-bind
;; key-bind*
;; spacemacs/declare-prefix  用来设置spacemacs的leader keybindings的目录
;; spacemacs/set-leader-keys 用来设置spacemacs的leader keybindings

;; with-eval-after-load 用来处理需要在某些mode加载之后改按键的情况

;; (global-set-key (kbd "C-c C-f") 'projectile-find-file)
;; (global-set-key (kbd "C-c f") 'helm-grep-do-git-grep)
;; (global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-j") 'yas-expand)
(global-set-key (kbd "C-c k") 'spacemacs/kill-other-buffers)

;; projectile-find-file比较慢！使用counsel-git代替
(spacemacs/set-leader-keys "pf" 'counsel-git)

(spacemacs/set-leader-keys "pF" 'counsel-git-grep)
