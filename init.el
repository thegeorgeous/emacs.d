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

(add-to-list 'load-path "~/.emacs.d/config")

(load "core")             ;; core Emacs configurations
(load "move-line")        ;; Functionality to move lines
(load "editor")           ;; Code editor configurations for Emacs
(load "project")          ;; Project management configurations
(load "rails")            ;; Rails related configurations
(load "frontend")         ;; Configuration for frontend languages
(load "terminal")         ;; Terminal tool shortcuts
(load "org-config")       ;; Org mode configuration

;; set font family and size
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 140 :family "Fira Code")))))

(use-package railscasts-reloaded-theme
  :ensure t
  :init
  (load-theme 'railscasts-reloaded t))

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/railscasts-reloaded-theme/")
;; (load-theme 'railscasts-reloaded t)

;; Package List shortcut
(bind-key "C-x p" 'package-list-packages)

;; Emacs-Lisp mode keys
(bind-keys :map emacs-lisp-mode-map
           ("C-c C-b" . eval-buffer))

(use-package zop-to-char
  :ensure t)

(use-package ack
  :ensure t)

(use-package rainbow-mode
  :ensure t)

;; Kill buffers for channels after /part
(require 'erc)
(bind-key "C-c i" 'erc)
(setq erc-kill-buffer-on-part t)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rainbow-mode ack zop-to-char railscasts-reloaded-theme web-mode js2-mode coffee-mode haml-mode emmet-mode projectile-rails yaml-mode rspec-mode enh-ruby-mode markdown-mode helm-projectile helm-ag projectile magit helm yasnippet flycheck ace-window avy guru-mode fill-column-indicator multiple-cursors smartparens auto-complete anzu crux beacon powerline exec-path-from-shell use-package))))
