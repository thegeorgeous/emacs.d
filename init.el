;;; init.el --- Init configuration for emacs

;;; Commentary:
;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; fix the emacs ui
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)

;; Newline at end of file
(setq require-final-newline t)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)
(setq select-enable-clipboard t) ;; Enable copy/past-ing from clipboard
(setq system-uses-terminfo nil) ;; Fix weird color escape sequences

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
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )

;; start emacs in fullscreen
(toggle-frame-fullscreen)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-company-mode t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (ruby-block scss-mode ac-haskell-process diminish spaceline smartparens yari robe xclip yaml-mode fill-column-indicator crux anzu emmet-mode helm-package helm-projectile haml-mode org markdown-mode helm-ag helm-flycheck helm-rails magit json-mode flycheck multiple-cursors zenburn-theme spacemacs-theme projectile js2-mode helm guru-mode company coffee-mode aggressive-indent ace-window))))

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
(require 'spaceline-config)
(spaceline-emacs-theme)

;; whitespace-mode config
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face tabs empty trailing lines-tail))
(global-whitespace-mode t)

(require 'ruby-end)
;; enable crux
(require 'crux)
(global-set-key (kbd "C-c I") #'crux-find-user-init-file)
(global-set-key (kbd "C-c D") #'crux-delete-file-and-buffer)
(global-set-key (kbd "C-c s") #'crux-swap-windows)
(global-set-key (kbd "C-c k") #'crux-kill-other-buffers)
(global-set-key (kbd "s-j") #'crux-top-join-line)
(global-set-key (kbd "C-c r") #'crux-rename-file-and-buffer)
(global-set-key (kbd "C-c S") #'crux-find-shell-init-file)
(global-set-key (kbd "s-k") #'crux-kill-whole-line)
(global-set-key [remap move-beginning-of-line] #'crux-move-beginning-of-line)

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
(guru-global-mode +1)
(setq guru-warn-only t)

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

;; set rubocop executable
(setq flycheck-ruby-rubocop-executable "~/.rbenv/shims/rubocop")

;; enable helm bindings for projectile
(helm-projectile-on)
(spaceline-helm-mode)

;; global-smartparens
(smartparens-global-mode)

;; Enable multiple-cursors-mode
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Highlight the current line
(global-hl-line-mode +1)

;; (setq flycheck-eslintrc "~/.eslintrc")


(provide 'init)
;;; init.el ends here
