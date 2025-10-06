(require 'treesit)

;; Enable use of tree-sitter modes by default when available
;; (setq major-mode-remap-defaults t)

(setq treesit-language-source-alist
   '((php "https://github.com/tree-sitter/tree-sitter-php")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))
