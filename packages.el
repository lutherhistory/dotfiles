;;; packages.el --- Package configuration -*- lexical-binding: t; -*-

;;; ---------------------------------------------------------------------------
;;; Package archives
;;; ---------------------------------------------------------------------------
(require 'package)

;; GNU ELPA + MELPA. MELPA is required for gruber-darker-theme, company,
;; move-text, and magit.
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

;; We disabled automatic activation in early-init.el, so initialize manually.
(package-initialize)

;;; ---------------------------------------------------------------------------
;;; Install missing packages
;;; ---------------------------------------------------------------------------
;; Refresh the package index only once if anything is missing.
(let ((wanted '(gruber-darker-theme batppuccin company move-text magit)))
  (when (cl-some (lambda (pkg) (not (package-installed-p pkg))) wanted)
    (package-refresh-contents)
    (dolist (pkg wanted)
      (unless (package-installed-p pkg)
        (package-install pkg)))))

;;; ---------------------------------------------------------------------------
;;; Theme
;;; ---------------------------------------------------------------------------
;; Override the background *before* loading the theme so the change takes
;; effect. `bat-base' is the Mocha base background color.
(setq batppuccin-override-colors-alist
      '(("bat-base" . "#111111")))

(load-theme 'batppuccin-mocha t)

;;; ---------------------------------------------------------------------------
;;; Company (completion)
;;; ---------------------------------------------------------------------------
(require 'company)
(add-hook 'after-init-hook #'global-company-mode)

;;; ---------------------------------------------------------------------------
;;; Move-text
;;; ---------------------------------------------------------------------------
;; `move-text' is installed above, but we also need to load it so that the
;; movement commands are available. Bindings are set in init.el.
(require 'move-text)

;;; ---------------------------------------------------------------------------
;;; Magit
;;; ---------------------------------------------------------------------------
;; Lazy-load Magit: it is only pulled in when you actually open the status
;; buffer, keeping startup fast and memory low.
(global-set-key (kbd "C-x g") 'magit-status)