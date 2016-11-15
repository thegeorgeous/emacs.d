;;; editor.el --- Configurations to add awesome editor capabalities

;;; Commentary:

;;; Code:

(use-package beacon
  :ensure t)

;; set size of files to open without warning
(setq large-file-warning-threshold 100000000)

;; whitespace-mode config
(use-package whitespace
  :diminish global-whitespace-mode
  :config
  (setq whitespace-line-column 80)
  (setq whitespace-style '(tabs empty trailing))
  (global-whitespace-mode t)
  (add-hook 'before-save-hook 'whitespace-cleanup t))

;; add blank line at end of file
(setq require-final-newline t)

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

;; anzu mode globally
(use-package anzu
  :ensure t
  :diminish anzu-mode
  :config
  (global-anzu-mode)
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp)))

;; global-smartparens
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :init
  (require 'smartparens-config)
  (require 'smartparens-ruby)
  :config
  (smartparens-global-mode)
  (show-smartparens-global-mode t))

;; Enable multiple-cursors-mode
(use-package multiple-cursors
  :ensure t
  :bind (("C-<" . mc/mark-previous-like-this)
         ("C->" . mc/mark-next-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; Highlight the current line
(global-hl-line-mode +1)

(use-package fill-column-indicator
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'fci-mode))

;; For when current line and column display
;; is out of the screen
(bind-key "C-c l" 'what-line)

;; enable guru-global-mode
(use-package guru-mode
  :ensure t
  :diminish guru-mode
  :config
  (guru-global-mode +1))

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

(use-package dash-at-point
  :ensure t
  :bind
  ("C-c d" . dash-at-point)
  :config
  (add-to-list 'dash-at-point-mode-alist '(enh-ruby-mode . "ruby,rubygems,rails")))

;; set flycheck configurations
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq flycheck-ruby-rubocop-executable "/Users/thegeorgeous/.rbenv/shims/rubocop")
  (setq flycheck-haml-executable "~/.rbenv/shims/haml"))

(provide 'editor)


;;; editor.el ends here
