(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-etags-requires 1)
 '(custom-safe-themes
   (quote
    ("8b58ef2d23b6d164988a607ee153fd2fa35ee33efc394281b1028c2797ddeebb" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" "3629b62a41f2e5f84006ff14a2247e679745896b5eaa1d5bcfbc904a3441b0cd" "f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c" "ace9f12e0c00f983068910d9025eefeb5ea7a711e774ee8bb2af5f7376018ad2" "1fc1fdf975c8c8c3767c29787a063eee50cbceef903644a0771fa66568ee8777" "c567c85efdb584afa78a1e45a6ca475f5b55f642dfcd6277050043a568d1ac6f" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "6df30cfb75df80e5808ac1557d5cc728746c8dbc9bc726de35b15180fa6e0ad9" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" "3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" "025354235e98db5e7fd9c1a74622ff53ad31b7bde537d290ff68d85665213d85" "6fe6ab4abe97a4f13533e47ae59fbba7f2919583f9162b440dd06707b01f7794" "fb4bf07618eab33c89d72ddc238d3c30918a501cf7f086f2edf8f4edba9bd59f" default)))
 '(inhibit-startup-screen t)
 '(initial-scratch-message ";; Happy Hacking")
 '(package-selected-packages
   (quote
    (rustic clang-format fic-mode yaml-mode godoctor golint protobuf-mode go-snippets go-imports go-fill-struct flycheck-golangci-lint yasnippet go-complete fill-column-indicator flycheck monokai-theme smooth-scrolling helm-gtags helm-projectile helm neotree projectile nyan-mode tabbar-ruler tabbar ac-c-headers ac-etags smart-mode-line-powerline-theme smart-mode-line stickyfunc-enhance google-c-style ggtags llvm-mode cython-mode markdown-mode web-mode go-mode rust-mode jedi)))
 '(tool-bar-mode nil))

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(setq package-list '(jedi
		     rust-mode
		     go-mode
		     web-mode
		     markdown-mode
		     cython-mode
		     ggtags
		     google-c-style
		     stickyfunc-enhance
		     smart-mode-line
                     smart-mode-line-powerline-theme
                     auto-complete
                     ac-etags
		     ac-c-headers
		     tabbar
		     tabbar-ruler
		     nyan-mode
		     projectile
                     neotree
		     helm
		     helm-projectile
		     helm-gtags
		     smooth-scrolling
                     monokai-theme
		     fill-column-indicator
                     flycheck
                     flymake
                     go-mode
                     exec-path-from-shell
                     auto-complete
                     go-autocomplete
                     go-complete
                     flymake-go
                     golint
                     neotree
                     atom-one-dark-theme
                     go-guru
                     clang-format
                     lsp-mode
                     lsp-ui
                     company))


;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(global-visual-line-mode 1) ; 1 for on, 0 for off.
(require 'fill-column-indicator)
(setq fci-rule-width 1)
(setq fci-rule-location 80)
(setq fci-rule-color "darkblue")
(fci-mode)

;; auto reload disk changes
(global-auto-revert-mode t)
;; turn on line wrap
(setq-default truncate-lines 1)

(require 'smooth-scrolling)
(setq smooth-scroll-margin 5)

;; font lock, line and column numbers on modeline
(global-font-lock-mode 1)
(global-linum-mode 1)
(column-number-mode 1)

(require 'helm)
(require 'helm-projectile)
(global-set-key (kbd "M-x") 'helm-M-x)
(require 'helm-gtags)

(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)
(setq projectile-switch-project-action 'neotree-projectile-action)
(helm-projectile-on)

(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(semantic-mode 1)
(require 'stickyfunc-enhance)

(require 'neotree)
(with-eval-after-load 'neotree
  (add-hook 'neotree-mode-hook 
            (lambda () (with-current-buffer " *NeoTree*"
                         (setq-local linum-mode nil)))))
(setq neo-theme 'ascii)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(neo-banner-face ((t :inherit shadow)))
 '(neo-button-face ((t :inherit dired-directory)))
 '(neo-dir-link-face ((t :inherit dired-directory)))
 '(neo-expand-btn-face ((t :inherit button)))
 '(neo-file-link-face ((t :inherit default)))
 '(neo-header-face ((t :inherit shadow)))
 '(neo-root-dir-face ((t :inherit link-visited :underline nil))))

;; python packages
;; $ sudo pip install jedi epc

(transient-mark-mode 1) ; highlight text selection
(delete-selection-mode 1) ; delete seleted text when typing

;; highlight parens expression
(show-paren-mode 1)
(setq show-paren-style 'expression)

;; stop creating those backup~ files
(setq make-backup-files nil)

;; stop creating auto-save files #
(setq auto-save-default nil)

;; My shortcut for "go to line"
(global-set-key (kbd "C-x g") 'goto-line)

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
(setq sml/no-confirm-load-theme t)
(require 'smart-mode-line)
(sml/setup)
(sml/apply-theme 'light-powerline)
(nyan-mode)
(nyan-start-animation)

;; theme
(load-theme 'monokai)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(setq-default cursor-type 'hollow)
(set-cursor-color "red")
(cua-mode 1)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)

(setq-default ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'css-mode-hook 'ac-css-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'objc-mode)

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

;;; for prog modes turn on flyspell-prog-mode (checks spell only in comments)
(dolist (hook '(lisp-mode-hook
                emacs-lisp-mode-hook
                c++-mode-hook
                c-mode-hook
                go-mode-hook
                rust-mode-hok
                python-mode-hook
                javascript-mode-hook
                LaTeX-mode-hook))
  (add-hook hook 'flyspell-prog-mode))

(defun flyspell-emacs-popup-textual (event poss word)
      "A textual flyspell popup menu."
      (require 'popup)
      (let* ((corrects (if flyspell-sort-corrections
                           (sort (car (cdr (cdr poss))) 'string<)
                         (car (cdr (cdr poss)))))
             (cor-menu (if (consp corrects)
                           (mapcar (lambda (correct)
                                     (list correct correct))
                                   corrects)
                         '()))
             (affix (car (cdr (cdr (cdr poss)))))
             show-affix-info
             (base-menu  (let ((save (if (and (consp affix) show-affix-info)
                                         (list
                                          (list (concat "Save affix: " (car affix))
                                                'save)
                                          '("Accept (session)" session)
                                          '("Accept (buffer)" buffer))
                                       '(("Save word" save)
                                         ("Accept (session)" session)
                                         ("Accept (buffer)" buffer)))))
                           (if (consp cor-menu)
                               (append cor-menu (cons "" save))
                             save)))
             (menu (mapcar
                    (lambda (arg) (if (consp arg) (car arg) arg))
                    base-menu)))
        (cadr (assoc (popup-menu* menu :scroll-bar t) base-menu))))

(eval-after-load "flyspell"
  '(progn
     (fset 'flyspell-emacs-popup 'flyspell-emacs-popup-textual)))

;; high light current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#330")

;; Allow hash to be entered
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;;; Unbind the stupid minimize that I always hit.
(global-unset-key "\C-z")

;; bell can go fuck
(setq ring-bell-function 'ignore)

;; Snag the user's PATH and GOPATH
(exec-path-from-shell-initialize)
(exec-path-from-shell-copy-env "GOBIN")

;; Customize how flymake displays the errors
'(flymake-errline ((((class color)) (:underline "OrangeRed"))))
'(flymake-warnline ((((class color)) (:underline "yellow"))))

;; go mode  --------------------------
;; Define function to call when go-mode loads
(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save) ; gofmt before every save
  (setq gofmt-command "goimports")                ; gofmt uses invokes goimports
  (if (not (string-match "go" compile-command))   ; set compile command default
      (set (make-local-variable 'compile-command)
           "go build -v ./..."))

  (require 'lsp-mode)
  (require 'lsp-ui)
  (require 'company)

  (local-set-key (kbd "C-c C-j") 'lsp-find-definition)
  (global-set-key (kbd "C-<tab>") 'company-complete)

  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t)))
  
  (lsp 1)
  (lsp-ui-mode 1)
)

;; Connect go-mode-hook with the function we just defined
(add-hook 'go-mode-hook 'my-go-mode-hook)
;; --------------------------

;; rust mode  --------------------------
(defun my-rust-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq rust-format-on-save t)

  (require 'lsp-mode)
  (require 'lsp-ui)
  (require 'company)

  (local-set-key (kbd "C-c C-j") 'lsp-find-definition)
  (global-set-key (kbd "C-<tab>") 'company-complete)

  (lsp 1)
  (lsp-ui-mode 1)
  )
;; Connect rust-mode-hook with the function we just defined
(add-hook 'rust-mode-hook 'my-rust-mode-hook)

;; C/C++ mode  --------------------------

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(defun my-c++-mode-hook ()
  (require 'clang-format)
  (defun clang-format-buffer-smart ()
    "Reformat buffer if .clang-format exists in the projectile root."
    (when (eq major-mode 'c++-mode)
      (clang-format-buffer "file" (expand-file-name "contrib/clang-format" (projectile-project-root)))))
  
  (add-hook 'before-save-hook 'clang-format-buffer-smart)
  
  (require 'lsp-mode)
  (require 'lsp-ui)
  (require 'company)

  (setq lsp-print-io t)
  (setq lsp-enable-snippet t)
  (setq lsp-signature-render-documentation t)

  (local-set-key (kbd "C-c C-j") 'lsp-find-definition)
  (global-set-key (kbd "C-<tab>") 'company-complete)

  (lsp 1)
  (lsp-ui-mode 1)
  )

(defun my-c-mode-hook ()
  (require 'clang-format)
  (defun clang-format-buffer-smart ()
    "Reformat buffer if .clang-format exists in the projectile root."
    (when (eq major-mode 'c++-mode)
      (clang-format-buffer "file" (expand-file-name "contrib/clang-format" (projectile-project-root)))))
  
  (add-hook 'before-save-hook 'clang-format-buffer-smart)
  
  (require 'lsp-mode)
  (require 'lsp-ui)
  (require 'company)

  

  (local-set-key (kbd "C-c C-j") 'lsp-find-definition)
  (global-set-key (kbd "C-<tab>") 'company-complete)

  (lsp 1)
  (lsp-ui-mode 1)
  )

;; Connect c++-mode-hook with the function we just defined
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c-mode-hook)
;; done

;; line number mode
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

(setq indent-tabs-mode nil)

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
                    (set-buffer-modified-p nil))))))


(if (display-graphic-p)
    (progn
      (set-face-attribute 'default nil :height 160)))
