;;; init-packages.el --- Packages Setting

;;; Commentary:
;; Packages Module

;;; Code:
;; It might already have this line to order install packages correctly.
(require 'package)

(package-initialize)
(setq package-archives '(("gnu-cn" . "https://elpa.emacs-china.org/gnu/")
			 ("melpa-cn" . "https://elpa.emacs-china.org/melpa/")
			 ("org-cn" . "https://elpa.emacs-china.org/org/")))
;;	     '("gnu" . "https://elpa.gnu.org/packages/")
;;	     '("melpa" . "https://melpa.org/packages/")
;;	     '("org" . "https://orgmode.org/elpa/")

;; Common Lisp Extensions
(with-no-warnings (require 'cl))
(defvar own/packages '(
		;; --- Auto-completion ---
		company
		company-c-headers
		yasnippet
		yasnippet-snippets
		;; --- Better Editor ---
		evil
		evil-nerd-commenter
		which-key
		counsel
		;; counsel-etags
		ivy
		swiper
		;; clang-format
		modern-cpp-font-lock
		flycheck
		flycheck-clang-analyzer
		;; --- Major Mode ---
		sr-speedbar
		windresize
		;; --- Minor Mode ---
		exec-path-from-shell
		;; --- Themes ---
		srcery-theme
		;; --- File management ---
		helm
		helm-ag
		ggtags
		helm-gtags
		) "Default packages.")

(setq package-selected-packages own/packages)

(defun own/packages-installed-p ()
  "Installing packages."
     (loop for pkg in own/packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))

(unless (own/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg own/packages)
       (when (not (package-installed-p pkg))
	 (package-install pkg))))

(require 'company)
(require 'cc-mode)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends (delete 'company-semantic company-backends))
(add-to-list 'company-backends 'company-c-headers)
;; (defvar company-etags-modes '(prog-mode c-mode objc-mode c++-mode java-mode
					;; jde-mode pascal-mode perl-mode python-mode
					;; ruby-mode lisp-mode elisp-mode))

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
;; (setq-default flycheck-c/c++-clang-executable "/usr/bin/clang")
;; (setq-default flycheck-clang-standard-library "libc++")
;; (setq-default flycheck-clang-language-standard "c++11")
;; (setq-default flycheck-cppcheck-standards "c++11")

;; (with-eval-after-load 'flycheck
;;   (require 'flycheck-clang-analyzer)
;;   (flycheck-clang-analyzer-setup)
;;   (setq-default flycheck-clang-analyzer-executable "/usr/bin/clang"))

(require 'evil)
(evil-mode 1)

(require' which-key)
(which-key-mode 1)
;; Recommended default setting
(which-key-setup-minibuffer)

;; ivy & counsel & swiper
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq search-default-mode #'char-fold-to-regexp)


(add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)

;; set env for clang
(setenv "LD_LIBRARY_PATH" "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib")

(require 'yasnippet)
(yas-global-mode 1)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;; ctags
(setq-default tags-table-list nil)

;; helm config
(require 'helm)
(require 'helm-config)
(require 'helm-net)
(require 'helm-files)
(when (executable-find "curl")
  (setq helm-net-prefer-curl t))
(setq helm-split-window-inside-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source    t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp       t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                   8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun own/helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'own/helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)
(helm-mode 1)

;; ggtags
(require 'ggtags)
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
	      (ggtags-mode 1))))
(require 'helm-gtags)
(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t)

;; ;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)
(setq-local imenu-create-index-function #'ggtags-build-imenu-index)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(exec-path-from-shell-copy-env "GTAGSLIBPATH")
(exec-path-from-shell-copy-env "MANPATH")

(provide 'init-packages)
;;; init-packages.el ends here
