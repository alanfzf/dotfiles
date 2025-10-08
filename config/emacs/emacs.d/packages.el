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

(use-package projectile
  :diminish projectile-mode
  :config
  (setq projectile-file-ignore-case t)
  (setq projectile-completion-system 'default)
  (projectile-mode +1)
  ;; Recommended keymap prefix
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package direnv
  :config
  (direnv-mode))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; Core LSP setup
(use-package lsp-mode
  :hook (
	 (php-ts-mode . lsp-deferred)
         )
  :commands lsp
  :config
  ;; intelephense stuff
  (setq lsp-intelephense-storage-path
        (expand-file-name "~/.intelephense"))
  (setq lsp-intelephense-licence-key
        (string-trim
         (with-temp-buffer
           (insert-file-contents
            (expand-file-name "~/.intelephense/licence.txt"))
           (buffer-string))))
  ;; Optional preferences
  (setq lsp-file-watch-threshold 5000)
  (setq lsp-headerline-breadcrumb-enable t
        lsp-enable-symbol-highlighting t
        lsp-keymap-prefix "C-c l"))
