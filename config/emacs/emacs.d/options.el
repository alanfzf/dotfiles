;; set default site for custom file
(setq custom-file "~/.local/state/emacs/custom.el")
(load custom-file 'noerror 'nomessage)

;; ui settings
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode 1)
(setq ring-bell-function 'ignore)
(setq display-line-numbers-type 'relative)
(setq inhibit-startup-screen t)
(set-face-attribute 'default nil
		    :font "JetBrainsMono Nerd Font"
		    :height 140)

;; disable autosave
(setq backup-inhibited t
      make-backup-files nil
      auto-save-default nil)
(setq auto-save-list-file-prefix nil)

;; misc settings
(fset 'yes-or-no-p 'y-or-n-p)

;; adjust directories
(make-directory "~/.local/share/emacs/eln-cache" t)
(make-directory "~/.local/share/emacs/packages" t)
(setq native-comp-eln-load-path '("~/.local/share/emacs/eln-cache"))
(setq package-user-dir "~/.local/share/emacs/packages")
