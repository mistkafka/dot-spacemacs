;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-line-numbers t
   dotspacemacs-configuration-layers
   '(
     ;; Text or Blog
     (markdown :variables markdown-live-preview-engine 'vmd)
     org

     ;; Programming
     sql
     auto-completion
     python
     emacs-lisp
     common-lisp
     html
     javascript
     yaml

     ;; Mis
     themes-megapack
     syntax-checking
     spell-checking
     osx
     better-defaults
     xkcd
     games

     ;; My config layer
     mistkafka
     )
   dotspacemacs-additional-packages '(vue-mode stylus-mode bing-dict chinese-fonts-setup)
   dotspacemacs-excluded-packages '()
   dotspacemacs-frozen-packages '()
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'
   dotspacemacs-editing-style 'hybrid
   dotspacemacs-verbose-loading nil
   ;; `official'(default) or `random'
   dotspacemacs-startup-banner 'random
   ;; Possible values are: `recents' `bookmarks' `projects'.
   dotspacemacs-startup-lists '((recents . 3)
                                (projects . 3)
                                (bookmarks . 3))
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(sanityinc-solarized-light
                         spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Source Code Pro"
                               :size 14
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-command-key ":"
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  ;; set emacs package mirrors
  (setq configuration-layer--elpa-archives
        '(("melpa-cn" . "http://elpa.emacs-china.org/melpa/")
          ("org-cn"   . "http://elpa.emacs-china.org/org/")
          ("gnu-cn"   . "http://elpa.emacs-china.org/gnu/")))

  (with-eval-after-load 'org
    (setq org-match-substring-regexp
          (concat
           ;; 限制上标和下标的匹配范围，org 中对其的介绍见：(org) Subscripts and superscripts
           "\\([0-9a-zA-Zα-γΑ-Ω]\\)\\([_^]\\)\\("
           "\\(?:" (org-create-multibrace-regexp "{" "}" org-match-sexp-depth) "\\)"
           "\\|"
           "\\(?:" (org-create-multibrace-regexp "(" ")" org-match-sexp-depth) "\\)"
           "\\|"
           "\\(?:\\*\\|[+-]?[[:alnum:].,\\]*[[:alnum:]]\\)\\)")))

  (setq org-emphasis-regexp-components
        ;; markup 记号前后允许中文
        (list (concat " \t('\"{"            "[:nonascii:]")
              (concat "- \t.,:!?;'\")}\\["  "[:nonascii:]")
              " \t\r\n,\"'"
              "."
              1))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;;================================================================================
  ;; mac meta key
  ;;================================================================================
  (setq mac-option-modifier 'meta)

  ;;================================================================================
  ;; config auto complete for sass
  ;;================================================================================
  (defvar ac-source-css-property-names       ;; refer to http://d.hatena.ne.jp/sugyan/20120107
    '((candidates . (loop for property in ac-css-property-alist
                          collect (car property)))))
  (defun configure-auto-complete-for-sass ()
    (add-to-list 'ac-sources 'ac-source-css-property)
    (add-to-list 'ac-sources 'ac-source-css-property-names))
  (add-hook 'sass-mode-hook 'configure-auto-complete-for-sass)
  (add-hook 'sass-mode-hook 'auto-complete-mode)

  ;;================================================================================
  ;; config vue-mode
  ;;================================================================================
  (use-package vue-mode
    :config
    (setq mmm-submode-decoration-level 0))

  ;;================================================================================
  ;; kill others buffers
  ;;================================================================================
  (defun kill-other-buffers ()
    "Kill all buffers but the current one.
Don't mess with special buffers."
    (interactive)
    (dolist (buffer (buffer-list))
      (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
        (kill-buffer buffer))))
  (global-set-key (kbd "C-c k") 'kill-other-buffers)

  ;;================================================================================
  ;; copy pathname to clipboard
  ;;================================================================================
  (defun copy-file-name-to-clipboard ()
    "Copy the current buffer file name to the clipboard."
    (interactive)
    (let ((filename (if (equal major-mode 'dired-mode)
                        default-directory
                      (buffer-file-name))))
      (when filename
        (kill-new filename)
        (message "Copied buffer filename '%s' to the clipboard." filename))))

  (setq org-hide-emphasis-markers t)

  ;;================================================================================
  ;; custom key-binding
  ;;================================================================================
  (global-set-key (kbd "C-c C-f") 'projectile-find-file)
  (global-set-key (kbd "C-c f") 'helm-do-ag-project-root)
  (global-set-key (kbd "C-x b") 'helm-mini)

  ;;================================================================================
  ;; javascript config
  ;;================================================================================
  (setq js2-basic-offset 2)
  (setq js2-indent-switch-body 2)
  (setq js-indent-level 2)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil)

  ;;================================================================================
  ;; yasnippet config
  ;;================================================================================
  (global-set-key (kbd "M-n") 'yas-expand)

  ;; 删除备注：非常卡！
  ;; ;;================================================================================
  ;; ;; flycheck config start
  ;; ;;================================================================================
  ;; (setq-default flycheck-disabled-checkers
  ;;               (append flycheck-disabled-checkers
  ;;                       '(javascript-jshint)))

  ;; (setq flycheck-eslint-rules-directories '("~/"))
  ;; (setq flycheck-eslintrc "~/.eslintrc.js")
  ;; (flycheck-add-mode 'javascript-eslint 'web-mode)
  ;; (flycheck-add-mode 'javascript-eslint 'js2-mode)
  ;; (flycheck-add-mode 'javascript-eslint 'js-mode)

  (use-package chinese-fonts-setup)
  ;; Auto generated by chinese-fonts-setup
  ;; <https://github.com/tumashu/chinese-fonts-setup>
  ;; (set-face-attribute
  ;;  'default nil
  ;;  :font (font-spec :name "-*-Monaco-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1"
  ;;                   :weight 'normal
  ;;                   :slant 'normal
  ;;                   :size 12.5))
  ;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
  ;;   (set-fontset-font
  ;;    (frame-parameter nil 'font)
  ;;    charset
  ;;    (font-spec :name "-*-Microsoft YaHei-normal-normal-normal-*-*-*-*-*-p-0-iso10646-1"
  ;;               :weight 'normal
  ;;               :slant 'normal
  ;;               :size 14.5)))
  )
