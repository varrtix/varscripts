;;; init.el --- The main entrance for emacs initialization

;;; Commentary:

;;; Code:
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/elisp/")

(require 'init-packages)
;; (require 'custome)
(require 'init-extensions)
(require 'init-org)
(require 'init-keybindings)
(require 'init-ui)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-c-headers-path-system
   (quote
    ("/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/" "/usr/local/include/" "/Library/Developer/CommandLineTools/usr/include/c++/v1/" "/usr/local/opt/openssl@1.1/include/" "/usr/local/opt/qt/include" "/usr/local/opt/berkeley-db/include")))
 '(evil-want-C-u-scroll t)
 '(package-selected-packages
   (quote
    (helm-gtags ggtags async helm helm-core popup helm-ag yasnippet-snippets undo-tree swiper pkg-info ivy goto-chg epl dash counsel-etags counsel company-c-headers irony-eldoc flycheck-irony irony company-irony flycheck flycheck-clang-analyzer modern-cpp-font-lock exec-path-from-shell srcery-theme which-key evil-nerd-commenter evil windresize sr-speedbar company)))
 '(scroll-bar-mode nil)
 '(sr-speedbar-skip-other-window-p t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
