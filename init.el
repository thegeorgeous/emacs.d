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

(load "core")      ;; core Emacs configurations
(load "move-line") ;; Functionality to move lines
(load "editor")    ;; Code editor configurations for Emacs
(load "project")   ;; Project management configurations
(load "rails")     ;; Rails related configurations
(load "terminal")  ;; Terminal tool shortcuts

;; set font family and size
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 160 :family "Inconsolata")))))


;; load zenburn theme
(use-package zenburn-theme
  :ensure t
  :init
  (load-theme 'zenburn t)
 )

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/railscasts-reloaded-theme/")
;; (load-theme 'railscasts-reloaded t)

;; Package List shortcut
(bind-key "C-x p" 'package-list-packages)

;; Emacs-Lisp mode keys
(bind-keys :map emacs-lisp-mode-map
           ("C-c C-b" . eval-buffer))

;; Org-mode
(with-eval-after-load 'org
  (global-set-key (kbd "C-c a t") #'org-todo-list))

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

;; set flycheck configurations
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq flycheck-ruby-rubocop-executable "/Users/thegeorgeous/.rbenv/shims/rubocop")
  (setq flycheck-haml-executable "~/.rbenv/shims/haml"))

;; Use web mode for erb templates
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode)))

(use-package zop-to-char
  :ensure t)

(use-package scss-mode
  :ensure t)

(use-package emmet-mode
  :ensure t)

(use-package haml-mode
  :ensure t)

(use-package ack
  :ensure t)

(use-package rainbow-mode
  :ensure t)

(use-package coffee-mode
  :ensure t)

(use-package js2-mode
  :ensure t
  :config
  (setq js-indent-level 2))

(use-package anaconda-mode
  :ensure t)

(use-package company-anaconda
  :ensure t)

(setenv "GOPATH" "/Users/thegeorgeous/project/golang")

;; Kill buffers for channels after /part
(require 'erc)
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
    (zop-to-char zenburn-theme yaml-mode web-mode use-package smartparens scss-mode rspec-mode rainbow-mode projectile-rails powerline org-pomodoro multiple-cursors monokai-theme markdown-mode magit js2-mode helm-projectile helm-ag haml-mode guru-mode go-mode flycheck-package fill-column-indicator exec-path-from-shell enh-ruby-mode emmet-mode dockerfile-mode dash-at-point crux company-anaconda coffee-mode beacon atom-one-dark-theme anzu ack ace-window))))
