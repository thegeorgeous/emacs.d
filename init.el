;;; init.el --- Init configuration for emacs

;;; Commentary:
;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; disable the menu bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; disable the splash screen
(setq inhibit-startup-message t)

;; enable melpa packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; start emacs in fullscreen
(toggle-frame-fullscreen)

;; disable scroll-bar
(scroll-bar-mode -1)

;; switch mac control and meta buttons
(setq mac-command-modifier 'control)
(setq mac-control-modifier 'super)

;; make cursor a line
(setq-default cursor-type 'bar)

;; set font family and size
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 160 :family "Inconsolata")))))

;; load spacemacs theme
(load-theme 'spacemacs-dark t)

;; delete file and buffer
(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (when (y-or-n-p (format "Are you sure you want to delete %s? " filename))
          (delete-file filename delete-by-moving-to-trash)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

(global-set-key (kbd "C-c D") 'delete-file-and-buffer)

;; kill-whole-line with indentation
(defun prelude-kill-whole-line (&optional arg)
  "A simple wrapper around command `kill-whole-line' that respects indentation.
Passes ARG to command `kill-whole-line' when provided."
  (interactive "p")
  (kill-whole-line arg)
  (back-to-indentation))

(global-set-key (kbd "C-c k") 'prelude-kill-whole-line)

;; Helm-bindings for common actions
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c f") 'helm-recentf)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

;; magit keys
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c b") 'magit-blame)

;; Move text
(global-set-key [control shift up]  'move-text-up)
(global-set-key [(control shift down)]  'move-text-down)

;; enable guru-global-mode
(guru-global-mode +1)
(setq guru-warn-only t)

;; enable projectile-globally
(projectile-global-mode)
;; enable flycheck-globally
(global-flycheck-mode)
;; enable helm bindings for projectile
(helm-projectile-on)

;; Enable multiple-cursors-mode
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; (setq flycheck-eslintrc "~/.eslintrc")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (emmet-mode helm-package helm-projectile haml-mode org markdown-mode helm-ag helm-flycheck helm-rails magit json-mode flycheck robe multiple-cursors zenburn-theme spacemacs-theme rubocop projectile js2-mode helm guru-mode company coffee-mode aggressive-indent ace-window))))

(provide 'init)
;;; init.el ends here
