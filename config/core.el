;;;; Core.el --- Setup a basic and sane Emacs

;;; Commentary:

;;; Code:

;; fix the emacs ui
(tool-bar-mode -1) ;; No toolbars
(blink-cursor-mode -1) ;; No blinking cursor
(scroll-bar-mode -1) ;; No ugly scrollbar
(setq ring-bell-function 'ignore)

;; show column number and size of file
(column-number-mode t)
(size-indication-mode t)

;; disable tabs
(setq-default indent-tabs-mode nil)


;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)
;; Enable copy/pasting from clipboard
(setq select-enable-clipboard t)
;; Replace selected text with what is typed
(delete-selection-mode 1)

;; Fix weird color escape sequences
(setq system-uses-terminfo nil)

;; Ask for confirmation before closing emacs
(setq confirm-kill-emacs 'yes-or-no-p)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(use-package exec-path-from-shell
  :ensure t
  :config
  (setq exec-path-from-shell-check-startup-files nil)
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

;; Always reload the file if it changed on disk
(global-auto-revert-mode 1)
(diminish 'auto-revert-mode)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; disable the splash screen
(setq inhibit-startup-message t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; start emacs in fullscreen
(toggle-frame-fullscreen)

;; set scratch buffer initial mode
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "\
# This buffer is for todo-lists that are not saved, and for Org mode.
# To create a file, visit that file with <open>, and enter text in its buffer.")

;; switch mac control and meta buttons
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'control)
  (setq mac-control-modifier 'super))

;; make cursor a line
(setq-default cursor-type 'bar)

;; set fill-column to 80
(setq-default fill-column 80)

;; Use the default powerline
(use-package powerline
  :ensure t
  :config
  (powerline-default-theme)
  (setq powerline-default-separator 'alternate))


(provide 'core)

;;; core.el ends here
