;;;; custom.el --- customized configurations

;;; Commentary:

;;; Code:

;; set font family and size
(set-face-attribute 'default nil :height 140 :family "Fira Code")


(provide 'custom)

;;; custom.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dockerfile-mode yasnippet yaml-mode websocket web-mode use-package smartparens rspec-mode request rainbow-mode railscasts-reloaded-theme projectile-rails powerline org-bullets oauth2 multiple-cursors markdown-mode magit js2-mode helm-projectile helm-ag haskell-mode haml-mode guru-mode flycheck fill-column-indicator exec-path-from-shell enh-ruby-mode emojify emmet-mode dash-at-point crux coffee-mode circe beacon auto-complete anzu alert ack ace-window)))
 )
