;;; rails.el --- Config for Rails projects

;;; Commentary:

;;; Code:

(use-package enh-ruby-mode
  :ensure t
  :config
  (setq enh-ruby-program "/Users/thegeorgeous/.rbenv/shims/ruby"))

(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))

(use-package rspec-mode
  :ensure t
  :diminish rspec-mode)

(use-package yaml-mode
  :ensure t)

;; enable projectile-rails-mode
(use-package projectile-rails
  :ensure t
  :diminish projectile-rails-mode
  :config
  (add-hook 'projectile-mode-hook 'projectile-rails-on))


(provide 'rails)

;;; rails.el ends here
