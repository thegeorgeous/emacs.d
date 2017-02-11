;;;; custom.el --- customized configurations

;;; Commentary:

;;; Code:

;; set font family and size
(set-face-attribute 'default nil :height 140 :family "Fira Code")

(setq package-selected-packages
   (quote
    (zenburn-theme yasnippet yaml-mode web-mode use-package smartparens rspec-mode rainbow-mode railscasts-reloaded-theme projectile-rails powerline multiple-cursors markdown-mode magit js2-mode helm-projectile helm-ag haskell-mode haml-mode guru-mode flycheck fill-column-indicator exec-path-from-shell enh-ruby-mode emmet-mode dash-at-point crux coffee-mode beacon auto-complete anzu ack ace-window)))


(provide 'custom)

;;; custom.el ends here
