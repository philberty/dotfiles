(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("fb4bf07618eab33c89d72ddc238d3c30918a501cf7f086f2edf8f4edba9bd59f" default)))
 '(inhibit-startup-screen t)
 '(initial-scratch-message ";; Happy Hacking")
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(menu-bar-mode nil))

(require 'package)
(add-to-list 'package-archives 
	     '("marmalade" .
	       "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("elpy" .
	       "http://jorgenschaefer.github.io/packages/"))
(package-initialize)

;; pip packages
;; sudo pip install epc jedi elpy rope

;; installed packages
;; elpy
;; jedi
;; rust-mode
;; go-mode
;; handlebars-mode
;; monokai-theme

(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/monokai-theme-0.0.11/")
(load-theme 'monokai)

(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4")
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'load-path "~/.emacs.d/elpa/jedi-0.1.2")
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; My shortcut for "go to line"
(global-set-key (kbd "C-x g") 'goto-line)

;; Load python-mode for scons files
(setq auto-mode-alist (cons '("SConstruct" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("SConscript" . python-mode) auto-mode-alist))

(global-hl-line-mode 1)
(set-face-background 'hl-line "#330")

;; Allow hash to be entered
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;;; Unbind the stupid minimize that I always hit.
(global-unset-key "\C-z")
(setq ring-bell-function 'ignore)

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
(elpy-enable)
