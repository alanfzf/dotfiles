;; package manager
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; other settings
(setq custom-file "~/.emacs.custom.el")
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(setq ring-bell-function 'ignore)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(set-face-attribute 'default nil
  :font "JetBrainsMono Nerd Font"
  :height 140)

;; misc settings
(fset 'yes-or-no-p 'y-or-n-p)

;; keybinds
(global-set-key (kbd "C-;") 'comment-line)

;; custom packages
(use-package doom-themes)

(use-package company
  :config
  (global-company-mode))

(use-package ivy
  :config
  (ivy-mode 1))

(use-package counsel
  :after ivy
  :config
  (counsel-mode 1))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)))

(use-package disable-mouse
  :config
  (global-disable-mouse-mode)
)
