;;; init.el --- Main configuration -*- lexical-binding: t; -*-

;;; ---------------------------------------------------------------------------
;;; Custom file
;;; ---------------------------------------------------------------------------
;; Keep `custom-set-variables' / `custom-set-faces' out of init.el.
(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file nil 'nomessage))

;;; ---------------------------------------------------------------------------
;;; Packages
;;; ---------------------------------------------------------------------------
;; All package setup (archives, installs, theme, company) lives in packages.el.
;; It is loaded early so the theme and packages are ready before the rest of
;; this file runs.
(load (expand-file-name "packages" user-emacs-directory) nil 'nomessage)

;;; ---------------------------------------------------------------------------
;;; Backup files
;;; ---------------------------------------------------------------------------
;; Store all backup files under ~/.config/emacs/backups/ instead of
;; scattering `foo.txt~' files next to the originals (which pollutes git).
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups" user-emacs-directory))))

;; Copy the file instead of renaming it, so hard links / permissions survive.
(setq backup-by-copying t)

;; Rotate old backups so they don't pile up forever.
(setq delete-old-versions t)  ; delete excess old versions automatically
(setq kept-new-versions 6)    ; keep the 6 newest versions
(setq kept-old-versions 2)    ; keep the 2 oldest versions
(setq version-control t)      ; use versioned backup file names

;;; ---------------------------------------------------------------------------
;;; Basic appearance
;;; ---------------------------------------------------------------------------
;; Strip the GUI chrome for a cleaner, terminal-like look.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Highlight matching parentheses.
(show-paren-mode 1)

;; Skip the splash screen and go straight to the scratch buffer.
(setq inhibit-startup-screen t)

;; Set font on the current frame (GUI only). This is a safety net in case
;; early-init.el didn't apply for some reason.
(when (display-graphic-p)
  (set-face-attribute 'default nil :font "Iosevka-20"))

;;; ---------------------------------------------------------------------------
;;; Editing helpers
;;; ---------------------------------------------------------------------------
;; Auto-insert matching closing delimiters: { -> }, ( -> ), [ -> ]
(electric-pair-mode 1)

;;; ---------------------------------------------------------------------------
;;; Move text
;;; ---------------------------------------------------------------------------
;; `move-text' is installed and loaded in packages.el; here we only bind keys.
;; M-n = move down, M-p = move up (works on the active region or current line).
(global-set-key (kbd "M-n") 'move-text-down)
(global-set-key (kbd "M-p") 'move-text-up)

;;; ---------------------------------------------------------------------------
;;; Ido completion
;;; ---------------------------------------------------------------------------
;; Enable Ido for buffer/file switching, and use it everywhere possible.
(ido-mode 1)
(ido-everywhere 1)

;;; ---------------------------------------------------------------------------
;;; C mode
;;; ---------------------------------------------------------------------------
;; 4-space indentation, BSD style by default (Java/AWK keep their own styles).
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode  . "awk")
                                (other     . "bsd")))

;; Flip the default comment style on entry to c-mode
;; (e.g. prefer `//' over `/* */' where the style allows it).
(add-hook 'c-mode-hook
          (lambda ()
            (interactive)
            (c-toggle-comment-style -1)))

;;; ---------------------------------------------------------------------------
;;; Line numbers
;;; ---------------------------------------------------------------------------
;; Relative line numbers make Vim-style motions (e.g. `5j') easier.
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(column-number-mode 1)

;;; ---------------------------------------------------------------------------
;;; Dired
;;; ---------------------------------------------------------------------------
(require 'dired-x)

;; Hide dotfiles by default (toggle with `M-x dired-omit-mode').
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))

;; When two dired buffers are open, copy/move targets default to the other one.
(setq-default dired-dwim-target t)

;; Human-readable, long listing format.
(setq dired-listing-switches "-alh")

;; Allow dragging files with the mouse between dired buffers.
(setq dired-mouse-drag-files t)