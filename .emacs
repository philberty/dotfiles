(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" "3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" "025354235e98db5e7fd9c1a74622ff53ad31b7bde537d290ff68d85665213d85" "6fe6ab4abe97a4f13533e47ae59fbba7f2919583f9162b440dd06707b01f7794" "fb4bf07618eab33c89d72ddc238d3c30918a501cf7f086f2edf8f4edba9bd59f" default)))
 '(inhibit-startup-screen t)
 '(initial-scratch-message ";; Happy Hacking")
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(defun system-is-mac ()
  (interactive)
  (string-equal system-type "darwin"))

(defun system-is-linux ()
  (interactive)
  (string-equal system-type "gnu/linux"))

(setq-default cursor-type 'hollow)
(set-cursor-color "red")
(cua-mode 1)

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

(global-visual-line-mode 1) ; 1 for on, 0 for off.

(when (eq system-type 'darwin)
  
  ;; Default Latin font (e.g. Consolas)
  (set-face-attribute 'default nil :family "Monaco")
  
  ;; default font size (point * 10)
  ;;
  ;; WARNING!  Depending on the default font,
  ;; if the size is not supported very well, the frame will be clipped
  ;; so that the beginning of the buffer may not be visible correctly. 
  (set-face-attribute 'default nil :height 125)
  )

; set command key to be meta instead of option
(if (system-is-mac)
   (setq ns-command-modifier 'meta))

;; emacs packages installed
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
;; + nyan-mode
;; + projectile
;; + neotree
;; + helm
;; + helm-projectile
;; + helm-spotify
;; + google-c-style

;; auto reload disk changes
(global-auto-revert-mode t)
;; turn on line wrap
(setq-default truncate-lines 1)

(require 'helm)
(require 'helm-projectile)
(require 'helm-spotify)
(global-set-key (kbd "M-x") 'helm-M-x)

(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)
(setq projectile-switch-project-action 'neotree-projectile-action)
(helm-projectile-on)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; python packages
;; $ sudo pip install jedi python-epc

(transient-mark-mode 1) ; highlight text selection
(delete-selection-mode 1) ; delete seleted text when typing

;; font lock, line and column numbers on modeline
(global-font-lock-mode 1)
(global-linum-mode 1)
(column-number-mode 1)

;; highlight parens expression
(show-paren-mode 1)
(setq show-paren-style 'expression)

;; stop creating those backup~ files
(setq make-backup-files nil) 

;; stop creating auto-save files #
(setq auto-save-default nil)

;; make electric-pair-mode work on more brackets
(electric-pair-mode 1)
(setq electric-pair-pairs '((?\" . ?\")
                            (?\{ . ?\})))

;; spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; tabbar ruler
(setq tabbar-ruler-global-tabbar t)
(require 'cl)
(require 'tabbar-ruler)

;; modeline
(require 'smart-mode-line)
(sml/setup)
(sml/apply-theme 'light)
(nyan-mode)
(nyan-start-animation)

;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/monokai-theme-20150521.2257/")
(load-theme 'monokai)

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4")
(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20140824.1658/dict/")
;; (setq-default ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
(add-hook 'css-mode-hook 'ac-css-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'objc-mode)

;; python jedi
(add-to-list 'load-path "~/.emacs.d/elpa/jedi-0.1.2")
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; My shortcut for "go to line"
(global-set-key (kbd "C-x g") 'goto-line)

;; Load python-mode for scons files
(setq auto-mode-alist (cons '("SConstruct" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("SConscript" . python-mode) auto-mode-alist))

;; c/c++ mode style
(setq-default c-basic-offset 4 c-default-style "linux")
(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
)
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; web-mode on html files
(setq auto-mode-alist (append ' (("\\.html?\\'" . web-mode)) auto-mode-alist))

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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(defun how-many-region (begin end regexp &optional interactive)
  "Print number of non-trivial matches for REGEXP in region.                    
Non-interactive arguments are Begin End Regexp"
  (interactive "r\nsHow many matches for (regexp): \np")
  (let ((count 0) opoint)
    (save-excursion
      (setq end (or end (point-max)))
      (goto-char (or begin (point)))
      (while (and (< (setq opoint (point)) end)
                  (re-search-forward regexp end t))
        (if (= opoint (point))
            (forward-char 1)
          (setq count (1+ count))))
      (if interactive (message "%d occurrences" count))
      count)))

(defun infer-indentation-style ()
  ;; if our source file uses tabs, we use tabs, if spaces spaces, and if        
  ;; neither, we use the current indent-tabs-mode                               
  (let ((space-count (how-many-region (point-min) (point-max) "^  "))
        (tab-count (how-many-region (point-min) (point-max) "^\t")))
    (if (> space-count tab-count) (setq indent-tabs-mode nil))
    (if (> tab-count space-count) (setq indent-tabs-mode t))))

(setq indent-tabs-mode nil)
(infer-indentation-style)
