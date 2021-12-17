;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-font (font-spec :family "JetBrains Mono Medium" :size 20)
      doom-big-font (font-spec :family "JetBrains Mono Medium" :size 22)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 20))
(setq doom-theme 'doom-city-lights)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq confirm-kill-emacs nil)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(use-package! lsp-ui
			  :commands lsp-ui-mode
			  :config 
	(setq display-line-numbers-type t
		  lsp-enable-symbol-highlighting t
		  lsp-ui-doc-enable t
		lsp-ui-doc-show-with-mouse t
		lsp-lens-enable nil
		lsp-ui-sideline-show-code-actions t
		lsp-ui-sideline-show-hover t
		lsp-eldoc-enable-hover nil 
	lsp-ui-doc-background (doom-color 'blue)
   lsp-ui-doc-border (doom-color 'red)
		lsp-completion-show-detail nil
lsp-ui-doc-header nil
lsp-ui-doc-include-signature nil 
lsp-ui-peek-enable t
lsp-ui-peek-always-show t
lsp-ui-flycheck-enable t))


(custom-set-faces
   ;;'(ccls-sem-global-variable-face ((t (:underline t :weight extra-bold))))
   ;;'(lsp-face-highlight-read ((t (:background "sea green"))))
   ;;'(lsp-face-highlight-write ((t (:background "yellow"))))
   ;; '(lsp-ui-peek-peek ((t (:background "sea green"))))
   ;; '(lsp-ui-peek-list ((t (:background "deep sky blue"))))
   ;;'(lsp-ui-peek-highlight ((t (:background "deep sky blue"))))
   ;;'(lsp-ui-sideline-current-symbol ((t (:foreground "yellow" :box nil))))
   '(lsp-ui-sideline-symbol-info ((t (:foreground "white" :box nil)))))

   ;;'(lsp-ui-sideline-symbol ((t (:foreground "red" :box nil)))))

;;(defface lsp-ui-sideline-code-action
;;  '((((background light)) :foreground "DarkOrange")
;;    (t :foreground "yellow"))
;;  "Face used to highlight code action text."
;;  :group 'lsp-ui-sideline)
				

 

;;(setq display-line-numbers-type t)
;;(setq lsp-enable-symbol-highlighting t)
;;(setq lsp-ui-doc-enable t)
;;(setq lsp-ui-doc-show-with-mouse t)
;;(setq lsp-lens-enable nil)
;;(setq lsp-ui-sideline-show-code-actions t)
;;(setq lsp-ui-sideline-show-hover t)
;;(setq lsp-eldoc-enable-hover t)
;;(setq lsp-completion-show-detail nil)
;;(setq lsp-completion-show-detail nil))

;;(set-eglot-client! 'cc-mode '("clangd" "-j=3" "--clang-tidy"))


(use-package! company-lsp
  :after lsp-mode
  :config
  (setq company-transformers nil company-lsp-cache-candidates nil)
  (set-company-backend! 'lsp-mode 'company-lsp)
  )


(after! cc-mode
  (set-company-backend! 'c++-mode 'lsp-mode 'company-lsp
						))
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(after! flycheck
  (require 'flycheck-google-cpplint)
  (setq flycheck-c/c++-googlelint-executable "cpplint"
        flycheck-c/c++-cppcheck-executable "cppcheck"
        flycheck-python-pylint-executable "pylint"
        flycheck-r-lintr-executable "R"
        flycheck-pylintrc "~/.pylintrc"
        flycheck-cppcheck-standards '("c++17"))
  (flycheck-add-next-checker 'c/c++-cppcheck '(warning . c/c++-googlelint)))

(setq lsp-clients-clangd-args
          '("-j=2"
            "--background-index"
            "--clang-tidy"
            "--completion-style=bundled"
            "--pch-storage=memory"
            "--header-insertion=never"
            "--header-insertion-decorators=0"))

(add-hook! 'lsp-after-initialize-hook
  (run-hooks (intern (format "%s-lsp-hook" major-mode))))

(defun my-c++-linter-setup ()
  (flycheck-add-next-checker 'lsp 'c/c++-googlelint))
(add-hook 'c++-mode-lsp-hook #'my-c++-linter-setup)

(defun my-python-linter-setup ()
  (flycheck-add-next-checker 'lsp 'python-pylint))
(add-hook 'python-mode-lsp-hook #'my-python-linter-setup)

(defun my-r-linter-setup ()
   (flycheck-add-next-checker 'lsp 'r-lintr))
(add-hook 'R-mode-lsp-hook #'my-r-linter-setup)

;; (use-package! flycheck-clang-analyzer
;;   :init
;;   (require 'flycheck-clang-analyzer)
;;   (flycheck-clang-analyzer-setup))


(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-auto-guess-root t lsp-eldoc-prefer-signature-help nil)
  (setq lsp-enable-links nil)
  (setq lsp-prefer-flymake nil)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-keep-workspace-alive nil)
  (add-to-list 'lsp-file-watch-ignored "build")
  ;; (setq lsp-project-blacklist '("/CC/"))
  )

  (set-formatter! 'c++-mode 'clang-format)

(setq compile-command "clang++ -std=c++20")
