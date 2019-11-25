;;; init-keybindings.el --- Keybindings Setting

;;; Commentary:

;;; Code:

;; Prefix Key-Bindings Setting
(global-set-key (kbd "<f2>") nil)
(global-set-key (kbd "<f5>") nil)

;; Key bindings customize initialize function
(global-set-key (kbd "<f5> C-i") 'vv/open-init-file)
(global-set-key (kbd "<f5> C-p") 'vv/open-packages-init-file)
(global-set-key (kbd "<f5> C-z") 'vv/open-custome-file)
(global-set-key (kbd "<f5> C-e") 'vv/open-extensions-init-file)
(global-set-key (kbd "<f5> C-o") 'vv/open-org-init-file)
(global-set-key (kbd "<f5> C-k") 'vv/open-keybindings-init-file)
(global-set-key (kbd "<f5> C-u") 'vv/open-ui-init-file)
(global-set-key (kbd "<f5> C-r") 'vv/refresh-init-file)
(require 'compile)
(global-set-key (kbd "<f5> <f5>") (lambda()
				    (interactive)
				    (setq-local compilation-read-command nil)
				    (call-interactively 'compile)))

;; Extension Key bindings
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "M-h") 'kill-region)
(global-set-key (kbd "<f5> C-f") 'toggle-frame-fullscreen)
(global-set-key (kbd "<f5> f") 'find-function)
(global-set-key (kbd "<f5> v") 'find-variable)
(global-set-key (kbd "<f5> k") 'find-function-on-key)
(global-set-key (kbd "<f5> p") 'customize-group)
(global-set-key (kbd "<RET>") 'newline-and-indent)
(global-set-key (kbd "C-c w") 'whitespace-mode)
(global-set-key (kbd "C-c q") 'kill-this-buffer)

(require 'company)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "C-h") nil)
  ;; (define-key c-mode-map (kbd "<tab>") 'company-complete)
  ;; (define-key c++-mode-map (kbd "<tab>") 'company-complete)
)

;; Helm Key bindings
(global-set-key (kbd "C-c s-p") 'helm-do-ag-project-root)

;; Setting org-agenda shortcut
(global-set-key (kbd "C-c s") 'org-store-link)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-switchb)

;; Sr-speedbar Setting
(global-set-key (kbd "C-x C-1") 'sr-speedbar-toggle)

;; windresize
(global-set-key (kbd "C-c m") 'windresize)
(when (fboundp 'winner-mode)
  (winner-mode)
  (windmove-default-keybindings))
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings)
  (global-set-key (kbd "C-c C-h") 'windmove-left)
  (global-set-key (kbd "C-c C-l") 'windmove-right)
  (global-set-key (kbd "C-c C-j") 'windmove-down)
  (global-set-key (kbd "C-c C-k") 'windmove-up))

;; Evil Mode Activation
(require 'evil)
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)
;; Evil nerd Commenter
(evilnc-default-hotkeys)
(define-key evil-normal-state-map (kbd "s-/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd "s-/") 'evilnc-comment-or-uncomment-lines)

;; ivy & counsel &swiper
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-c c") 'counsel-compile)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> r") 'ivy-resume)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "<f2> t") 'counsel-etags-find-tag-at-point)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; Clang-format
(load "/usr/local/opt/clang-format/share/clang/clang-format.el")
(add-hook 'prog-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c C-f") 'clang-format-region)
	    (local-set-key (kbd "C-c C-k") nil)
	    (local-set-key (kbd "C-c C-/") 'c-toggle-comment-style)
	    (local-set-key (kbd "C-c C-l") nil)
	    (local-set-key (kbd "C-c C-m") 'c-toggle-electric-state)))

;; (global-set-key (kbd "C-c C-f") 'clang-format-region)

;; Toml Mode Keybindings
(require 'conf-mode)
(define-key conf-toml-mode-map (kbd "C-c C-j") nil)

;; Hippie keybindings
(global-set-key (kbd "s-.") 'hippie-expand)

;; Dired Mode
(require 'dired)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "<RET>") 'dired-find-alternate-file))

;; ggtags Keybindings
(require 'ggtags)
(define-key ggtags-mode-map (kbd "C-c t s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c t h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c t r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c t f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c t c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c t u") 'ggtags-update-tags)
(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

;; helm Keybindings
(require 'helm)
(require 'helm-config)
;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(require 'helm-gtags)
(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

;; semantic keybindings
(global-set-key (kbd "<s-mouse-1>") 'semantic-ia-fast-mouse-jump)
(define-key prog-mode-map (kbd "C-c o") 'semantic-ia-fast-jump)

(provide 'init-keybindings)
;;; init-keybindings.el ends here
