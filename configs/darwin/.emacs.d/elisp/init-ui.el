;;; init-ui.el --- UI Setting

;;; Commentary:
;; UI Module

;;; Code:
;; Turn off tool-bar-mode
(tool-bar-mode -1)

;; Turn off file scroll controller
(scroll-bar-mode -1)

;; Display line number
(global-linum-mode 1)

;; Modified cursor-type
;;(setq cursor-type 'bar)

;; Turn off init help screen
(setq inhibit-splash-screen 1)

;; Turn off indentation
;;(electric-indent-mode -1)

;; Modified display font size 15pt
(set-face-attribute 'default nil :height 150)

;; Delete selection mode
(delete-selection-mode)

 ;; Find Executable Path on MacOS
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Fullscreen at initialization
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; Highlight Matching Parenthesis
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(global-hl-line-mode)

;; load theme
(load-theme 'srcery t)

;; Smex Activation
;;(smex-initialize)
;;(global-set-key (kbd "M-x") 'smex)
;;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; old M-x before smex
;;(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(provide 'init-ui)
;;; init-ui.el ends here
