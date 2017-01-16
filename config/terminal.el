;;; terminal.el --- Termainal tools config

;;; Commentary:

;;; Code:

;; Start eshell or switch to it if it's active.
(bind-key "C-c e" 'eshell)

;; Start a regular shell
(bind-key "C-c M-m" 'shell)

;; Start an ansi-term
(bind-key "C-c t" 'ansi-term)

(provide 'terminal)

;;; terminal.el ends here
