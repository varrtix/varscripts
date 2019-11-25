;;; init-org.el --- Org Setting

;;; Commentary:

;;; Code:

;; Org-mode Activition && Configuration
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Highlight in orgmode
(require 'org-agenda)
(setq org-src-fontify-natively t)
;; Setting org Agenda file path
(setq org-agenda-files '("~/OneDrive/Mine/org"))


(provide 'init-org)
;;; init-org.el ends here
