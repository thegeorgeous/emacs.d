;;; init.el --- Init configuration for emacs

;;; Commentary:

;;; Code:

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

;; Always reload the file if it changed on disk
(global-auto-revert-mode 1)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; disable the splash screen
(setq inhibit-startup-message t)

;; enable melpa packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; start emacs in fullscreen
(toggle-frame-fullscreen)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "824c02fec7dfb3affca5f5a3b8dddfb8ded6e23ba82b8a1c72191d66f2418b8c" "20e359ef1818a838aff271a72f0f689f5551a27704bf1c9469a5c2657b417e6c" default)))
 '(global-company-mode t)
 '(helm-mode t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (rainbow-mode company-inf-ruby beacon zop-to-char scss-mode diminish spaceline smartparens yari robe xclip yaml-mode crux anzu emmet-mode helm-package helm-projectile haml-mode org markdown-mode helm-ag helm-flycheck helm-rails magit json-mode flycheck multiple-cursors zenburn-theme spacemacs-theme projectile js2-mode helm guru-mode company coffee-mode aggressive-indent ace-window)))
 '(show-smartparens-global-mode t))

(diminish 'helm-mode)
;; switch mac control and meta buttons
(setq mac-command-modifier 'control)
(setq mac-control-modifier 'super)

;; make cursor a line
(setq-default cursor-type 'bar)

;; set font family and size
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 160 :family "Inconsolata")))))

;; load spacemacs theme
(load-theme 'spacemacs-dark t)

;; load the spaceline modeline theme
(require 'spaceline-config)
(spaceline-emacs-theme)
(setq powerline-default-separator 'wave)
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
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face tabs empty trailing lines-tail)) ;; Whitespace mode styles to be used
(set-face-attribute 'whitespace-line nil :background nil :foreground "#e4d836") ;; If line crossed line length the colour to be shown
(global-whitespace-mode t)
;; Remove trailing whitespace on save
(add-hook 'before-save-hook 'whitespace-cleanup t)
(diminish 'global-whitespace-mode)

;; CamelCase aware editing
(add-hook 'prog-mode-hook 'subword-mode)
(diminish 'subword-mode)
;; enable crux
(require 'crux)
(global-set-key (kbd "C-c I") #'crux-find-user-init-file)
(global-set-key (kbd "C-c D") #'crux-delete-file-and-buffer)
(global-set-key (kbd "C-c s") #'crux-transpose-windows)
(global-set-key (kbd "C-c k") #'crux-kill-other-buffers)
(global-set-key (kbd "s-j") #'crux-top-join-line)
(global-set-key (kbd "C-c r") #'crux-rename-file-and-buffer)
(global-set-key (kbd "C-c S") #'crux-find-shell-init-file)
(global-set-key (kbd "s-k") #'crux-kill-whole-line)
(global-set-key (kbd "C-c n") #'crux-cleanup-buffer-or-region)
(global-set-key (kbd "C-c TAB") #'crux-indent-rigidly-and-copy-to-clipboard)
(global-set-key [remap move-beginning-of-line] #'crux-move-beginning-of-line)


;; Package List shortcut
(global-set-key (kbd "C-x p") 'package-list-packages)

;; Emacs-Lisp mode keys
(eval-after-load "Emacs-Lisp"
  (define-key emacs-lisp-mode-map (kbd "C-c C-b") 'eval-buffer))

;; Org-src-mode
(defun org-edit-src-save-and-exit ()
  "Save org source code edit buffer and exit."
  (interactive)
  (org-edit-src-save)
  (org-edit-src-exit))
(global-set-key (kbd "C-c C-e") 'org-edit-src-save-and-exit)

;; helm-mode by default
(require 'helm)
(require 'helm-config)
(helm-mode 1)
(global-company-mode)

;; Helm-bindings for common actions
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c f") 'helm-recentf)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

;; magit keys
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c b") 'magit-blame)

;; avy and ace-window
(global-set-key (kbd "C-c j") 'avy-goto-word-or-subword-1)
(global-set-key (kbd "s-.") 'avy-goto-word-or-subword-1)
(global-set-key (kbd "s-w") 'ace-window)

;; enable guru-global-mode
(require 'guru-mode)
(guru-global-mode +1)
(setq guru-warn-only t)
(diminish 'guru-mode)

;; enable projectile-globally
(projectile-global-mode)
;; enable flycheck-globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; anzu mode globally
(require 'anzu)
(global-anzu-mode)
(diminish 'anzu-mode)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)


;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Start a regular shell
(global-set-key (kbd "C-x M-m") 'shell)

;; set flycheck configytttttgurations
(require 'flycheck)
(setq flycheck-ruby-rubocop-executable "~/.rbenv/shims/rubocop") ;; set rubocop executable
(setq flycheck-eslintrc "~/.eslintrc") ;; set config file for eslint

;; enable helm bindings for projectile
(helm-projectile-on)
;; (spaceline-helm-mode)

;; global-smartparens
(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode)
(show-smartparens-global-mode t)
(diminish 'smartparens-mode)

;; Enable multiple-cursors-mode
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Highlight the current line
(global-hl-line-mode +1)

(provide 'init)
;;; init.el ends here
