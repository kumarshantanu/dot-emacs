(use-package inf-clojure
  :ensure t
  :pin melpa-stable
  :init
  (add-hook 'clojure-mode-hook #'inf-clojure-minor-mode)
  ;; eldoc
  (add-hook 'clojure-mode-hook #'eldoc-mode)
  (add-hook 'inf-clojure-mode-hook #'eldoc-mode))


(provide 'init-inf-clojure)
