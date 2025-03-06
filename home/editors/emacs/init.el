;; theme
(load-theme 'tsdh-dark t)
(setq custom--inhibit-theme-enable nil)
(with-eval-after-load 'tsdh-dark-theme
  (custom-theme-set-faces
   'tsdh-dark
   '(mode-line ((t (:background "gray15" ))))
   '(minibuffer-prompt ((t (:foreground "peru" :weight bold))))))

(with-eval-after-load 'org
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
  (set-face-attribute 'org-level-1 nil :height 1.5 :weight 'bold)
  (set-face-attribute 'org-level-2 nil :height 1.3 :weight 'bold)
  (set-face-attribute 'org-level-3 nil :height 1.1 :weight 'bold))

;;(set-frame-parameter nil 'alpha-background 70)
;;(set-frame-parameter nil 'alpha-background 100)
;;(setq compilation-environment '("TERM=xterm-257color"))
;;(setq compilation-environment nil)

(defun crol-evil-visual-selection-info ()
  "Show the number of selected characters/lines in visual mode."
  (when (evil-visual-state-p)
    (let* ((beg (region-beginning))
           (end (region-end))
           (lines (count-lines beg end))
           (chars (- end beg)))
      (format " [V:%dL %dC] " (1+ lines) (1+ chars)))))

(setq-default mode-line-format
              '("%e" mode-line-front-space
                (:propertize
                 ("" mode-line-mule-info mode-line-client mode-line-modified
                  mode-line-remote mode-line-window-dedicated)
                 display (min-width (6.0)))
                mode-line-frame-identification mode-line-buffer-identification " "
                " (%l,%c) " (:eval (crol-evil-visual-selection-info))
                mode-line-position evil-mode-line-tag
                (project-mode-line project-mode-line-format) (vc-mode vc-mode) "  "
                mode-line-modes mode-line-misc-info mode-line-end-spaces))

(tool-bar-mode -1)
(menu-bar-mode -1)
(add-hook 'after-init-hook (lambda () (scroll-bar-mode -1)))

(blink-cursor-mode -1)

;; font
(setq default-frame-alist '((font . "Hack")))
(set-face-attribute 'default nil :font "Hack" :height 150)

(set-face-attribute 'font-lock-builtin-face nil :foreground "light coral")
(set-face-attribute 'font-lock-regexp-grouping-backslash nil :foreground "dark turquoise")
(set-face-attribute 'font-lock-number-face nil :foreground "dodger blue")

;; custom file
(setq custom-file "~/.emacs.d/emacs.custom.el")

;; line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(pixel-scroll-precision-mode t)

;; line wrap off
(setq-default truncate-lines t)

;; normal scrolling
(setq scroll-step 1)
(setq scroll-margin 5)
(setq hscroll-step 1)
(setq auto-window-vscroll nil)
(setq scroll-conservatively 101)

;; normal tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)


(setq echo-keystrokes 0.3)

(setq ls-lisp-dirs-first t)
(setq ls-lisp-use-insert-directory-program nil)
(setq dired-listing-switches "-al")

;;  _    _         _
;; | |__(_)_ _  __| |___
;; | '_ \ | ' \/ _` (_-<
;; |_.__/_|_||_\__,_/__/

;; rebind M-t because it looks usefull
(global-set-key (kbd "M-y") 'transpose-words)

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

(global-set-key (kbd "C-x C-b") 'crol-buffer-switch)
(global-set-key (kbd "C-x b") 'crol-list-buffer)

(global-set-key (kbd "C-k") 'previous-error)
(global-set-key (kbd "C-j") 'next-error)

(global-set-key (kbd "C-s") nil)

;;;         _
;;;    _ __| |____ _ ___
;;;   | '_ \ / / _` (_-<
;;;   | .__/_\_\__, /__/
;;;   |_|      |___/

;;(load "~/.emacs.d/pkg.el")
;;(load "~/.emacs.d/tmp.el")

;;                _
;;  _ __  ___  __| |___ ___
;; | '  \/ _ \/ _` / -_|_-<
;; |_|_|_\___/\__,_\___/__/
(require 'nix-mode)
(require 'web-mode)
(require 'go-mode)
(require 'lua-mode)
(require 'php-mode)
(require 'groovy-mode)
(require 'ron-mode)
(require 'markdown-mode)
(require 'rust-mode)
(require 'yuck-mode)



;;              _
;;  _ _ _  _ __| |_
;; | '_| || (_-<  _|
;; |_|  \_,_/__/\__|

;; auto turn on lsp
;;(add-hook 'rust-mode-hook 'eglot-ensure)
(setq rust-mode-treesitter-derive t)



;;   __
;;  / _|
;;  \__|

(setq-default c-basic-offset 4)
(add-hook 'c-mode-hook
          (lambda () (interactive)
            (c-toggle-comment-style -1)))


;;  _
;; | |____ __
;; | (_-< '_ \
;; |_/__/ .__/
;;      |_|

(require 'eglot)
(add-hook 'prog-mode-hook 'eglot-ensure)

;; disable ref highligth & inlay hint
(setq eglot-ignored-server-capabilites '(:documentHighlightProvider :inlayHintProvider))

;; make docs in echo area smaller
(setq eldoc-echo-area-prefer-doc-buffer t)
(setq eldoc-echo-area-use-multiline-p nil)
(setq eglot-send-changes-idle-time 0.2)
(setq eldoc-idle-delay 0.2)


;;   __ _ __  _ __
;;  / _| '  \| '_ \
;;  \__|_|_|_| .__/
;;           |_|

(require 'corfu)
(require 'corfu-popupinfo)

(global-corfu-mode)
(setq corfu-auto nil)
(setq corfu-popupinfo-mode t)
(setq corfu-popupinfo-delay 0.5)

(require 'yasnippet)
;; idk how to disable this crap so..
(setq yas-keymap nil)
(custom-set-faces '(yas-field-highlight-face ((t ()))))

;;    __      _
;;   / _|_ __| |_
;;  |  _| '  \  _|
;;  |_| |_|_|_\__|

(require 'format-all)

(format-all-mode)

(setq-default format-all-formatters
              '(("Nix" (alejandra))
                ("Markdown" (prettier "--tab-width=4"))
                ("Java" (clang-format "--style={\"BasedOnStyle\": \"Mozilla\", \"IndentWidth\": 4}"))
                ("Go" (gofmt))))

;;        _ _
;;   __ _(_) |_
;;  / _` | |  _|
;;  \__, |_|\__|
;;  |___/
(require 'magit)
(require 'diff-hl)
(require 'dired-gitignore)

(require 'diff-hl-flydiff)
(require 'diff-hl-dired)

(diff-hl-flydiff-mode)
(global-diff-hl-mode)

(setq magit-no-confirm '(stage-all-changes unstage-all-changes))

;; set fringe color back to background
(set-face-background 'fringe "gray20")
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

(dired-gitignore-global-mode t)
(global-set-key (kbd "C-x i") 'dired-gitignore-global-mode)


;;               _
;;  _  _ _ _  __| |___
;; | || | ' \/ _` / _ \
;;  \_,_|_||_\__,_\___/
(require 'undo-tree)
(setq undo-tree-history-directory-alist `(("." . ,(concat user-emacs-directory "undo-tree"))))
(setq undo-tree-visualizer-timestamps t)
(global-undo-tree-mode)


;;   __ _         _
;;  / _(_)_ _  __| |
;; |  _| | ' \/ _` |
;; |_| |_|_||_\__,_|

(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)

(require 'fzf)
(require 'rg)
(require 'smex)
(require 'ido-completing-read+)

(ido-ubiquitous-mode 1)

(global-set-key
 (kbd "C-x C-t")
 (lambda ()
   (interactive)
   (if (vc-root-dir)
       (fzf-git-files)
     (fzf))))

(global-set-key (kbd "M-x") 'smex)

;; swap these
(global-set-key (kbd "C-x C-d") 'ido-dired)
(global-set-key (kbd "C-x d") 'ido-list-directory)



;;        _
;;  _ __ (_)___ __
;; | '  \| (_-</ _|
;; |_|_|_|_/__/\__|

(require 'harpoon)
(require 'popwin)
(require 'ispell)
(require 'elcord)
(require 'org-fragtog)
(require 'nerd-icons)
(require 'nerd-icons-dired)
(require 'vterm)

(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)
(elcord-mode)
(popwin-mode 1)



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


;;  _____   _____ _
;; | __\ \ / /_ _| |
;; | _| \ V / | || |__
;; |___| \_/ |___|____|
(setq-default evil-want-keybinding nil)

(require 'evil)
(require 'evil-collection)
(require 'evil-surround)
(require 'evil-goggles)

(evil-mode 1)
(evil-collection-init)
(evil-set-initial-state 'vterm-mode 'emacs)
(global-evil-surround-mode 1)
(setq evil-goggles-enable-delete nil)
(setq evil-goggles-enable-delete nil)
(evil-goggles-mode)
(evil-set-undo-system 'undo-tree)

;; evil binds
(with-eval-after-load 'evil
  ;; C-u for half-screen up
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

  ;; "unbind" 'K' and 'J' in visual
  (define-key evil-visual-state-map (kbd "K") 'evil-previous-line)
  (define-key evil-visual-state-map (kbd "J") 'evil-next-line)

  ;; window movement
  (global-set-key (kbd "M-H") 'evil-window-left)
  (global-set-key (kbd "M-J") 'evil-window-down)
  (global-set-key (kbd "M-K") 'evil-window-up)
  (global-set-key (kbd "M-L") 'evil-window-right)

  ;; lsp binds
  (define-key evil-normal-state-map (kbd "SPC r n") 'eglot-rename)
  (define-key evil-normal-state-map (kbd "[ d") 'flymake-goto-prev-error)
  (define-key evil-normal-state-map (kbd "] d") 'flymake-goto-next-error)
  (define-key evil-insert-state-map (kbd "C-h") 'eldoc)
  (define-key evil-normal-state-map (kbd "SPC c a") 'eglot-code-actions)

  ;; cmp
  (define-key evil-insert-state-map (kbd "C-y") 'corfu-insert)
  (define-key evil-insert-state-map (kbd "C-c") 'completion-at-point)

  ;; cmp
  (define-key evil-normal-state-map (kbd "M-f") 'format-all-buffer)

  ;; harpoon
  (define-key evil-normal-state-map (kbd "SPC z") 'harpoon-toggle-file)
  (define-key evil-normal-state-map (kbd "SPC a") 'harpoon-add-file)
  (define-key evil-normal-state-map (kbd "M-a") 'harpoon-go-to-1)
  (define-key evil-normal-state-map (kbd "M-o") 'harpoon-go-to-2)
  (define-key evil-normal-state-map (kbd "M-e") 'harpoon-go-to-3)
  (define-key evil-normal-state-map (kbd "M-u") 'harpoon-go-to-4)
  (define-key evil-normal-state-map (kbd "M-i") 'harpoon-go-to-5)
  (define-key evil-normal-state-map (kbd "M-d") 'harpoon-go-to-6)


  ;; misc
  (define-key evil-normal-state-map (kbd "SPC t") (lambda () (interactive) (shell-command "tmux send-keys -t dev:1 ' t'")))
  (define-key evil-normal-state-map (kbd "SPC l") (lambda () (interactive) (shell-command "tmux send-keys -t dev:1 '\x17l\x17q'")))
  (define-key evil-normal-state-map (kbd "C-x C-g") (lambda () (interactive) (shell-command "tmux send-keys -t dev:1 ' t tIIggW ga'")))

  (define-key evil-insert-state-map (kbd "C-S-v") 'evil-paste-after)
  (define-key evil-normal-state-map (kbd "SPC w w") 'maximize-window)
  (define-key evil-normal-state-map (kbd "C-x C-c") 'compile)
  (define-key evil-normal-state-map (kbd "C-x C-r") 'recompile)
  (define-key evil-normal-state-map (kbd "C-b g") 'magit)
  (define-key evil-normal-state-map (kbd "Tab") nil)
  (define-key evil-normal-state-map (kbd "-") 'dired-jump))
