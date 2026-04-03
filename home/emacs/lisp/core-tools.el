(use-package magit
  :config
  (require 'magit-extras)

  :general
  (cxn/leader-def
    "g"   (cons "git" (make-sparse-keymap))
    "gs"    '("status"       . magit-status)
    "gb"    '("blame"        . magit-blame)
    "gd"    '("diff"         . magit-diff)
    "g+"    '("stage file"   . magit-stage-file)
    "g-"    '("unstage file" . magit-unstage-file)))

(use-package dirvish
  :ensure nil
  :config
  (dirvish-override-dired-mode)
  (setq dirvish-attributes '(vc-face version-control icons collapse file-size)))

(use-package vterm
  :config
  (with-eval-after-load 'evil
    (evil-set-initial-state 'vterm-mode 'emacs)))

(use-package inheritenv
  :demand t
  :ensure nil)

(use-package envrc
  :ensure nil
  :hook (after-init . envrc-global-mode))

(provide 'core-tools)
