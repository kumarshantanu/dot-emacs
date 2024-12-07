;; A lean setup for Clojurians


(require 'package)

;; Define package repositories
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq package-check-signature nil)
(package-initialize)
;; Automatically reload files when they change on disk
(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)


;; Install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'gnu-elpa-keyring-update)
  (package-install 'use-package))
; could be right after (package-refresh-contents), here for unconditional
(setq package-check-signature 'allow-unsigned)
(require 'use-package)
(setq use-package-verbose t)
(setq-default use-package-always-ensure t)


;; Show full file path in the title bar
(setq
 frame-title-format
 '((:eval (if (buffer-file-name)
              (abbreviate-file-name (buffer-file-name))
            "%b"))))


;; Use y/n instead of full yes/no for confirmation messages
(fset 'yes-or-no-p 'y-or-n-p)


;; Line numbers
; (global-linum-mode t)  ; on Emacs 28 or older
(global-display-line-numbers-mode 1)  ; on Emacs 26 or later


;; Remove trailing whitespace before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; M-x with recently/frequently used commands
(use-package smex)
(global-set-key (kbd "M-x") 'smex)


;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))


;; Move custom configuration variables set by Emacs, to a seperate file
(setq custom-file (concat user-emacs-directory "/custom.el"))
(load custom-file 'noerror)


;; Install and setup company-mode for autocompletion
(use-package company
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'company-mode)
  :config
  (global-company-mode)
  (setq company-tooltip-limit 10)
  (setq company-idle-delay 0.2)
  (setq company-echo-delay 0)
  (setq company-minimum-prefix-length 3)
  (setq company-require-match nil)
  (setq company-selection-wrap-around t)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  ;; weight by frequency
  (setq company-transformers '(company-sort-by-occurrence)))


;; Better syntax highlighting
(use-package clojure-mode-extra-font-locking
  :ensure t)


;; Set background colour for (selected) region
(set-face-attribute 'region nil :background "#ccc")


;; Highlight matching parentheses
(require 'paren)
(show-paren-mode 1)
(setq show-paren-delay 1)
(set-face-background 'show-paren-match (face-background 'default))
(if (eq (frame-parameter nil 'background-mode) 'dark)
    (set-face-foreground 'show-paren-match "red")
  (set-face-foreground 'show-paren-match "black"))
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)


;; Add ability to shift between buffers using shift+arrow keys.
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))


;; Paredit makes it easier to navigate/edit s-expressions as blocks.
(use-package paredit
  :ensure t
  :init
  (add-hook 'clojure-mode-hook 'enable-paredit-mode))

;; LSP-mode
(use-package clojure-mode)
(use-package lsp-mode)
;(use-package cider)
(use-package lsp-treemacs)
(use-package flycheck)
(use-package company)

(add-hook 'clojure-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojurec-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-minimum-prefix-length 1
      ; lsp-enable-indentation nil ; uncomment to use cider indentation instead of lsp
      ; lsp-enable-completion-at-point nil ; uncomment to use cider completion instead of lsp
      )

;; invoke one (ONLY one) of CIDER vs inf-clojure
(add-to-list 'load-path (concat user-emacs-directory "/clojure/"))
;; (require 'init-cider)
(require 'init-inf-clojure)


;; To add some colors to those boring parens
(use-package rainbow-delimiters
  :ensure t
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))


;; Adds some niceties/refactoring support
(use-package clj-refactor
  :ensure t
  :pin melpa-stable
  :config
  (add-hook 'clojure-mode-hook
            (lambda ()
              (clj-refactor-mode 1))))


;; Aggressively indents your clojure code
(use-package aggressive-indent
  :ensure t
  :commands (aggressive-indent-mode)
  :config
  (add-hook 'clojure-mode-hook 'aggressive-indent-mode))


;; Operate (list, search, replace....) on files at a project level.
(use-package projectile
  :ensure t
  :init
  (setq-default projectile-cache-file
                (expand-file-name ".projectile-cache" user-emacs-directory))
  (add-hook 'prog-mode-hook #'projectile-mode)

  :config
  (projectile-mode)
  (setq-default projectile-enable-caching t
                ;; Show project (if any) name in modeline
                projectile-mode-line '(:eval (projectile-project-name))))


;; Magit: The only git interface you'll ever need
(use-package magit :ensure t)


;; ----- Added by Shantanu this point onward -----

;; Enable column numbers
(setq column-number-mode t)

;; Enable whitespace mode
(setq whitespace-line-column 120)
(global-whitespace-mode 1)

(use-package crux
  :ensure t)
(require 'crux)
(global-set-key [remap move-beginning-of-line] #'crux-move-beginning-of-line)

;; Set Home and End key bindings
(global-set-key (kbd "<home>") 'move-beginning-of-line) ; was 'beginning-of-line
(global-set-key (kbd "<end>") 'end-of-line)

;; C-M-space should remove multiple whitespace lines into a single blank
;; character
(defun multi-line-just-one-space (&optional n)
  "Multi-line version of just-one-space: Delete all
  spaces, tabs and newlines around point,
  leaving one space (or N spaces)."
  (interactive "*p")
  (let ((orig-pos (point)))
    (skip-chars-backward " \t\n")
    (constrain-to-field nil orig-pos)
    (dotimes (i (or n 1))
      (if (= (following-char) ?\s)
    (forward-char 1)
  (insert ?\s)))
    (delete-region
     (point)
     (progn
       (skip-chars-forward " \t\n")
       (constrain-to-field nil orig-pos t)))))
(global-set-key (kbd "C-M-SPC") 'multi-line-just-one-space)

;; Keyboard shortcut <-/
;; Comment/uncomment toggle for marked/selected region
(global-set-key (kbd "M-/") 'comment-or-uncomment-region)

;; Strictly 2-space indentation
(setq-default indent-tabs-mode nil)
(setq clojure-defun-style-default-indent t)
(setq clojure-indent-style :always-indent)
(eval-after-load "clojure-mode"
   '(progn
      (define-clojure-indent
        (:require 0)
        (:import 0))))

;; markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; plant-uml
(use-package plantuml-mode)
;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
;; JAR mode
(setq  plantuml-jar-path "~/.emacs.d/plantuml.jar")
(unless (file-readable-p "~/.emacs.d/plantuml.jar")
  (plantuml-download-jar))
(setq plantuml-default-exec-mode 'jar)

;; vue.js
(use-package vue-mode
  :config
  (setq mmm-submode-decoration-level 2)
  (add-hook 'mmm-mode-hook
    (lambda ()
      (set-face-background 'mmm-default-submode-face "#fafafa"))))

;; treemacs
(use-package treemacs
  :ensure t)
(require 'treemacs)
(global-set-key [f4] 'treemacs)
(global-set-key [f5] 'treemacs-refresh)

;; neotree
(use-package neotree
  :ensure t)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(global-set-key [f9] 'neotree-refresh)

;; Kill window and buffer in one keystroke
(global-set-key (kbd "s-w") 'kill-buffer-and-window)

;; Delete selected text
(global-set-key [C-M-backspace] 'delete-region)

; Make emacs faster (tip by Stuart Sierra)
(setq font-lock-verbose nil)

;;; Modernization - http://xahlee.org/emacs/emacs_make_modern.html
;; Disable autosave
(setq make-backup-files nil) ; stop creating those backup~ files
(setq auto-save-default nil) ; stop creating those #autosave# files
;; Show recently opened files in a  menu
(recentf-mode 1)

;; Save and restore window layout
(desktop-save-mode 1)

;; buffer tabs
(use-package tabbar
  :ensure t)
(require 'tabbar)
(set-face-attribute
   'tabbar-default nil
    :background "gray60")
(set-face-attribute
   'tabbar-unselected nil
    :background "gray85"
     :foreground "gray30"
      :box nil)
(set-face-attribute
   'tabbar-selected nil
    :background "#f2f2f6"
     :foreground "black"
      :box nil)
(set-face-attribute
   'tabbar-button nil
    :box '(:line-width 1 :color "gray72" :style released-button))
(set-face-attribute
   'tabbar-separator nil
    :height 0.7)
(tabbar-mode 1)
;(tabbar-mode)
(global-set-key [(control shift tab)] 'tabbar-backward)
(global-set-key [(control tab)]       'tabbar-forward)

;; tabbar ruler
(use-package tabbar-ruler
  :ensure t)
(require 'tabbar-ruler)
(setq tabbar-ruler-global-tabbar 't) ; If you want tabbar
;(setq tabbar-ruler-global-ruler 't) ; if you want a global ruler
;(setq tabbar-ruler-popup-menu 't) ; If you want a popup menu.
;(setq tabbar-ruler-popup-toolbar 't) ; If you want a popup toolbar

;; ----- Added by Shantanu till this point -----


;; User customizations
(when (file-exists-p "~/.emacs.d/init-user.el")
  (setq user-custom-file "~/.emacs.d/init-user.el")
  (load user-custom-file))
