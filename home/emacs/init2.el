;;; init.el --- Chad's 2026 Hand-Rolled Config (Nix + Minad + Evil)

;; ==========================================
;; 1. PERFORMANCE & SANE DEFAULTS
;; ==========================================

(setq gc-cons-threshold (* 100 1024 1024) ; 100MB during init
      read-process-output-max (* 1024 1024)) ; 1MB for LSP performance

(setq use-short-answers t             ; y/n instead of yes/no
      native-comp-async-report-warnings-errors 'silent)

(pixel-scroll-precision-mode 1)       ; Smooth scrolling (standard in 2026)
(savehist-mode 1)                     ; Persist minibuffer history
(electric-pair-mode 1)                ; Built-in auto-pairing

;; UI cleanup
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; ==========================================
;; 2. THE FOUNDATION (EVIL & GENERAL)
;; ==========================================

(use-package evil
  :ensure nil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)     ; Required for evil-collection
  (setq evil-undo-system 'undo-redo)  ; Use the standard Emacs 29+ undo
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure nil
  :after evil
  :config
  (evil-collection-init))


(use-package general
  :ensure nil
  :demand t
  :config
  (general-evil-setup)
  
  ;; 1. Create the definer
  (general-create-definer my/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")

  ;; 2. Immediately use the definer to set your keys
  ;; Putting this here ensures my/leader-keys is DEFINED before it's CALLED.
  (my/leader-keys
    "SPC" '(consult-project-extra-find :which-key "find project file")
    ","   '(consult-buffer :which-key "switch buffer")
    "."   '(find-file :which-key "find file")

    ;; Files / Dired
    "f"  '(:ignore t :which-key "files")
    "ff" '(find-file :which-key "find file")
    "fs" '(save-buffer :which-key "save file")
    "fd" '(dirvish :which-key "open dired")

    ;; Search
    "s"  '(:ignore t :which-key "search")
    "sp" '(consult-ripgrep :which-key "search project")
    "ss" '(consult-line :which-key "search buffer")
    "sd" '(consult-dir :which-key "switch directory")

    ;; Git
    "g"  '(:ignore t :which-key "git")
    "gs" '(magit-status :which-key "status")
    "gb" '(magit-branch-checkout :which-key "switch branch")

    ;; LSP / Code
    "l"  '(:ignore t :which-key "lsp")
    "ls" '(consult-eglot-symbols :which-key "workspace symbols")
    "la" '(eglot-code-actions :which-key "code actions")
    "lr" '(eglot-rename :which-key "rename symbol")
    "lf" '(flymake-show-buffer-diagnostics :which-key "buffer diagnostics")

    ;; Navigation
    "j"  '(:ignore t :which-key "jump")
    "jj" '(avy-goto-char-timer :which-key "avy jump"))

  ;; 3. Enable the help menu (built-in to Emacs 30)
  (which-key-mode 1))


;; ==========================================
;; 3. COMPLETION STACK (THE MINAD SYSTEM)
;; ==========================================

;; Vertico: Vertical completion UI
(use-package vertico
  :ensure nil
  :config
  (vertico-mode 1))

;; Orderless: Better matching (Telescope style)
(use-package orderless
  :ensure nil
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Marginalia: Annotations in the minibuffer
(use-package marginalia
  :ensure nil
  :config
  (marginalia-mode 1))

;; Consult: The "Pickers"
(use-package consult
  :ensure nil
  :after general
  :config
  ;; Preview behavior
  (setq consult-preview-key 'any))

;; Embark: The "Actions"
(use-package embark
  :ensure nil
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :ensure nil
  :after (embark consult)
  :demand t)

;; ==========================================
;; 4. IN-BUFFER COMPLETION (CORFU & CAPE)
;; ==========================================

(use-package corfu
  :ensure nil
  :custom
  (corfu-auto t)
  (corfu-quit-no-match 'separator)
  :config
  (global-corfu-mode))

(use-package cape
  :ensure nil
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

;; UI Polish for Corfu
(use-package nerd-icons-corfu
  :ensure nil
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; ==========================================
;; 5. CODE INTELLIGENCE (LSP & TREESITTER)
;; ==========================================

;; Eglot is built-in; we just add the booster
(use-package eglot
  :ensure nil
  :config
  ;; Customizing for your Go/JS setup
  (add-to-list 'eglot-server-programs
               '((js-mode typescript-ts-mode) . ("rass" "typescript-language-server" "--stdio" "--" "vscode-eslint-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '((go-mode go-ts-mode) . ("rass" "gopls" "--" "golangci-lint-langserver"))))

(use-package eglot-booster
  :ensure nil
  :after eglot
  :config (eglot-booster-mode 1))

(use-package consult-eglot
  :ensure nil
  :after (consult eglot))

(use-package consult-eglot-embark
  :ensure nil
  :after (consult-eglot embark)
  :config (consult-eglot-embark-mode 1))

;; Tree-sitter automation
(use-package treesit-auto
  :ensure nil
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode))

;; Formatting (The modern way)
(use-package apheleia
  :ensure nil
  :config
  (apheleia-global-mode 1))

;; ==========================================
;; 6. FILE & ENVIRONMENT MANAGEMENT
;; ==========================================

;; Dirvish: Dired on steroids (The Oil.nvim killer)
(use-package dirvish
  :ensure nil
  :config
  (dirvish-override-dired-mode)
  (setq dirvish-attributes '(vc-face version-control icons collapse file-size)))

;; Envrc: Buffer-local Direnv
(use-package envrc
  :ensure nil
  :hook (after-init . envrc-global-mode))

;; ==========================================
;; 7. NAVIGATION & STRUCTURAL EDITING
;; ==========================================

(use-package avy
  :demand t
  :ensure nil)

(use-package puni
  :ensure nil
  :config
  (puni-global-mode 1))

;; ==========================================
;; 9. FINAL TOUCHES
;; ==========================================

(use-package magit
  :ensure nil)

;; Ensure vterm or other specialized shells use the inherited environment
(use-package inheritenv
  :demand t
  :ensure nil)

;; Set your theme (using a fast built-in as a placeholder)
(load-theme 'modus-vivendi t)
