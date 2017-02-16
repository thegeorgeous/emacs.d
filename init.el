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
(setq custom-file "~/.emacs.d/config/custom.el")
(add-to-list 'load-path "~/.emacs.d/config")

(load "core")             ;; core Emacs configurations
(load "custom")           ;; custom configurations
(load "move-line")        ;; Functionality to move lines
(load "editor")           ;; Code editor configurations for Emacs
(load "project")          ;; Project management configurations
(load "rails")            ;; Rails related configurations
(load "frontend")         ;; Configuration for frontend languages
(load "terminal")         ;; Terminal tool shortcuts
(load "org-config")       ;; Org mode configuration

;; (use-package railscasts-reloaded-theme
;;   :ensure t
;;   :init
;;   (load-theme 'railscasts-reloaded t))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/railscasts-reloaded-theme/")
(load-theme 'railscasts-reloaded t)

;; Package List shortcut
(bind-key "C-x p" 'package-list-packages)

;; Emacs-Lisp mode keys
(bind-keys :map emacs-lisp-mode-map
           ("C-c C-b" . eval-buffer))

(use-package ack
  :ensure t)

(use-package rainbow-mode
  :ensure t)

;; Kill buffers for channels after /part
(require 'erc)
(bind-key "C-c i" 'erc)
(setq erc-kill-buffer-on-part t)

(use-package haskell-mode
  :ensure t)

(provide 'init)
;;; init.el ends here
