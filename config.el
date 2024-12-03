;;; config.el --- -*- lexical-binding: t -*-

(setq user-full-name "Britin Hanna"
      user-mail-address "britin1@ksu.edu")

(setq doom-theme 'doom-ir-black)
(set-face-attribute 'default nil :height 160)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq display-line-numbers-type 'relative)

(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))

(setq org-directory "~/org/")

(setq org-roam-directory "~/org/notes")

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
  (setq deft-directory "~/org/notes"))

(setq +latex-viewers '(pdf-tools))

(after! dirvish
  (setq! dirvish-quick-access-entries
         `(("h" "~/"                          "Home")
           ("e" ,user-emacs-directory         "Emacs user directory")
           ("c" "~/Code/"                     "Code")
           ("d" "~/Downloads/"                "Downloads")
           ("o" "~/org/"                       "Org-mode Files")
           ("t" "~/.local/share/Trash/files/" "Trash")))
  (dirvish-override-dired-mode))

(setq lsp-clients-clangd-args '("-j=3"
				"--background-index"
				"--clang-tidy"
				"--completion-style=detailed"
				"--header-insertion=never"
				"--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

(after! realgud
(setq realgud-srcbuf-lock nil))

(setq mu4e-update-interval 60)
(after! mu4e
  (setq mu4e-get-mail-command "mbsync -a")
  (setq sendmail-program (executable-find "msmtp")
	send-mail-function #'smtpmail-send-it
	message-sendmail-f-is-evil t
	message-sendmail-extra-arguments '("--read-envelope-from")
	message-send-mail-function #'message-send-mail-with-sendmail))

(set-email-account! "ksu.edu"
  '((mu4e-sent-folder       . "/School/Sent Items")
    (mu4e-drafts-folder     . "/School/Drafts")
    (mu4e-trash-folder      . "/School/Deleted Items")
    (mu4e-refile-folder     . "/School/All Mail")
    (smtpmail-smtp-user     . "britin1@ksu.edu")
    (mu4e-compose-signature . "---\nBest, \nBritin Hanna\n Kansas State University - Electrical Engineering - Junior \n College of Engineering Student Senator \n KSU Department of Mathematics Office Worker \n (620) 212-9533"))
  t)

(use-package! eaf
  :load-path "~/.elisp/emacs-application-framework"
  :init
  :custom
  (eaf-browser-continue-where-left-off t)
  (eaf-browser-enable-adblocker t)
  (browse-url-browser-function 'eaf-open-browser) ;; Make EAF Browser my default browser
  :config
  (defalias 'browse-web #'eaf-open-browser)

  (require 'eaf-file-manager)
  (require 'eaf-music-player)
  (require 'eaf-image-viewer)
  (require 'eaf-camera)
  (require 'eaf-demo)
  (require 'eaf-airshare)
  (require 'eaf-terminal)
  (require 'eaf-markdown-previewer)
  (require 'eaf-video-player)
  (require 'eaf-vue-demo)
  (require 'eaf-file-sender)
  (require 'eaf-pdf-viewer)
  (require 'eaf-mindmap)
  (require 'eaf-netease-cloud-music)
  (require 'eaf-jupyter)
  (require 'eaf-org-previewer)
  (require 'eaf-system-monitor)
  (require 'eaf-rss-reader)
  (require 'eaf-file-browser)
  (require 'eaf-browser)
  (require 'eaf-org)
  (require 'eaf-mail)
  (require 'eaf-git)
  (when (display-graphic-p)
    (require 'eaf-all-the-icons))

  (require 'eaf-evil)
  (define-key key-translation-map (kbd "SPC")
    (lambda (prompt)
      (if (derived-mode-p 'eaf-mode)
          (pcase eaf--buffer-app-name
            ("browser" (if  (string= (eaf-call-sync "call_function" eaf--buffer-id "is_focus") "True")
                           (kbd "SPC")
                         (kbd eaf-evil-leader-key)))
            ("pdf-viewer" (kbd eaf-evil-leader-key))
            ("image-viewer" (kbd eaf-evil-leader-key))
            (_  (kbd "SPC")))
        (kbd "SPC")))))
