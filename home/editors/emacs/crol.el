
(require 'ansi-color)

(defvar crol-colorize-compilation-buffer-enabled nil)
(defun crol-colorize-compilation-buffer ()
  (when crol-colorize-compilation-buffer-enabled
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max)))))

(defun crol-toggle-colorize-compilation-buffer ()
  (interactive)
  (setq crol-colorize-compilation-buffer-enabled
        (not crol-colorize-compilation-buffer-enabled))
  (if crol-colorize-compilation-buffer-enabled
      (add-hook 'compilation-filter-hook 'crol-colorize-compilation-buffer)
    (remove-hook 'compilation-filter-hook #'crol-colorize-compilation-buffer))
  (message "Colorizing compilation buffer: %s"
           (if crol-colorize-compilation-buffer-enabled "ON" "OFF")))



(defun crol-evil-visual-selection-info ()
  "Show the number of selected characters/lines in visual mode."
  (when (evil-visual-state-p)
    (let* ((beg (region-beginning))
           (end (region-end))
           (lines (count-lines beg end))
           (chars (- end beg)))
      (format " [V:%dL %dC] " (1+ lines) (1+ chars)))))


(defun crol-buffer-switch ()
  "ido switch outside of project & only project buffers inside one"
  (interactive)
  (if (project-current)
      (project-switch-to-buffer (project--read-project-buffer))
    (ido-switch-buffer)))

(defun crol-list-buffer ()
  "list all duffers outside of project & only project buffers inside one"
  (interactive)
  (if (project-current)
      (project-list-buffers)
    (list-buffers)))



(defun crol-hex-to-dec (hex)
  "hex to dec convert"
  (interactive "sEnter hex (without 0x): ")
  (message "Dec: %d" (string-to-number hex 16)))

(defun crol-dec-to-hex (dec)
  "dec to hex convert"
  (interactive "nEnter dec: ")
  (message "Hex: %x" dec))


(defun crol-toggle-line-numbers ()
  "toggles on/off line numbers"
  (interactive)
  (if display-line-numbers-type
      (setq display-line-numbers-type nil)
    (setq display-line-numbers-type 'relative)))
