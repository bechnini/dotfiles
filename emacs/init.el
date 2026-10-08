(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
	("org" . "https://orgmode.org/elpa/")	
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if missing
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


(use-package ivy
  :diminish
  :config
  (ivy-mode 1))
(setq ivy-initial-inputs-alist nil)
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


(use-package org
  :config
  (setq org-startup-indented t
        org-hide-leading-stars t
        org-startup-folded 'content
        org-log-done 'time
	org-startup-with-inline-images t
	org-support-shift-select 1))

(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿")))

(use-package elcord)
(elcord-mode)


(desktop-save-mode 1)
(setq desktop-path '("~/Desktop/"))
(setq desktop-save t)

(use-package evil)
(evil-mode 1)
(define-key evil-insert-state-map "jj" 'evil-normal-state)
(define-key evil-normal-state-map ";" 'evil-forward-char)    
(define-key evil-normal-state-map "l" 'evil-previous-line)    
(define-key evil-normal-state-map "k" 'evil-next-line)        
(define-key evil-normal-state-map "j" 'evil-backward-char)    
(define-key evil-normal-state-map "h" 'evil-repeat-find-char)
(define-key evil-visual-state-map ";" 'evil-forward-char)
(define-key evil-visual-state-map "l" 'evil-previous-line)
(define-key evil-visual-state-map "k" 'evil-next-line)
(define-key evil-visual-state-map "j" 'evil-backward-char)

(global-visual-line-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

  (use-package sublime-themes
  :ensure t
  :config
  (load-theme 'spolsky t))

(setq global-display-line-numbers-exclude-modes
       '(shell-mode
        vterm-mode))

(add-hook 'display-line-numbers-mode-hook
	  (lambda ()
            (when (derived-mode-p 'shell-mode )
             (display-line-numbers-mode -1))))
(use-package all-the-icons)
(use-package all-the-icons-ivy-rich)
(all-the-icons-ivy-rich-mode 1)

(use-package doom-modeline
  :after all-the-icons
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 20)
  (doom-modeline-modal nil)) 

(use-package windmove
  :ensure nil
  :config
  (windmove-default-keybindings))
