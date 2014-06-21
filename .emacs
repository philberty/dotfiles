(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a"
			      "3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723"
			      "025354235e98db5e7fd9c1a74622ff53ad31b7bde537d290ff68d85665213d85"
			      "6fe6ab4abe97a4f13533e47ae59fbba7f2919583f9162b440dd06707b01f7794"
			      "fb4bf07618eab33c89d72ddc238d3c30918a501cf7f086f2edf8f4edba9bd59f" default)))
 '(inhibit-startup-screen t)
 '(initial-scratch-message ";; Happy Hacking")
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;; packages installed
;; + jedi
;; + rust-mode
;; + go-mode
;; + web-mode
;; + zenburn-theme
;; + markdown-mode
;; + tabbar
;; + tabbar-ruler
;; + groovy-mode
;; + rainbow-mode
;; + smart-mode-line

(transient-mark-mode 1) ; highlight text selection
(delete-selection-mode 1) ; delete seleted text when typing

(global-font-lock-mode 1)
(global-linum-mode 1)
(column-number-mode 1)

(setq show-paren-style 'expression)
(setq make-backup-files nil) ; stop creating those backup~ files
(setq auto-save-default nil) ; stop creating those #autosave# files

;; make electric-pair-mode work on more brackets
(electric-pair-mode 1)
(setq electric-pair-pairs '((?\" . ?\")
                            (?\{ . ?\})))

;; tabbar
(setq tabbar-ruler-global-tabbar t) ; If you want tabbar
(require 'cl)
(require 'tabbar-ruler)

;; modeline
(require 'smart-mode-line)
(sml/setup)
(sml/apply-theme 'light)

;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/zenburn-theme-20140613.207/")
(load-theme 'zenburn)

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4")
(require 'auto-complete-config)
(ac-config-default)

;; python jedi
(add-to-list 'load-path "~/.emacs.d/elpa/jedi-0.1.2")
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; My shortcut for "go to line"
(global-set-key (kbd "C-x g") 'goto-line)

;; Load python-mode for scons files
(setq auto-mode-alist (cons '("SConstruct" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("SConscript" . python-mode) auto-mode-alist))

;; Mardown mode on .md files
(setq auto-mode-alist (append '(("\\.md\\'" . markdown-mode)) auto-mode-alist))

;; Markdown hook to auto-save more
(add-hook 'markdown-mode-hook
	  (lambda ()
	    (when buffer-file-name
	      (add-hook 'after-save-hook
			'check-parens
			nil t))))

;; high light current line
(global-hl-line-mode 1)
;; (set-face-background 'hl-line "#330")

;; Allow hash to be entered
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;;; Unbind the stupid minimize that I always hit.
(global-unset-key "\C-z")

;; bell can go fuck
(setq ring-bell-function 'ignore)

;; line number mode
(global-linum-mode 1)
(eval-after-load 'linum
  '(progn
     (defface linum-leading-zero
       `((t :inherit 'linum
            :foreground ,(face-attribute 'linum :background nil t)))
       "Face for displaying leading zeroes for line numbers in display margin."
       :group 'linum)

     (defun linum-format-func (line)
       (let ((w (length
                 (number-to-string (count-lines (point-min) (point-max))))))
         (concat
          (propertize (make-string (- w (length (number-to-string line))) ?0)
                      'face 'linum-leading-zero)
          (propertize (number-to-string line) 'face 'linum))))
     
     (setq linum-format 'linum-format-func)))
(setq linum-format "%3d \u2502")

