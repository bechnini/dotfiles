;; ---------------------------------
;; Package Setup
;; ---------------------------------
(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if missing
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


;; ---------------------------------
;; Ivy + Counsel + Swiper
;; ---------------------------------
(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package counsel
  :after ivy
  :config
  (counsel-mode 1))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x b" . ivy-switch-buffer)))

(use-package ivy-rich
  :after ivy
  :config
  (ivy-rich-mode 1))


;; ---------------------------------
;; Org Mode
;; ---------------------------------
(use-package org
  :config
  (setq org-startup-indented t
        org-hide-leading-stars t
        org-startup-folded 'content
        org-log-done 'time
	org-support-shift-select 1))
;; Enable org-superstar for prettier bullets
(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿")))


(require 'deft)
(setq deft-directory "~/Documents/orgfiles/")
(setq deft-extension '("org"))
(setq deft-text-mode 'org-mode)
(global-set-key [] 'deft)


;; ---------------------------------
;; UI Tweaks
;; ---------------------------------
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode 1)

(use-package doom-themes
  :config
  ;; Use your preferred Doom theme (Soplsky for example)
  ;; NOTE: you need to have doom-themes installed for this.)

  (use-package sublime-themes)
  :ensure t
  :config
  (load-theme 'spolsky t))


;; ---------------------------------
;; Doom Modeline + Icons + evil mode
;; ---------------------------------
(use-package all-the-icons
  :if (display-graphic-p)) ;; only load in GUI
(use-package all-the-icons-ivy-rich)
(all-the-icons-ivy-rich-mode 1)


(use-package doom-modeline
  :after all-the-icons
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 25))


;; ---------------------------------
;; Window Navigation
;; ---------------------------------
(use-package windmove
  :ensure nil
  :config
  (windmove-default-keybindings))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("c48551a5fb7b9fc019bf3f61ebf14cf7c9cdca79bcb2a4219195371c02268f11"
     default))
 '(package-selected-packages
   '(all-the-icons-ivy-rich counsel deft doom-modeline doom-themes evil
			    magit org-superstar sublime-themes
			    zzz-to-char)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
