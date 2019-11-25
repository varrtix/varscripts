;;; custome.el --- Saving interface setting

;;; Commentary:

;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-c-headers-path-system
   (quote
    ("/usr/include/" "/usr/local/include/" "/Library/Developer/CommandLineTools/usr/include/c++/v1/")))
 '(evil-want-C-u-scroll t)
 '(package-selected-packages
   (quote
    (undo-tree swiper smartparens pkg-info ivy goto-chg epl dash counsel-etags counsel yasnippet company-c-headers irony-eldoc flycheck-irony irony company-irony flycheck flycheck-clang-analyzer modern-cpp-font-lock clang-format exec-path-from-shell srcery-theme which-key evil-nerd-commenter evil windresize sr-speedbar company)))
 '(scroll-bar-mode nil)
 '(sr-speedbar-skip-other-window-p t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)

(provide 'custome)
;;; custome.el ends here
