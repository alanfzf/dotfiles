;; package manager
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(require 'use-package)
(setq use-package-always-ensure t)

;; installed packages
(use-package disable-mouse
  :config
  (global-disable-mouse-mode))

(use-package fzf
  :preface
  (defun fzf-here ()
    "Use fzf to find a file starting in the current buffer's pwd."
    (interactive)
    (fzf-find-file default-directory))

  :bind
  (
   ("C-c f" . fzf-here)
   ("C-c g" . fzf-git))
  )

(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode +1)
  ;; Recommended keymap prefix
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
