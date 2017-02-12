;;; org-config.el --- Org mode configuration

;;; Commentary:

;;; Code:
(defvar org-directory "~/org")
(defvar org-agenda-files (list "~/org/bangthetable-tasks.org"))
(defvar org-default-notes-file (concat org-directory "/notes.org"))
(defvar org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/bangthetable-tasks.org" "BTT Tasks")
         "* TODO %?\n  %i\n  %a")))

(defun open-main-org-file()
  "Opens main org file"
  (interactive)
  (find-file "~/org/bangthetable-tasks.org"))

(with-eval-after-load 'org
  (bind-key "C-c a t" 'org-todo-list)
  (bind-key "C-c a a" 'org-agenda-list)
  (bind-key "C-c a m" 'org-tags-view)
  (bind-key "C-c c" 'org-capture)
  (bind-key "C-c o" 'open-main-org-file))

(defvar org-clock-persist 'history)
(org-clock-persistence-insinuate)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


(provide 'org-config)
;;; org-config.el ends here
