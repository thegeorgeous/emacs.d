;;; init.el --- Init configuration for emacs

;;; Commentary:

;;; Code:

;; enable melpa packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;; fix the emacs ui
(tool-bar-mode -1) ;; No toolbars
(blink-cursor-mode -1) ;; No blinking cursor
(scroll-bar-mode -1) ;; No ugly scrollbar
(setq ring-bell-function 'ignore)

;; Newline at end of file
(setq require-final-newline t)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)
;; Enable copy/pasting from clipboard
(setq select-enable-clipboard t)
;; Replace selected text with what is typed
(delete-selection-mode 1)

;; Fix weird color escape sequences
(setq system-uses-terminfo nil)

;; Ask for confirmation before closing emacs
(setq confirm-kill-emacs 'yes-or-no-p)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(use-package exec-path-from-shell
  :ensure t
  :config
  (setq exec-path-from-shell-check-startup-files nil)
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

;; Always reload the file if it changed on disk
(global-auto-revert-mode 1)
(diminish 'auto-revert-mode)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; disable the splash screen
(setq inhibit-startup-message t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; start emacs in fullscreen
(toggle-frame-fullscreen)


;; switch mac control and meta buttons
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'control)
  (setq mac-control-modifier 'super))

;; make cursor a line
(setq-default cursor-type 'bar)

;; set fill-column to 80
(setq-default fill-column 80)

;; set font family and size
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 180 :family "Inconsolata")))))

;; load zenburn theme
(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

(bind-key "C-c e" 'save-buffers-kill-emacs)

;; Use the default powerline
(use-package powerline
  :ensure t
  :config
  (powerline-default-theme)
  (setq powerline-default-separator 'wave))

;; better colours for colorline separator
(setq ns-use-srgb-colorspace nil)

;; move text up and down
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(bind-key [(control shift up)]  'move-line-up)
(bind-key [(control shift down)]  'move-line-down)

;; whitespace-mode config
(use-package whitespace
  :diminish global-whitespace-mode
  :config
  (setq whitespace-line-column 80)
  (setq whitespace-style '(tabs empty trailing))
  (global-whitespace-mode t)
  (add-hook 'before-save-hook 'whitespace-cleanup t))

;; CamelCase aware editing
(add-hook 'prog-mode-hook 'subword-mode)
(with-eval-after-load 'subword
  (diminish 'subword-mode))
(global-subword-mode +1)

;; enable crux
(use-package crux
  :ensure t
  :bind (("C-c I" . crux-find-user-init-file)
         ("C-c D" . crux-delete-file-and-buffer)
         ("C-c s" . crux-transpose-windows)
         ("C-c k" . crux-kill-other-buffers)
         ("s-j" . crux-top-join-line)
         ("C-c R" . crux-rename-file-and-buffer)
         ("C-c S" . crux-find-shell-init-file)
         ("s-k" . crux-kill-whole-line)
         ("C-c n" . crux-cleanup-buffer-or-region)
         ("C-c TAB" . crux-indent-rigidly-and-copy-to-clipboard)
         ("C-a" . crux-move-beginning-of-line)))

;; Package List shortcut
(bind-keys :prefix-map package-map
          :prefix "C-x p"
          ("p" . package-list-packages)
          ("P" . paradox-list-packages))

;; Emacs-Lisp mode keys
(bind-keys :map emacs-lisp-mode-map
           ("C-c C-b" . eval-buffer))

;; Org-mode
(with-eval-after-load 'org
  (global-set-key (kbd "C-c a t") #'org-todo-list))

(setq org-agenda-files (quote ("~/.org_files/ehq-participation-tasks.org")))
;; Org-src-mode
(declare-function org-edit-src-save "org" nil)
(declare-function org-edit-src-exit "org" nil)
(defun org-edit-src-save-and-exit ()
  "Save org source code edit buffer and exit."
  (interactive)
  (org-edit-src-save)
  (org-edit-src-exit))
(bind-key "C-c C-e" 'org-edit-src-save-and-exit)
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)


;; helm-mode by default
(use-package helm
  :ensure t
  :diminish helm-mode
  :config
  (helm-mode 1)
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-c f" . helm-recentf)
         ("C-x b" . helm-mini)
         ("C-x C-b" . helm-buffers-list)))

;; Use company
(use-package company
  :ensure t
  :diminish company-mode
  :config
  (global-company-mode))

;; magit keys
(use-package magit
  :ensure t
  :bind
  ("C-x g" . magit-status)
  ("C-c b" . magit-blame))

;; avy and ace-window
(use-package avy
  :ensure t
  :bind
  ("C-c j" . avy-goto-word-or-subword-1)
  ("s-." . avy-goto-word-or-subword-1))

(use-package ace-window
  :ensure t
  :bind
  ("s-w" . ace-window))

;; enable guru-global-mode
(use-package guru-mode
  :ensure t
  :diminish guru-mode
  :config
  (guru-global-mode +1)
  (setq guru-warn-only t))

;; enable projectile-globally
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode))

(use-package helm-projectile
  :ensure t
  :init
  (setq projectile-switch-project-action #'helm-projectile-find-file)
  (helm-projectile-on)
  :bind(:map projectile-mode-map
	     ("C-c p p" . helm-projectile-switch-project)
	     ("C-c p f" . helm-projectile-find-file)
	     ("C-c p s g" . helm-projectile-grep)
	     ("C-c p s s" . helm-projectile-ag)
	     ("C-c p e" . helm-projectile-recentf)
	     ("C-c p b" . helm-projectile-switch-to-buffer)
	     ("C-c p F" . helm-projectile-find-file-in-known-projects)))

;; enable projectile-rails-mode
(use-package projectile-rails
  :ensure t
  :diminish projectile-rails-mode
  :config
  (add-hook 'projectile-mode-hook 'projectile-rails-on))

;; anzu mode globally
(use-package anzu
  :ensure t
  :diminish anzu-mode
  :config
  (global-anzu-mode)
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp)))

;; Start eshell or switch to it if it's active.
(bind-key "C-c m" 'eshell)

;; Start a regular shell
(bind-key "C-c M-m" 'shell)

;; Start an ansi-term
(bind-key "C-c t" 'ansi-term)

;; set flycheck configurations
(use-package flycheck
  :ensure t
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  :config
  (setq flycheck-ruby-rubocop-executable "~/.rbenv/shims/rubocop")
  (setq flycheck-eslintrc "~/.eslintrc"))

;; global-smartparens
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (smartparens-global-mode)
  (show-smartparens-global-mode t))
(require 'smartparens-config)
(require 'smartparens-ruby)

;; Enable multiple-cursors-mode
(use-package multiple-cursors
  :ensure t
  :bind (("C-<" . mc/mark-previous-like-this)
         ("C->" . mc/mark-next-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; Highlight the current line
(global-hl-line-mode +1)

;; Enable robe-mode
(use-package ruby-mode
  :config
  (add-hook 'ruby-mode-hook 'robe-mode))

(use-package robe
  :ensure t
  :diminish robe-mode)

(use-package rspec-mode
  :ensure t
  :diminish rspec-mode)

;; Use web mode for erb templates
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode)))

;; For when current line and column display
;; is out of the screen
(bind-key "C-c l" 'what-line)

;; Add markdown-mode
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package yaml-mode
  :ensure t)

(use-package zop-to-char
  :ensure t)

(use-package scss-mode
  :ensure t)

(use-package beacon
  :ensure t)

(use-package fill-column-indicator
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'fci-mode))

(use-package emmet-mode
  :ensure t)

(use-package helm-ag
  :ensure t)

(use-package haml-mode
  :ensure t)

(use-package ack
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(package-selected-packages
   (quote
    (company fill-column-indicator projectile-rails zop-to-char zenburn-theme yari yaml-mode xclip web-mode wc-mode wc-goal-mode use-package smartparens scss-mode rspec-mode robe rainbow-mode powerline paradox ov multiple-cursors monokai-theme markdown-mode magit js2-mode helm-projectile helm-ag haml-mode guru-mode flycheck exec-path-from-shell erc-colorize emmet-mode crux company-inf-ruby coffee-mode beacon auto-compile anzu ack ace-window))))

(provide 'init)
;;; init.el ends here
