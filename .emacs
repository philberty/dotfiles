;;; init.el --- Philip's Emacs configuration -*- lexical-binding: t; -*-

;;; Package management

(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(defvar my-package-list
  '(atom-one-dark-theme
    clang-format
    company
    cython-mode
    exec-path-from-shell
    flycheck
    ggtags
    go-mode
    helm
    helm-gtags
    helm-projectile
    lsp-mode
    lsp-ui
    markdown-mode
    monokai-theme
    neotree
    nyan-mode
    popup
    projectile
    qml-mode
    rust-mode
    smart-mode-line
    smart-mode-line-powerline-theme
    stickyfunc-enhance
    tabbar
    tabbar-ruler
    web-mode
    yaml-mode)
  "Packages used by this configuration.")

(defun my-install-missing-packages ()
  "Install packages from `my-package-list' that are not already installed."
  (let ((missing (seq-filter (lambda (pkg) (not (package-installed-p pkg)))
                             my-package-list)))
    (when missing
      (package-refresh-contents)
      (dolist (pkg missing)
        (package-install pkg)))))

(require 'seq)
(my-install-missing-packages)

;;; General behaviour

(setq inhibit-startup-screen t
      initial-scratch-message ";; Happy Hacking\n"
      ring-bell-function #'ignore
      make-backup-files nil
      auto-save-default nil
      scroll-conservatively 101
      scroll-margin 2
      scroll-step 1
      next-screen-context-lines 5
      auto-window-vscroll nil)

(setq-default indent-tabs-mode nil
              truncate-lines t
              cursor-type 'hollow)

(global-auto-revert-mode 1)
(global-visual-line-mode 1)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)
(column-number-mode 1)
(delete-selection-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)
(cua-mode 1)

(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1))

(setq show-paren-style 'expression
      electric-pair-pairs '((?\" . ?\")
                            (?\{ . ?\})))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(set-cursor-color "red")
(set-face-background 'hl-line "#330")

;; C-z minimises the frame by default, which is too easy to hit accidentally.
(global-unset-key (kbd "C-z"))

(global-set-key (kbd "C-x g") #'goto-line)
(global-set-key (kbd "M-3") (lambda () (interactive) (insert "#")))
(global-set-key (kbd "C-<tab>") #'company-complete)

;;; Shell environment

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)
(exec-path-from-shell-copy-env "GOBIN")

;;; Appearance

(load-theme 'monokai t)

(require 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
(sml/setup)
(sml/apply-theme 'light-powerline)

(require 'nyan-mode)
(nyan-mode 1)
(nyan-start-animation)

(setq tabbar-ruler-global-tabbar t)
(require 'tabbar-ruler)

;;; Project navigation

(require 'helm)
(require 'helm-projectile)
(require 'helm-gtags)

(global-set-key (kbd "M-x") #'helm-M-x)

(projectile-mode 1)
(setq projectile-enable-caching t
      projectile-completion-system 'helm
      projectile-switch-project-action #'neotree-projectile-action)
(helm-projectile-on)

(require 'stickyfunc-enhance)
(require 'neotree)

(setq neo-theme 'ascii)

(add-hook 'neotree-mode-hook
          (lambda ()
            (display-line-numbers-mode -1)))

;;; File modes

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(add-hook 'markdown-mode-hook
          (lambda ()
            (when buffer-file-name
              (add-hook 'after-save-hook #'check-parens nil t))))

;;; Spelling

(dolist (hook '(lisp-mode-hook
                emacs-lisp-mode-hook
                c-mode-hook
                c++-mode-hook
                go-mode-hook
                rust-mode-hook
                python-mode-hook
                javascript-mode-hook
                LaTeX-mode-hook))
  (add-hook hook #'flyspell-prog-mode))

;;; Completion and LSP

(require 'company)
(add-hook 'after-init-hook #'global-company-mode)

(require 'lsp-mode)
(require 'lsp-ui)

(setq lsp-print-io nil
      lsp-enable-snippet t
      lsp-signature-render-documentation t

      ;; Floating documentation at point.
      lsp-ui-doc-enable t
      lsp-ui-doc-show-with-cursor t
      lsp-ui-doc-show-with-mouse nil
      lsp-ui-doc-delay 0.5
      lsp-ui-doc-position 'at-point

      ;; Turn off the noisier automatic UI for now.
      lsp-ui-sideline-enable nil
      lsp-ui-peek-enable nil)

(add-hook 'lsp-mode-hook #'lsp-ui-mode)

(with-eval-after-load 'lsp-mode
  (define-key lsp-mode-map (kbd "C-c C-j") #'lsp-find-definition)
  (define-key lsp-mode-map (kbd "C-c C-k") #'lsp-find-references)
  (define-key lsp-mode-map (kbd "C-c C-a") #'lsp-execute-code-action)
  (define-key lsp-mode-map (kbd "C-c C-r") #'lsp-rename)
  (define-key lsp-mode-map (kbd "C-c C-i") #'lsp-find-implementation)
  (define-key lsp-mode-map (kbd "C-c C-t") #'lsp-find-type-definition)
  (define-key lsp-mode-map (kbd "C-c C-o") #'lsp-clangd-find-other-file))

;;; Go

(defun my-go-mode-setup ()
  "Configure Go buffers."
  (setq-local gofmt-command "goimports")
  (unless (string-match-p "go" compile-command)
    (setq-local compile-command "go build -v ./..."))
  (add-hook 'before-save-hook #'gofmt-before-save nil t)
  (lsp-deferred))

(with-eval-after-load 'lsp-mode
  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t))))

(add-hook 'go-mode-hook #'my-go-mode-setup)

;;; Rust

(defun my-rust-mode-setup ()
  "Configure Rust buffers."
  (setq-local rust-format-on-save t)
  (lsp-deferred))

(add-hook 'rust-mode-hook #'my-rust-mode-setup)

;;; C and C++

(defun my-clang-format-buffer-if-configured ()
  "Format the current buffer when its project has a .clang-format file."
  (when (and buffer-file-name
             (derived-mode-p 'c-mode 'c++-mode)
             (locate-dominating-file buffer-file-name ".clang-format"))
    (clang-format-buffer "file" buffer-file-name)))

(defun my-c-family-mode-setup ()
  "Configure C and C++ buffers."
  (require 'clang-format)
  (setq-local show-trailing-whitespace t)
  (add-hook 'before-save-hook #'my-clang-format-buffer-if-configured nil t)
  (lsp-deferred))

(add-hook 'c-mode-hook #'my-c-family-mode-setup)
(add-hook 'c++-mode-hook #'my-c-family-mode-setup)

;;; Utility commands

(defun how-many-region (begin end regexp)
  "Count non-empty matches for REGEXP between BEGIN and END."
  (interactive "r\nsHow many matches for regexp: ")
  (let ((count 0)
        previous-point)
    (save-excursion
      (goto-char begin)
      (while (and (< (setq previous-point (point)) end)
                  (re-search-forward regexp end t))
        (if (= previous-point (point))
            (forward-char 1)
          (setq count (1+ count)))))
    (message "%d occurrences" count)
    count))

(defun rename-file-and-buffer (new-name)
  "Rename the current buffer and its visited file to NEW-NAME."
  (interactive "FNew name: ")
  (let ((filename buffer-file-name))
    (cond
     ((not filename)
      (user-error "Current buffer is not visiting a file"))
     ((get-file-buffer new-name)
      (user-error "A buffer is already visiting %s" new-name))
     (t
      (rename-file filename new-name 1)
      (set-visited-file-name new-name t t)))))

;;; Custom-generated settings

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8dbbcb2b7ea7e7466ef575b60a92078359ac260c91fe908685b3983ab8e20e3f"
     "8b58ef2d23b6d164988a607ee153fd2fa35ee33efc394281b1028c2797ddeebb"
     "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9"
     "3629b62a41f2e5f84006ff14a2247e679745896b5eaa1d5bcfbc904a3441b0cd"
     "f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c"
     "ace9f12e0c00f983068910d9025eefeb5ea7a711e774ee8bb2af5f7376018ad2"
     "1fc1fdf975c8c8c3767c29787a063eee50cbceef903644a0771fa66568ee8777"
     "c567c85efdb584afa78a1e45a6ca475f5b55f642dfcd6277050043a568d1ac6f"
     "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223"
     "6df30cfb75df80e5808ac1557d5cc728746c8dbc9bc726de35b15180fa6e0ad9"
     "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e"
     "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a"
     "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf"
     "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e"
     "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a"
     "3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723"
     "025354235e98db5e7fd9c1a74622ff53ad31b7bde537d290ff68d85665213d85"
     "6fe6ab4abe97a4f13533e47ae59fbba7f2919583f9162b440dd06707b01f7794"
     "fb4bf07618eab33c89d72ddc238d3c30918a501cf7f086f2edf8f4edba9bd59f"
     default))
 '(package-selected-packages nil)
 '(safe-local-variable-values
   '((eval add-hook 'before-save-hook 'time-stamp)
     (eval c-set-offset 'innamespace 0)
     (eval c-set-offset 'brace-list-open 0)
     (eval when (fboundp 'c-toggle-comment-style)
           (c-toggle-comment-style 1)))))

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

(provide 'init)
;;; init.el ends here
