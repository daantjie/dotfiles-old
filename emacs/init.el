					; My .emacs file. /daniel-oosthuizen

;; * Tasks
;; ** DONE Get relative line numbers
;;    CLOSED: [2016-02-05 Fri 21:50]
;; ** TODO Find how to undefine EVIL keymappings
;; ** TODO Figure out how to easily embed Org Mode in other code
;; * Code


;;; =============== Package ===============


(require 'package)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-livedown"))

(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)

(defun ensure-package-installed (&rest packages)
"Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
(mapcar
(lambda (package)
    (if (package-installed-p package)
	nil
    (if (y-or-n-p (format "Package %s is missing. Install it? " package))

	package)))
packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

;;; Installing packages
    ;; List of packages you wish to be installed:
(ensure-package-installed
                         ;; Essential
			    'evil
			    'helm
			    'ac-helm
			 ;; Workflow
                            'iedit
			    'magit
			    'undo-tree
			    'flymake
			 ;; Eyecandy
			    'color-theme
			    'badwolf-theme
			    'powerline
			    'nyan-mode
			    'linum-relative
			    'rainbow-delimiters
			    'fill-column-indicator
			 ;; Editing
			    'paredit
			    'multiple-cursors
			    'yasnippet
                            )


;;; ==================== Essentials ====================


;;; EVIL
;; Initialise
(require 'evil)
(evil-mode t)

;; Remap 'jl' to escape from insert mode
(defun my-jl ()
  (interactive)
  (let* ((initial-key ?j)
         (final-key ?l)
         (timeout 0.5)
         (event (read-event nil nil timeout)))
    (if event
        ;; timeout met
        (if (and (characterp event) (= event final-key))
            (evil-normal-state)
          (insert initial-key)
          (push event unread-command-events))
      ;; timeout exceeded
      (insert initial-key))))

(define-key evil-insert-state-map (kbd "j") 'my-jl)
(defadvice
    evil-search-forward
    (after evil-search-forward-recenter activate)
    (recenter))
(ad-activate 'evil-search-forward)

(defadvice
    evil-search-next
    (after evil-search-next-recenter activate)
    (recenter))
(ad-activate 'evil-search-next)

(defadvice
    evil-search-previous
    (after evil-search-previous-recenter activate)
    (recenter))
(ad-activate 'evil-search-previous)


;;; Helm
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

;; rebind tab to run persistent action
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;; make TAB works in terminal
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
;; list actions using C-z
(define-key helm-map (kbd "C-z")  'helm-select-action)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq
      ;; open helm buffer inside current window, not occupy whole other window
      helm-split-window-in-side-p           t
      ;; move to end or beginning of source when reaching top or bottom of source.
      helm-move-to-line-cycle-in-source     t
      ;; search for library in `require' and `declare-function' sexp.
      helm-ff-search-library-in-sexp        t
      ;; scroll 8 lines other window using M-<next>/M-<prior>
      helm-scroll-amount                    8
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

;; enable helm for M-x
(global-set-key (kbd "M-x") 'helm-M-x)
;; optional fuzzy matching for helm-M-x
(setq helm-M-x-fuzzy-match t)
;; enable helm for the kill ring
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C-x b") 'helm-mini)


;;; =============== Workflow ===============


(require 'undo-tree)
(global-undo-tree-mode)

(require 'magit)
(global-set-key (kbd "C-x G") 'magit-status)

(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)


;;; =============== Eyecandy ===============


;;(require 'color-theme)
;;(eval-after-load "color-theme"
;;  '(progn
;;     (color-theme-initialize)
;;     (color-theme-hober)))

;;(require 'powerline)
;;(require 'powerline-evil)
;;(powerline-default-theme)

(global-hl-line-mode)
(setq show-paren-delay 0)
(show-paren-mode 1)

(require 'rainbow-delimiters)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

(global-linum-mode t)
(require 'linum-relative)
(linum-relative-on)

(require 'nyan-mode)
(setq-default nyan-wavy-trail t)
(nyan-mode)
(nyan-start-animation)

(require 'badwolf-theme)

(require 'fill-column-indicator)
(setq fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "gray")
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

;;; ==================== Editing ====================


(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)


;;; ==================== Lisp ====================


(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)


;;; ==================== Markdown ====================


(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(require 'livedown)

;;; =============== Tex ===============


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(font-latex-bold-face ((t nil)))
 '(font-latex-doctex-documentation-face ((t nil)))
 '(font-latex-doctex-preprocessor-face ((t nil)))
 ;;'(font-latex-italic-face ((t nil)))
 '(font-latex-math-face ((t nil)))
 '(font-latex-sectioning-0-face ((t nil)))
 '(font-latex-sectioning-1-face ((t nil)))
 '(font-latex-sectioning-2-face ((t nil)))
 '(font-latex-sectioning-3-face ((t nil)))
 '(font-latex-sectioning-4-face ((t nil)))
 '(font-latex-sectioning-5-face ((t nil)))
 '(font-latex-sedate-face ((t nil)))
 '(font-latex-slide-title-face ((t nil)))
 '(font-latex-string-face ((t nil)))
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil)))
 '(font-latex-verbatim-face ((t nil)))
 '(font-latex-warning-face ((t nil))))


;;; =============== Org Mode ===============


(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/code/emacs/example.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;; Misc.


;; Disabling annoying things about Emacs
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(menu-bar-mode -1)
(tool-bar-mode -1)

(setq scroll-margin 1
    scroll-conservatively 0
    scroll-up-aggressively 0.01
    scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
    scroll-down-aggressively 0.01)

(setq inhibit-startup-screen t)

(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'erase-buffer 'disabled nil)

;;; =============== Deprecated ===============


;; change mode-line color by evil state
;;    (let ((default-color (cons (face-background 'mode-line)
;;					(face-foreground 'mode-line))))
;;	(add-hook 'post-command-hook
;;	(lambda ()
;;	    (let ((color (cond ((minibufferp) default-color)
;;			    ((evil-insert-state-p) '("#b58900" . "#ffffff"))
;;			    ((evil-visual-state-p) '("#d33682" . "#ffffff"))
;;			    ((evil-replace-state-p) '("#dc322f" . "#ffffff"))
;;			    ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
;;			    ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
;;			    (t default-color))))
;;	    (set-face-background 'mode-line (car color))
;;	    (set-face-foreground 'mode-line (cdr color))))))


;; (require 'vimish-fold)
;; (vimish-fold-global-mode)
;; (global-set-key (kbd "<C-return>") #'vimish-fold)
;; (global-set-key (kbd "<C-S-return>") #'vimish-fold-delete)
;; (define-key evil-normal-state-map (kbd "SPC") 'vimish-fold-toggle)
