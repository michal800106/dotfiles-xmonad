;;;; SLIME SETUP {{{
;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
(add-to-list 'load-path "~/git_repos/3dp/slime/")
(require 'slime)

(use-package slime-company
  :ensure t)

(global-set-key (kbd "C-c x") 'slime-export-symbol-at-point)

(when (and (boundp 'common-lisp-hyperspec-root)
           (string-prefix-p "/" common-lisp-hyperspec-root))
  (setq common-lisp-hyperspec-root
        (concat "file://" common-lisp-hyperspec-root)))

;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "~/sbcl/bin/sbcl") 

(defun setup-lisp-mode ()
  (comment
   (unless (string= "*slime-scratch*" (buffer-name))
     (paredit-mode)
     (evil-paredit-mode)))

  (unless (string= "*slime-scratch*" (buffer-name))
    (smartparens-strict-mode 1)
    (evil-smartparens-mode 1)
    (aggressive-indent-mode 1))

  (define-key evil-insert-state-map "^N" 'slime-fuzzy-indent-and-complete-symbol)
  (unless (string= "*slime-scratch*" (buffer-name))
    (paredit-mode)
    (evil-paredit-mode))
  (rainbow-delimiters-mode))

(add-hook 'lisp-mode-hook 'setup-lisp-mode) 
(add-hook 'emacs-lisp-mode-hook 'setup-lisp-mode) 


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
(modify-syntax-entry 91 "(" lisp-mode-syntax-table)
(modify-syntax-entry 93 ")" lisp-mode-syntax-table)
;;(modify-syntax-entry ?@ "w" lisp-mode-syntax-table)

(modify-syntax-entry ?^ "w" lisp-mode-syntax-table)
(modify-syntax-entry ?_ "w" lisp-mode-syntax-table)
(modify-syntax-entry ?~ "w" lisp-mode-syntax-table)
(modify-syntax-entry ?. "w" lisp-mode-syntax-table)

(setq shr-inhibit-images t
      shr-use-fonts nil)

(defun fwoar--clhs-lookup (&rest args)
  (let ((browse-url-browser-function 'eww-browse-url))
    (hyperspec-lookup (word-at-point))))

(pushnew (list ?h "Check hyperspec" #'fwoar--clhs-lookup)
         slime-selector-methods
         :key #'car)

(defun fwoar--slime-find-system ()
  (let ((systems (directory-files
                  (locate-dominating-file default-directory
                                          (lambda (n)
                                            (directory-files n nil "^[^.#][^#]*[.]asd$")))
                  t "^[^.#][^#]*[.]asd$")))
    (find-file (if (not (null (cdr systems)))
                   (helm-comp-read "system:" systems)
                 (car systems)))))

(pushnew (list ?S "Goto System" #'fwoar--slime-find-system)
         slime-selector-methods
         :key #'car)

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

(defun find-use-clause (current-form)
  (when current-form
    (destructuring-bind (discriminator . packages) current-form
      (case discriminator
        (:use (remove-if (op (or (eql :cl _)))
                         (cdr current-form)))
        (defpackage (find-use-clause
                     (find-if (lambda (f)
                                (and (listp f)
                                     (eql (car f) :use)))
                              '(defpackage :tracking-sim (:use :cl :alexandria :serapeum) (:export)))))))))

(defun load-package-uses ()
  (interactive)
  (slime-eval-async `(ql:quickload ',(find-use-clause (list-at-point)))))


(message (format "s-c-c is: %s" slime-company-completion))

(setq slime-contribs
      '(slime-fancy
        slime-company
        slime-macrostep
        slime-trace-dialog
        slime-mdot-fu))

(slime-setup)

 ;;;;; }}}