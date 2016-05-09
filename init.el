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
;; Enable copy/past-ing from clipboard
(setq select-enable-clipboard t)
;; Replace selected text with what is typed
(delete-selection-mode 1)

;; Fix weird color escape sequences
(setq system-uses-terminfo nil)

;; Ask for confirmation before closing emacs
(setq confirm-kill-emacs 'yes-or-no-p)

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(use-package exec-path-from-shell
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(custom-safe-themes
   (quote
    ("8aa7eb0cc23931423f719e8b03eb14c4f61aa491e5377073d6a55cba6a7bc125" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "824c02fec7dfb3affca5f5a3b8dddfb8ded6e23ba82b8a1c72191d66f2418b8c" "20e359ef1818a838aff271a72f0f689f5551a27704bf1c9469a5c2657b417e6c" default)))
 '(global-company-mode t)
 '(helm-mode t)
 '(initial-frame-alist (quote ((fullscreen . fullboth))))
 '(org-agenda-files (quote ("~/src/btt/ehq/participation/tasks.org")))
 '(package-selected-packages
   (quote
    (use-package paradox wc-goal-mode wc-mode fill-column-indicator exec-path-from-shell ack erc-colorize projectile-rails monokai-theme powerline auto-compile spaceline rspec-mode web-mode rainbow-mode company-inf-ruby beacon zop-to-char scss-mode diminish smartparens yari robe xclip yaml-mode crux anzu emmet-mode helm-package helm-projectile haml-mode org markdown-mode helm-ag helm-flycheck helm-rails magit json-mode flycheck multiple-cursors zenburn-theme spacemacs-theme projectile js2-mode helm guru-mode company coffee-mode aggressive-indent ace-window)))
 '(paradox-github-token t)
 '(send-mail-function (quote mailclient-send-it))
 '(show-smartparens-global-mode t))

;; switch mac control and meta buttons
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'control)
  (setq mac-control-modifier 'super))

;; make cursor a line
(setq-default cursor-type 'bar)

;; set font family and size
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 160 :family "Inconsolata")))))

;; load monokai theme
(load-theme 'monokai t)

;; Use the default powerline
(use-package powerline
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

(global-set-key [(control shift up)]  'move-line-up)
(global-set-key [(control shift down)]  'move-line-down)

;; whitespace-mode config
(use-package whitespace
  :diminish global-whitespace-mode
  :config
  (setq whitespace-line-column 80)
  (setq whitespace-style '(face tabs empty trailing lines-tail))
  (global-whitespace-mode t)
  (add-hook 'before-save-hook 'whitespace-cleanup t))

;; CamelCase aware editing
(add-hook 'prog-mode-hook 'subword-mode)
(with-eval-after-load 'subword
  (diminish 'subword-mode))
(global-subword-mode +1)

;; enable crux
(use-package crux
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
(global-set-key (kbd "C-c C-e") 'org-edit-src-save-and-exit)
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)


;; helm-mode by default
;; (require 'helm)
;; (require 'helm-config)
(use-package helm
  :diminish helm-mode
  :config
  (helm-mode 1)
)

;; Use company
(use-package company
  :diminish company-mode
  :config
  (global-company-mode))

;; Helm-bindings for common actions
(bind-key "M-x" 'helm-M-x)
(bind-key "C-x C-f" 'helm-find-files)
(bind-key "C-c f" 'helm-recentf)
(bind-key "C-x b" 'helm-mini)
(bind-key "C-x C-b" 'helm-buffers-list)

;; magit keys
(bind-key "C-x g" 'magit-status)
(bind-key "C-c b" 'magit-blame)

;; avy and ace-window
(bind-key "C-c j" 'avy-goto-word-or-subword-1)
(bind-key "s-." 'avy-goto-word-or-subword-1)
(bind-key "s-w" 'ace-window)

;; enable guru-global-mode
(use-package guru-mode
  :diminish guru-mode
  :config
  (guru-global-mode +1)
  (setq guru-warn-only t))

;; enable projectile-globally
(projectile-global-mode)
;; enable projetile-rails-mode
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(with-eval-after-load 'projectile-rails
  (diminish 'projectile-rails-mode))

;; anzu mode globally
(use-package anzu
  :diminish anzu-mode
  :config
  (global-anzu-mode)
  :bind (("M-%" . anzu-query-replace)
	 ("C-M-%" . anzu-query-replace-regexp)))

;; Start eshell or switch to it if it's active.
(bind-key "C-x m" 'eshell)

;; Start a regular shell
(bind-key "C-x M-m" 'shell)

;; set flycheck configurations
(use-package flycheck
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  :config
  (setq flycheck-ruby-rubocop-executable "~/.rbenv/shims/rubocop")
  (setq flycheck-eslintrc "~/.eslintrc"))

;; enable helm bindings for projectile
(helm-projectile-on)

;; global-smartparens
(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode)
(show-smartparens-global-mode t)
(diminish 'smartparens-mode)

;; Enable multiple-cursors-mode
(use-package multiple-cursors
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
  :diminish robe-mode)

(use-package rspec-mode
  :diminish rspec-mode)

;; Use web mode for erb templates
(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode)))

;; For when current line and column display
;; is out of the screen
(bind-key "C-c l" 'what-line)

(provide 'init)
;;; init.el ends here
