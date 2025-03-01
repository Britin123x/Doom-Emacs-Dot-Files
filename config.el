;;; config.el --- -*- lexical-binding: t -*-

(setq user-full-name "Britin Hanna"
      user-mail-address "britin1@ksu.edu")



(setq doom-theme 'doom-one-light)

(setq display-line-numbers-type 'relative)

(setq org-directory "~/OneDrive/org/")

(setq org-roam-directory "~/OneDrive/org/notes")

(use-package! org-fragtog
:after org
:hook (org-mode . org-fragtog-mode) ; this auto-enables it when you enter an org-buffer, remove if you do not want this
:config
)

(after! org
  (plist-put org-format-latex-options
             :scale .5)

  (setq org-preview-latex-default-process 'dvisvgm))

(use-package! deft
  :config
  (setq deft-directory "~/OneDrive/org/notes"))

(setq +latex-viewers '(pdf-tools))

(after! dirvish
  (setq! dirvish-quick-access-entries
         `(("h" "~/"                          "Home")
           ("e" ,user-emacs-directory         "Emacs user directory")
           ("s" "~/Classwork/"                     "Schoolwork")
           ("c" "~/Codebase/"                     "Codebase")
           ("o" "~/OneDrive/org/"                       "Org-mode Files")
  (dirvish-override-dired-mode))))

(setq lsp-clients-clangd-args '("-j=3"
				"--background-index"
				"--clang-tidy"
				"--completion-style=detailed"
				"--header-insertion=never"
				"--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))
