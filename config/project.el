;;; project.el --- Project Mangement tool configurations

;;; Commentary:

;;; Code:

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
  ("C-c b" . magit-blame)
  :config
  (setq git-commit-summary-max-length 50)
  (git-commit-flyspell-verify))

;; enable projectile-globally
(use-package projectile
  :ensure t
  :config
  (projectile-mode))

(use-package helm-ag
  :ensure t)

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

;; Add markdown-mode
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(provide 'project)

;;; project.el ends here
