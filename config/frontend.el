;;; frontend.el --- configuration for frontend code

;;; Commentary:

;;; Code:

(add-hook 'scss-mode-hook 'rainbow-mode)

(use-package emmet-mode
  :ensure t)

(use-package haml-mode
  :ensure t)

(use-package coffee-mode
  :ensure t)

(use-package js2-mode
  :ensure t
  :config
  (setq js-indent-level 2))

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode)))

(provide 'frontend)
;;; frontend.el ends here
