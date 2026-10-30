;;; early-init.el --- Early startup -*- lexical-binding: t; -*-

;;; ---------------------------------------------------------------------------
;;; Package system
;;; ---------------------------------------------------------------------------
;; Disable automatic package activation; packages.el initializes manually.
(setq package-enable-at-startup nil)

;;; ---------------------------------------------------------------------------
;;; Frame / UI defaults
;;; ---------------------------------------------------------------------------
;; Set the whole alist at once so there are no duplicate keys and our
;; values always win over Emacs' built-in defaults.
(setq default-frame-alist
      '((fullscreen . maximized)
        (menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (vertical-scroll-bars . nil)
        (font . "Iosevka-20")))