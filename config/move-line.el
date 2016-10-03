;;; move-line.el --- Provides functionality to move lines up and down

;;; Commentary:

;;; Code:

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(bind-key [(control shift up)]  'move-line-up)
(bind-key [(control shift down)]  'move-line-down)

(provide 'move-line)

;;; move-line.el ends here
