(defvar emacs-dir (file-name-directory load-file-name)
  "The root dir of the Emacs configuration.")

(desktop-save-mode 1)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; config changes made through the customize UI will be store here
(setq custom-file (expand-file-name "custom.el" emacs-dir))

;; Patch security vulnerability in Emacs versions older than 25.3
(when (version< emacs-version "25.3")
  (eval-after-load "enriched"
    '(defun enriched-decode-display-prop (start end &optional param)
       (list start end))))


;; INSTALLING PACKAGES

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)


;; GENERAL PACKAGES

(use-package magit
  :straight t)
(use-package gitconfig-mode
  :straight t)
(use-package gitignore-mode
  :straight t)
(use-package dockerfile-mode
  :straight t)


;; CONFIGURATION SECTIONS

(defvar config-dir (expand-file-name "config" emacs-dir))

(load (expand-file-name "general.el" config-dir))
(load (expand-file-name "theme.el" config-dir))
(load (expand-file-name "terminal.el" config-dir))
(load (expand-file-name "ido.el" config-dir))
(load (expand-file-name "programming.el" config-dir))
(load (expand-file-name "markup.el" config-dir))
(load (expand-file-name "web.el" config-dir))
(load (expand-file-name "php.el" config-dir))
(load (expand-file-name "lisp.el" config-dir))
(load (expand-file-name "python.el" config-dir))
(load (expand-file-name "music.el" config-dir))
