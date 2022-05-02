;; emacs settings


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "https://orgmode.org/elpa/") t)


(package-initialize)


(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
            ;; Record this as a package the user installed explicitly
            (package-install package nil)
          (package-install package))
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))

(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-g" 'goto-line)
(global-unset-key "\C-o" )

(setq rosdistro (getenv "ROS_DISTRO"))
(add-to-list 'load-path (format "/opt/ros/%s/share/emacs/site-lisp" (or rosdistro "melodic")))
(require 'rosemacs)
(invoke-rosemacs)
(global-set-key "\C-x\C-r" ros-keymap)

;;; personal change

;; '(font-lock-comment-face       ((t (:italic t :slant oblique :foreground "chocolate1"))))
;; '(font-lock-comment-face       ((t (:italic t :slant oblique :foreground "gray50"))))

;;;=================================================
;;; preferences
;;;=================================================

;;; 括弧の自動補完
;;(electric-pair-mode 1)

;;; 対応する括弧を光らせる
(show-paren-mode 1)

;;; tabにスペース4つを利用
(setq-default tab-width 4 indent-tabs-mode nil)

;;; 列番号
;;(column-number-mode t)

;;;; 行番号
(require 'linum)             ;; 画面左に行数を表示
(global-linum-mode t)        ;; デフォルトでlinum-modeをonにする
(setq linum-format "%3d ")   ;; 5桁分の領域を確保
(line-number-mode t)         ;; 下のバーに行数表示

;;; 1行ごとに改ページ
(setq scroll-conservatively 1)

;; ;;; trr
;; (add-to-list 'load-path "/home/tsukamoto/.emacs.d/emacs-trr/")
;; (setq trr-japanese t) ;; uncomment this to play with Japanese mode
;; (require 'trr)

;;;==================================
;;; スペース・タブの可視化
(require 'whitespace)
(setq whitespace-style '(face        ;; faceで可視化
                         trailing    ;; 行末
                         tabs        ;; タブ
                         spaces      ;; スペース
                         empty       ;; 先頭/末尾の空行
                         space-mark  ;; 表示のマッピング
                         tab-mark
                         ))

(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")
;; 行末
(setq whitespace-trailing-regexp  "\\([ \u00A0]+\\)$")

(defvar my/bg-color "#232323")
(set-face-attribute 'whitespace-trailing nil
                    :background my/bg-color
                    :foreground "DeepPink"
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :background my/bg-color
                    :foreground "LightSkyBlue"
                    :underline t)
(set-face-attribute 'whitespace-space nil
                    :foreground "gray40"
                    :background "gray20"
                    :underline nil)
;; (set-face-attribute 'whitespace-space nil
;;                     :background my/bg-color
;;                     :foreground "GreenYellow"
;;                     :weight 'bold)
;; (set-face-attribute 'whitespace-empty nil
;;                     :background my/bg-color)
(global-whitespace-mode t)

;;;================================================

;;;================================================
;;; yaml-modeの自動適用
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("¥¥.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("¥¥.yaml$" . yaml-mode)))
;;;================================================

;;; euslime
(add-to-list 'load-path "/opt/ros/melodic/share/euslime")
(require 'euslime-config)
(setq inferior-euslisp-program "roseus")
(slime-setup '(slime-fancy slime-banner slime-repl-ansi-color))

;;; company-mode
(require 'company)
(require-package 'company)
(global-company-mode +1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 2)
 '(company-selection-wrap-around t)
 '(package-selected-packages
   (quote
    (undo-tree dockerfile-mode flycheck magit json-mode company gnu-elpa-keyring-update)))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
 ;; loop

;; ;; add color space,tab,zenkaku-space
;; (unless (and (boundp '*do-not-show-space*) *do-not-show-space*)
;;   (defface my-face-b-1 '((t (:background "gray"))) nil)
;;   (defface my-face-b-2 '((t (:background "red"))) nil)
;;   (defface my-face-u-1 '((t (:background "red"))) nil)
;;   (defvar my-face-b-1 'my-face-b-1)
;;   (defvar my-face-b-2 'my-face-b-2)
;;   (defvar my-face-u-1 'my-face-u-1)

;;   (defadvice font-lock-mode (before my-font-lock-mode ())
;;     (font-lock-add-keywords
;;      major-mode
;;      '(
;;        ("\t" 0 my-face-b-1 append)
;;        ("　" 0 my-face-b-2 append)
;;        ("[ \t]+$" 0 my-face-u-1 append)
;;        )))
;;   (ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;;   (ad-activate 'font-lock-mode)
;;   )

;;; color-theme
;; (add-to-list 'custom-theme-load-path (file-name-as-directory "/home/tsukamoto/.emacs.d/replace-colorthemes/"))
;; (load-theme 'hober t t)
;; (enable-theme 'hober)
;; (set-face-background 'default "color-16")

;;; initial .emacs.d/init.el
;;;=================================================
;;; Jump-to-line
;;; M-x g goto-line
;;; デバッグをする際にこれがあると便利
;;;=================================================
;;(global-set-key "\M-g" 'goto-line)

;;;=================================================
;;; Delete-key
;;; C-h backward-delete-char
;;;=================================================
;;(global-set-key "\C-h" 'backward-delete-char)

;;;=================================================
;;; 行番号表示
;;;=================================================
;;(require 'linum)             ;; 画面左に行数を表示
;;(global-linum-mode t)        ;; デフォルトでlinum-modeをonにする
;;(setq linum-format "%3d ")   ;; 5桁分の領域を確保
;;(line-number-mode t)         ;; 下のバーに行数表示

;;;=================================================
;;; trr
;;; M-x trr
;;;=================================================

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; flycheck
(require-package 'flycheck)
(global-flycheck-mode t)
;;; undo-tree
(require-package 'undo-tree)
(global-undo-tree-mode +1)
;;; not divide when launching emacs
(setq infibit-startup-message t)
