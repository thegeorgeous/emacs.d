;;; org-config.el --- Org mode configuration

;;; Commentary:

;;; Code:
(defvar org-agenda-files (list "~/org/bangthetable-tasks.org"))

(with-eval-after-load 'org
  (bind-key "C-c a t" 'org-todo-list))

(defvar org-clock-persist 'history)
(org-clock-persistence-insinuate)

(provide 'org-config)
;;; org-config.el ends here
