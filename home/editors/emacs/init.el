(setq-default evil-want-keybinding nil)
(load "~/.emacs.d/crol.el")
(load "~/.emacs.d/pkgs.el")

;; theme
(load-theme 'tsdh-dark t)
(setq custom--inhibit-theme-enable nil)
(with-eval-after-load 'tsdh-dark-theme
  (custom-theme-set-faces
   'tsdh-dark
   '(mode-line ((t (:background "gray15" ))))
   '(minibuffer-prompt ((t (:foreground "peru" :weight bold))))))

(set-face-attribute 'font-lock-builtin-face nil :foreground "light coral")
(set-face-attribute 'font-lock-regexp-grouping-backslash nil :foreground "dark turquoise")
(set-face-attribute 'font-lock-number-face nil :foreground "dodger blue")

;; org
(with-eval-after-load 'org
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
  (set-face-attribute 'org-level-1 nil :height 1.5 :weight 'bold)
  (set-face-attribute 'org-level-2 nil :height 1.3 :weight 'bold)
  (set-face-attribute 'org-level-3 nil :height 1.1 :weight 'bold))
(setq org-startup-with-latex-preview t)



;;(set-frame-parameter nil 'alpha-background 70)
;;(set-frame-parameter nil 'alpha-background 100)



;; mode line
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

;; unused
(tool-bar-mode -1)
(menu-bar-mode -1)
(add-hook 'after-init-hook (lambda () (scroll-bar-mode -1)))
(blink-cursor-mode -1)

;; font
(setq default-frame-alist '((font . "Hack")))
(set-face-attribute 'default nil :font "Hack" :height 150)

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


;; lower a bit
(setq echo-keystrokes 0.02)

;; dired list order
(setq ls-lisp-dirs-first t)
(setq ls-lisp-use-insert-directory-program nil)
(setq dired-listing-switches "-al")

;;  _    _         _
;; | |__(_)_ _  __| |___
;; | '_ \ | ' \/ _` (_-<
;; |_.__/_|_||_\__,_/__/

(global-set-key (kbd "C-x C-b") 'crol-buffer-switch)
(global-set-key (kbd "C-x b") 'crol-list-buffer)

(global-set-key (kbd "C-k") 'previous-error)
(global-set-key (kbd "C-j") 'next-error)

(global-set-key (kbd "C-s") nil)

(global-set-key (kbd "C-c d u") #'direnv-update-environment)

(with-eval-after-load 'evil
                      (global-set-key (kbd "C-S-v") (lambda () (interactive) (progn (evil-paste-before 1) (evil-forward-char 1)))))
(global-set-key (kbd "C-x C-c") 'compile)
(global-set-key (kbd "C-x C-r") 'recompile)

;; window movement

(define-key vterm-mode-map (kbd "M-H") nil)
(define-key vterm-mode-map (kbd "M-J") nil)
(define-key vterm-mode-map (kbd "M-K") nil)
(define-key vterm-mode-map (kbd "M-L") nil)

(global-set-key (kbd "M-H") 'windmove-left)
(global-set-key (kbd "M-J") 'windmove-down)
(global-set-key (kbd "M-K") 'windmove-up)
(global-set-key (kbd "M-L") 'windmove-right)

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

(add-hook 'prog-mode-hook 'eglot-ensure)

;; disable ref highligth & inlay hint
(setq eglot-ignored-server-capabilites '(:documentHighlightProvider :inlayHintProvider))

;; make docs in echo area smaller
(setq eldoc-echo-area-prefer-doc-buffer t)
(setq eldoc-echo-area-use-multiline-p nil)

(setq eglot-send-changes-idle-time 0.2)
(setq eldoc-idle-delay 0.2)

(set-face-attribute 'eldoc-box-border nil :background "gray35")
(setq eldoc-box-cleanup-interval 0.1)

;;   __ _ __  _ __
;;  / _| '  \| '_ \
;;  \__|_|_|_| .__/
;;           |_|

(require 'corfu-popupinfo)

(global-corfu-mode)
(setq corfu-auto nil)
(setq corfu-popupinfo-mode t)
(setq corfu-popupinfo-delay 0.5)

;; idk how to disable this crap so..
(setq yas-keymap nil)
(custom-set-faces '(yas-field-highlight-face ((t ()))))

;;    __      _
;;   / _|_ __| |_
;;  |  _| '  \  _|
;;  |_| |_|_|_\__|

(format-all-mode)

(setq-default
 format-all-formatters
 '(("Nix" (alejandra))
   ("Markdown" (prettier "--tab-width=4"))
   ("Java" (clang-format "--style={\"BasedOnStyle\": \"Mozilla\", \"IndentWidth\": 4}"))
   ("Go" (gofmt))
   ("C" (clang-format "--style={\"BasedOnStyle\": \"Mozilla\", \"IndentWidth\": 4}"))))

;;        _ _
;;   __ _(_) |_
;;  / _` | |  _|
;;  \__, |_|\__|
;;  |___/

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

;;   __ _         _
;;  / _(_)_ _  __| |
;; |  _| | ' \/ _` |
;; |_| |_|_||_\__,_|

(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)

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

;; undo tree
(setq undo-tree-history-directory-alist `(("." . ,(concat user-emacs-directory "undo-tree"))))
(setq undo-tree-visualizer-timestamps t)
(global-undo-tree-mode)


;; org-fragtog
(add-hook 'org-mode-hook 'org-fragtog-mode)

(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)
(popwin-mode 1)


;; gcmh
(setq gcmh-idle-delay 5)
(setq gcmh-high-cons-threshold (* (expt 2 20) 16))  ; 16MB
(gcmh-mode 1)
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* (expt 2 20) 16))))




;;  _____   _____ _
;; | __\ \ / /_ _| |
;; | _| \ V / | || |__
;; |___| \_/ |___|____|

(evil-mode 1)

;; evil-collection
(setq evil-collection-key-blacklist '("K" "(" ")" "C-j" "C-k"))
(evil-collection-init)
(evil-set-initial-state 'vterm-mode 'emacs)

;; evil-surround
(global-evil-surround-mode 1)


;; evil-goggles
(setq evil-goggles-enable-delete nil)
(setq evil-goggles-enable-change nil)
(setq evil-goggles-duration 0.08)
(evil-goggles-mode)


(evil-set-undo-system 'undo-tree)

;; evil binds
(with-eval-after-load 'evil
  ;; C-u for half-screen up
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

  ;; "unbind" 'K' and 'J' in visual
  (define-key evil-visual-state-map (kbd "K") 'evil-previous-line)
  (define-key evil-visual-state-map (kbd "J") 'evil-next-line)

  ;; lsp binds
  (define-key evil-normal-state-map (kbd "SPC r n") 'eglot-rename)
  (define-key evil-normal-state-map (kbd "[ d") 'flymake-goto-prev-error)
  (define-key evil-normal-state-map (kbd "] d") 'flymake-goto-next-error)
  (define-key evil-normal-state-map (kbd "SPC c a") 'eglot-code-actions)
  (define-key evil-insert-state-map (kbd "C-h") 'eldoc-box-help-at-point)
  (define-key evil-normal-state-map (kbd "K") 'eldoc-box-help-at-point) ; replaces `eldoc-doc-buffer

  ;; cmp
  (define-key evil-insert-state-map (kbd "C-y") 'corfu-insert)
  (define-key evil-insert-state-map (kbd "C-c") 'completion-at-point)

  ;; fmt
  (define-key evil-normal-state-map (kbd "M-f") 'format-all-buffer)

  ;; misc
  (define-key evil-normal-state-map (kbd "SPC w w") 'maximize-window)
  (define-key evil-normal-state-map (kbd "C-b g") 'magit)

  (define-key evil-motion-state-map (kbd "(") nil)
  (define-key evil-motion-state-map (kbd ")") nil)

  (define-key evil-visual-state-map (kbd "M-j") 'crol-move-text-region-down)
  (define-key evil-visual-state-map (kbd "M-k") 'crol-move-text-region-up)

  ;; brrr
  (define-key evil-normal-state-map (kbd "s") 'avy-goto-char-2)

  ;; unbind tab
  (define-key evil-motion-state-map (kbd "TAB") nil)
  (define-key evil-insert-state-map (kbd "TAB") (lambda () (interactive) (insert "  ")))

  (define-key evil-normal-state-map (kbd "M-`") 'vterm)
  (define-key evil-normal-state-map (kbd "-") 'dired-jump))
