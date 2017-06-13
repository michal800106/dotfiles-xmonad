;;;; -*- mode: Emacs-Lisp;-*-

(setq default-directory "~/emacs-home/")
(make-directory default-directory t)
(setq vc-follow-symlinks t)

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "http://stable.melpa.org/packages/"))
      package-archive-priorities '(("melpa-stable" . 1)
                                   ("gnu" . 0)
                                   ("melpa" . 2)
                                   ("org" . 3)))

(package-initialize)
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(use-package evil
  :ensure t
  :config
  (define-key evil-normal-state-map " o" 'slime-selector)
  (define-key evil-insert-state-map (kbd "TAB") 'company-complete))

;;;;; SLIME SETUP {{{
(progn ;slime isn't loaded via use-package because quicklisp-helper keeps it uptodate
  (load (expand-file-name "~/quicklisp/slime-helper.el"))

  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "~/sbcl/bin/sbcl")

  (defun slime-ecl ()
    (interactive)
    (let ((inferior-lisp-program "ecl"))
      (slime)))

  (defun slime-cmucl ()
    (interactive)
    (let ((inferior-lisp-program "cmucl"))
      (slime)))

  (defun slime-sbcl ()
    (interactive)
    (let ((inferior-lisp-program "sbcl"))
      (slime)))

  (defun slime-ccl ()
    (interactive)
    (let ((inferior-lisp-program "ccl"))
      (slime)))

  (add-hook 'lisp-mode-hook
	    '(lambda ()
	       ;;(define-key evil-insert-state-map "^N" 'slime-fuzzy-indent-and-complete-symbol)
	       (unless (string= "*slime-scratch*" (buffer-name))
		 (paredit-mode)
		 (evil-paredit-mode)))) 
  (setq slime-contribs  '(slime-fancy slime-company slime-macrostep slime-trace-dialog slime-mdot-fu ))
  )

(use-package slime-company
  :no-require t
  :defer t
  :ensure t)

;;;;; }}}
(use-package company
  :ensure t
  :config
  ;; keybindings
  (progn (define-key company-active-map (kbd "C-c h") 'company-quickhelp-manual-begin)
	 (define-key company-active-map (kbd "SPC") (kbd "RET SPC"))
	 (define-key company-active-map (kbd "(") (kbd "RET SPC ("))
	 (define-key company-active-map (kbd "{") (kbd "RET SPC {"))
	 (define-key company-active-map (kbd "[") (kbd "RET [")))

  (message "backends: %s" company-backends)
  (setq company-backends '(company-clang company-bbdb company-nxml company-css
					 company-xcode company-cmake company-capf company-files
					 (company-dabbrev-code company-gtags company-etags
							       company-keywords) company-oddmuse
							       company-dabbrev))
  )

;; NOTE: this must be here...
(slime-setup)

(global-company-mode 1)

(use-package projectile
  :ensure t)

(use-package sbt-mode
  :ensure t
  :pin melpa-stable)

(use-package scala-mode
  :ensure t
  :pin melpa-stable)

(use-package ensime
  :ensure t)

(use-package intero
  :ensure t)

;; (use-package jdee
;;   :ensure t)

(use-package mvn
  :ensure t)

(use-package css-eldoc
  :ensure t)

(use-package ag
  :ensure t)

(use-package evil-vimish-fold
  :ensure t)

(use-package zenburn-theme
  :ensure t)

(use-package zeal-at-point
  :ensure t)

(use-package rainbow-delimiters
  :ensure t)

(use-package tabbar
  :ensure t)

(use-package helm
  :ensure t)

(use-package helm-projectile
  :ensure t)

(use-package evil-visual-mark-mode
  :ensure t)

(advice-add 'evil-delete-marks :after
	    (lambda (&rest args)
	      (evil-visual-mark-render)))

(use-package  evil-paredit
  :ensure t)

(use-package evil-numbers
  :ensure t)

(use-package eldoc-eval
  :ensure t)

(use-package editorconfig
  :ensure t)

(use-package csv-mode
  :ensure t)

(use-package color-theme
  :ensure t)

(use-package ansible
  :ensure t)

(use-package alect-themes
  :ensure t)

(use-package ac-js2
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package web-mode
  :ensure t)

(use-package vue-mode
  :ensure t)

(use-package typescript-mode
  :ensure t)

(use-package scss-mode
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package  markdown-mode
  :ensure t)

(use-package magit
  :ensure t)

(use-package highlight-parentheses
  :ensure t)

(use-package helm-projectile
  :ensure t)

(use-package helm-ls-git
  :ensure t)

					;(use-package helm-git
					;  :ensure t)

(use-package helm-css-scss
  :ensure t)

(use-package helm-cider
  :ensure t)

(use-package helm-ag-r
  :ensure t)

(use-package helm-ag
  :ensure t)

(use-package evil-surround
  :ensure t)

(use-package evil-nerd-commenter
  :ensure t
  :config
  (evilnc-default-hotkeys))

(use-package evil-leader
  :ensure t)

(use-package emmet-mode
  :ensure t)

(use-package project-explorer
  :ensure t
  )

(use-package ggtags
  :ensure t
  :config
  (ggtags-mode 1)
  (add-hook 'c-mode-common-hook
	    (lambda ()
	      (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
		(ggtags-mode 1)))))




(require 'helm-config)
(helm-mode)
(require 'js2-mode)
(require 'evil-numbers)
			       
			 
(require 'projectile)
(projectile-mode)

                         

(evil-mode)
(paredit-mode)
;; ;(js2-mode)
(evil-paredit-mode)
(rainbow-delimiters-mode)

(global-linum-mode)
(setq linum-format "%5d\u2502")

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)

(global-set-key (kbd "M-x") 'helm-M-x)
;(global-set-key (kbd ":") 'helm-M-x)

(define-key evil-normal-state-map " f" 'helm-projectile)
(define-key evil-normal-state-map " j" 'helm-buffers-list)

(define-key evil-normal-state-map "ZZ" 'save-buffer)

(defun paredit-wiggle-back ()
  (paredit-forward)
  (paredit-backward))

(defmacro defparedit-wrapper (name invoked-wrapper)
  `(defun ,name ()
     (interactive)
     (paredit-wiggle-back)
     (,invoked-wrapper)))

(defparedit-wrapper back-then-wrap paredit-wrap-sexp)
(defparedit-wrapper back-then-wrap-square paredit-wrap-square)
(defparedit-wrapper back-then-wrap-curly paredit-wrap-curly)
(defparedit-wrapper back-then-wrap-angled paredit-wrap-angled)
(defparedit-wrapper back-then-wrap-doublequote paredit-meta-doublequote)

(define-key evil-normal-state-map ",W" 'back-then-wrap)
(define-key evil-normal-state-map ",w]" 'back-then-wrap-square)
(define-key evil-normal-state-map ",w}" 'back-then-wrap-curly)
(define-key evil-normal-state-map ",w>" 'back-then-wrap-angled)
(define-key evil-normal-state-map ",w\"" 'back-then-wrap-doublequote)

(define-key evil-normal-state-map ",S" 'paredit-splice-sexp)
(define-key evil-normal-state-map ",A" 'paredit-splice-sexp-killing-backward)
(define-key evil-normal-state-map ",D" 'paredit-splice-sexp-killing-forward)
(define-key evil-normal-state-map ",|" 'paredit-split-sexp)
(define-key evil-normal-state-map ",J" 'paredit-join-sexps)
(define-key evil-normal-state-map ",<" 'paredit-backward-slurp-sexp)
(define-key evil-normal-state-map ",," 'paredit-backward-barf-sexp) 
(define-key evil-normal-state-map ",>" 'paredit-forward-slurp-sexp)
(define-key evil-normal-state-map ",." 'paredit-forward-barf-sexp) 
(define-key evil-normal-state-map ",~" 'paredit-convolute-sexp)

(define-key evil-normal-state-map ",zz" 'zeal-at-point)

(modify-syntax-entry ?_ "w" js-mode-syntax-table)
(modify-syntax-entry ?- "w" lisp-mode-syntax-table)
(modify-syntax-entry ?* "w" lisp-mode-syntax-table)
(modify-syntax-entry ?+ "w" lisp-mode-syntax-table)
(modify-syntax-entry ?! "w" lisp-mode-syntax-table)
(modify-syntax-entry ?$ "w" lisp-mode-syntax-table)
(modify-syntax-entry ?% "w" lisp-mode-syntax-table)
(modify-syntax-entry ?& "w" lisp-mode-syntax-table)
(modify-syntax-entry ?% "w" lisp-mode-syntax-table)
(modify-syntax-entry ?= "w" lisp-mode-syntax-table)
(modify-syntax-entry ?< "w" lisp-mode-syntax-table)
(modify-syntax-entry ?> "w" lisp-mode-syntax-table)
(modify-syntax-entry ?@ "w" lisp-mode-syntax-table)
(modify-syntax-entry ?[ "w" lisp-mode-syntax-table)
(modify-syntax-entry ?] "w" lisp-mode-syntax-table)
(modify-syntax-entry ?^ "w" lisp-mode-syntax-table)
(modify-syntax-entry ?_ "w" lisp-mode-syntax-table)
(modify-syntax-entry ?~ "w" lisp-mode-syntax-table)
(modify-syntax-entry ?{ "w" lisp-mode-syntax-table)
(modify-syntax-entry ?} "w" lisp-mode-syntax-table)
(modify-syntax-entry ?. "w" lisp-mode-syntax-table)

(modify-syntax-entry ?- "w" emacs-lisp-mode-syntax-table)
(modify-syntax-entry ?_ "w" emacs-lisp-mode-syntax-table)

(let ((default-directory  "~/.emacs.d/lisp/"))
  (make-directory default-directory t)
  (normal-top-level-add-subdirs-to-load-path))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight semi-bold :height 113 :width normal)))))

(setq erc-hide-list '("JOIN" "PART" "QUIT"))

;; (defun znc-erc ()
;;   (interactive)
;;   (erc-ssl :server "localhost" :port 6697 :nick "edwlan/freenode" :password "t31ch3rtb"))

(add-to-list 'auto-mode-alist '("\\.cljs\\.hl\\'" . clojurescript-mode))

(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (eldoc-mode)
	     (robe-mode)))


(add-hook 'clojure-mode-hook
	  '(lambda ()
	     ;; Hoplon functions and macros
	     (paredit-mode)
	     (define-key evil-insert-state-map "^N" 'helm-cider-apropos)
	     (dolist (pair '((page . 'defun)
			     (loop-tpl . 'defun)
			     (if-tpl . '1)
			     (for-tpl . '1)
			     (case-tpl . '1)
			     (cond-tpl . 'defun)))
	       (put-clojure-indent (car pair)
				   (car (last pair))))))

(setq jiralib-url "https://atomampd.atlassian.net:443")
(setq org-jira-working-dir "~/org-jira")
(setq org-agenda-files '("~/org-jira"))

(require 'evil-vimish-fold)
(evil-vimish-fold-mode 1)

(require 'editorconfig)
(editorconfig-mode 1)

(setq tls-program '("openssl s_client -connect %h:%p -no_ssl2 -ign_eof"))

(global-auto-revert-mode t)

 ;;; Use auto-complete for ensime

(defun scala/enable-eldoc ()
  "Show error message or type name at point by Eldoc."
  (setq-local eldoc-documentation-function
	      #'(lambda ()
		  (when (ensime-connected-p)
		    (let ((err (ensime-print-errors-at-point)))
		      (or (and err (not (string= err "")) err)
			  (ensime-print-type-at-point))))))
  (eldoc-mode +1))

(defun scala/completing-dot-company ()
  (cond (company-backend
	 (company-complete-selection)
	 (scala/completing-dot))
	(t
	 (insert ".")
	 (company-complete))))

(defun scala/completing-dot-ac ()
  (insert ".")
  (ac-trigger-key-command t))

;; Interactive commands

(defun scala/completing-dot ()
  "Insert a period and show company completions."
  (interactive "*")
  (eval-and-compile (require 'ensime))
  (eval-and-compile (require 's))
  (when (s-matches? (rx (+ (not space)))
		    (buffer-substring (line-beginning-position) (point)))
    (delete-horizontal-space t))
  (cond ((not (and (ensime-connected-p) ensime-completion-style))
	 (insert "."))
	((eq ensime-completion-style 'company)
	 (scala/completing-dot-company))
	((eq ensime-completion-style 'auto-complete)
	 (scala/completing-dot-ac))))

;; Initialization
(add-hook 'ensime-mode-hook #'scala/enable-eldoc)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'scala-mode-hook 'flycheck-mode)
(add-hook 'haskell-mode-hook 'intero-mode)

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
	      (global-semanticdb-minor-mode 1)
	      (global-semantic-idle-scheduler-mode 1)
	      (global-semantic-stickyfunc-mode 1)
	      
	      (semantic-mode 1)
	      
	      (helm-gtags-mode)
	      (ggtags-mode 1))))

(setq company-backends (delete 'company-semantic company-backends))

(defun alexott/cedet-hook ()
  (local-set-key "\C-c\C-j" 'semantic-ia-fast-jump)
  (local-set-key "\C-c\C-s" 'semantic-ia-show-summary))

(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'c-mode-hook 'alexott/cedet-hook)
(add-hook 'c++-mode-hook 'alexott/cedet-hook)

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.
 
 This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(set-exec-path-from-shell-PATH)

(require 'ede)
(global-ede-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "x-www-browser")
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("9d91458c4ad7c74cf946bd97ad085c0f6a40c370ac0a1cbeb2e3879f15b40553" "4e753673a37c71b07e3026be75dc6af3efbac5ce335f3707b7d6a110ecb636a3" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" default)))
 '(erc-modules
   (quote
    (autoaway autojoin button capab-identify completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring stamp spelling track)))
 '(erc-truncate-mode t)
 '(evil-leader/leader ",")
 '(evil-visual-mark-mode t)
 '(font-use-system-font t)
 '(global-evil-surround-mode t)
 '(global-linum-mode t)
 '(haskell-mode-hook
   (quote
    (capitalized-words-mode haskell-decl-scan-mode haskell-indentation-mode highlight-uses-mode imenu-add-menubar-index interactive-haskell-mode)))
 '(helm-ls-git-fuzzy-match t)
 '(jira-url "https://atomampd.atlassian.net/rpc/xmlrpc")
 '(line-number-mode nil)
 '(package-selected-packages
   (quote
    (aggressive-indent znc flymake-haskell-multi flx-ido less-css-mode css-eldoc npm-mode flycheck-haskell ag haskell-mode ember-mode geben-helm-projectile geben company-php company evil-vimish-fold graphviz-dot-mode muttrc-mode zenburn-theme tide zeal-at-point yaml-mode xml-rpc web-mode vue-mode vagrant typescript-mode twig-mode tramp-term tabbar slime scss-mode scion rvm rust-mode robe rhtml-mode rainbow-delimiters php-mode php-eldoc org-jira mingus markdown-mode magit jira highlight-parentheses helm-robe helm-projectile helm-ls-git helm-git helm-css-scss helm-cider helm-ag-r helm-ag haml-mode evil-visual-mark-mode evil-surround evil-rails evil-paredit evil-numbers evil-nerd-commenter evil-leader emmet-mode elein eldoc-eval editorconfig csv-mode color-theme-sanityinc-solarized color-theme ansible alect-themes ac-js2)))
 '(safe-local-variable-values
   (quote
    ((Package . CHUNGA)
     (Package . CL-USER)
     (Base . 10)
     (Package . FLEXI-STREAMS)
     (Syntax . COMMON-LISP))))
 '(slime-company-completion (quote fuzzy))
 '(znc-servers
   (quote
    (("localhost" 6697 t
      ((freenode "edwlan/freenode" "t31ch3rtb")
       (hhgs "edwlan/hhgs" "t31ch3rtb")
       (oftc "edwlan/oftc" "t31ch3rtb")))))))
