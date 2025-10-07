;; (use-package treesit-auto
;;   :custom
;;   (treesit-auto-install 'prompt)
;;   :config
;;   (treesit-auto-add-to-auto-mode-alist 'all)
;;   (global-treesit-auto-mode))


(setq treesit-language-source-alist
      '(
	(bash        "https://github.com/tree-sitter/tree-sitter-bash"       nil      "src")
        (c           "https://github.com/tree-sitter/tree-sitter-c"          nil      "src")
        (cpp         "https://github.com/tree-sitter/tree-sitter-cpp"        nil      "src")
        (css         "https://github.com/tree-sitter/tree-sitter-css"        nil      "src")
        (go          "https://github.com/tree-sitter/tree-sitter-go"         nil      "src")
        (html        "https://github.com/tree-sitter/tree-sitter-html"       nil      "src")
        (java        "https://github.com/tree-sitter/tree-sitter-java"       nil      "src")
        (javascript  "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (typescript  "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx         "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (json        "https://github.com/tree-sitter/tree-sitter-json"       nil      "src")
        (python      "https://github.com/tree-sitter/tree-sitter-python"     nil      "src")
        (rust        "https://github.com/tree-sitter/tree-sitter-rust"       nil      "src")
        (toml        "https://github.com/tree-sitter/tree-sitter-toml"       nil      "src")
        (yaml        "https://github.com/ikatyang/tree-sitter-yaml"          nil      "src")
        )
      )

;; Function to install missing grammars
(defun treesit-install-grammars ()
  (interactive)
  (dolist (grammar treesit-language-source-alist)
    (let ((lang (car grammar)))
      (unless (treesit-language-available-p lang)
        (treesit-install-language-grammar lang)))))

;; Call this function to install missing grammars
(treesit-install-grammars)

(require 'treesit)



;; (setq major-mode-remap-defaults t)
;; (setq treesit-language-source-alist '(
;; 	(org "https://github.com/emiasims/tree-sitter-org")
;; 	(lua  "https://github.com/tree-sitter-grammars/tree-sitter-lua")
;; 	(elisp "https://github.com/Wilfred/tree-sitter-elisp")
;;   )
;; )
;; (add-to-list 'major-mode-remap-alist '(
;; (lua-mode . lua-ts-mode)
;; ))
