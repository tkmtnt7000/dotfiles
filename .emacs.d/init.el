;; emacs settings


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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

;;; trr
(add-to-list 'load-path "/home/tsukamoto/.emacs.d/emacs-trr/")
(setq trr-japanese t) ;; uncomment this to play with Japanese mode
(require 'trr)

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

;;スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

(global-whitespace-mode 1)

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
                    :background my/bg-color
                    :foreground "GreenYellow"
                    :weight 'bold)
(set-face-attribute 'whitespace-empty nil
                    :background my/bg-color)

;;;================================================

;;;================================================
;;; yaml-modeの自動適用
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("¥¥.yml$" . yaml-mode)))
;;;================================================

;;; euslime
(add-to-list 'load-path "/opt/ros/melodic/share/euslime")
(require 'euslime-config)
(setq inferior-euslisp-program "roseus")
(slime-setup '(slime-fancy slime-banner slime-repl-ansi-color))

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
