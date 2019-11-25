;;; init-extensions.el --- Function Extensions

;;; Commentary:

;;; Code:
;; Quick open init file
(defun vv/open-init-file ()
  "Opening init file..."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; Quick open packages init file
(defun vv/open-packages-init-file ()
  "Opening packages init file..."
  (interactive)
  (find-file "~/.emacs.d/elisp/init-packages.el"))

;; Quick open custome file
(defun vv/open-custome-file ()
  "Opening custome file..."
  (interactive)
  (find-file "~/.emacs.d/elisp/custome.el"))

;; Quick open extensions init file
(defun vv/open-extensions-init-file ()
  "Opening extensions init file..."
  (interactive)
  (find-file "~/.emacs.d/elisp/init-extensions.el"))

;; Quick open org init file
(defun vv/open-org-init-file ()
  "Opening org init file..."
  (interactive)
  (find-file "~/.emacs.d/elisp/init-org.el"))

;; Quick open keybindings init file
(defun vv/open-keybindings-init-file ()
  "Opening keybindings init file..."
  (interactive)
  (find-file "~/.emacs.d/elisp/init-keybindings.el"))

;; Quick open ui init file
(defun vv/open-ui-init-file ()
  "Opening ui init file..."
  (interactive)
  (find-file "~/.emacs.d/elisp/init-ui.el"))

;; Quick refresh init.el
(defun vv/refresh-init-file ()
  "Loading init file..."
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;; Close auto make backup files
(setq make-backup-files nil)
;; Close auto save e.g. ~ #
(setq auto-save-default nil)

;; Simplify checking notice
(fset 'yes-or-no-p 'y-or-n-p)

;; Abbr mode
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ;; Signature
					    ("vvs" "VARRTIX")
					    ))

;; Hippie-exp
(setq hippie-expand-try-functions-list '(try-expand-debbrev
					try-expand-debbrev-all-buffers
					try-expand-debbrev-from-kill
					try-complete-file-name-partially
					try-complete-file-name
					try-expand-all-abbrevs
					try-expand-list
					try-expand-line
					try-complete-lisp-symbol-partially
					try-complete-lisp-symbol))

;; Dired Mode
(put 'dired-find-alternate-file 'disabled nil)

;; CEDET Mode
(global-ede-mode 1)

(require 'cc-mode)
(require 'semantic)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(add-hook 'c-mode-hook 'semantic-idle-summary-mode)
;; (semantic-add-system-include "/usr/local/include" 'c-mode)
(semantic-add-system-include "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include" 'c-mode)
(semantic-add-system-include "/usr/local/opt/openssl@1.1/include" 'c-mode)
(semantic-add-system-include "/usr/local/opt/berkeley-db/include" 'c-mode)
;; (semantic-add-system-include "/usr/local/include" 'c++-mode)
(semantic-add-system-include "/Library/Developer/CommandLineTools/usr/include/c++/v1" 'c++-mode)
(semantic-add-system-include "/usr/local/opt/qt/include" 'c++-mode)
(semantic-mode 1)

;; ggtags + eldoc
(require 'ggtags)
(setq-local eldoc-documentation-function #'ggtags-eldoc-function)

;; Setup indentation
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))
;; (setq-default indent-tabs-mode nil)
;; (setq-default tab-width 4)
;; (add-hook 'prog-mode-hook
;; 	  (lambda ()
;; 	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;; 	      (setq-mode-local tab-width 4))
;; 	    (when (derived-mode-p 'ruby-mode)
;; 	      (setq-mode-local tab-width 2))))
(require 'gdb-mi)
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t
 gdb-show-main t
)

(provide 'init-extensions)
;;; init-extensions.el ends here
