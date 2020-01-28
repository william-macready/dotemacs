(setq user-full-name "William Macready"
      user-mail-address "william.macready@gmail.com")

(setq make-backup-files nil
      auto-save-default nil
      inhibit-startup-screen t
      ring-bell-function 'ignore)

(fset 'yes-or-no-p 'y-or-n-p)
(column-number-mode)
(blink-cursor-mode 0)
(pixel-scroll-mode)
(size-indication-mode)

(require 'cl-lib)
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'diminish)
  (package-install 'bind-key)
  (package-install 'use-package)
  (setq use-package-always-ensure t)
  (use-package diminish :ensure t))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
(setq use-package-verbose t)
(setq use-package-check-before-init t)
(setq use-package-minimum-reported-time 0.01)


(set-charset-priority 'unicode)
(setq locale-coding-system   'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system        'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(use-package no-littering
  :ensure t
  :config
  (require 'recentf)
  (add-to-list 'recentf-exclude no-littering-etc-directory)
  (add-to-list 'recentf-exclude no-littering-var-directory))

(use-package all-the-icons
  :ensure t
  )

(use-package all-the-icons-dired
  :ensure t
  :init
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  )

(use-package doom-modeline
  :if window-system
  :ensure t
  :hook
  (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 3)
  (setq doom-modeline-buffer-file-name-style 'buffer-name)
  (setq doom-modeline-icon t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon nil)
  (setq doom-modeline-minor-modes nil)
  (setq doom-modeline-enable-word-count nil)
  (setq doom-modeline-checker-simple-format nil)
  (setq doom-modeline-persp-name nil)
  (setq doom-modeline-lsp t)
  (setq doom-modeline-github nil)
  (setq doom-modeline-env-version nil)
  (setq doom-modeline-env-enable-python nil)
  (setq doom-modeline-env-enable-ruby nil)
  (setq doom-modeline-env-enable-perl nil)
  (setq doom-modeline-env-enable-go nil)
  (setq doom-modeline-env-enable-elixir nil)
  (setq doom-modeline-env-enable-rust nil)
  (setq doom-modeline-mu4e nil)
  (setq doom-modeline-irc nil)
  (setq doom-modeline-irc-stylize 'identity)
  )

(use-package doom-themes
  :if window-system
  :ensure t
  :after (doom-modeline)
  :init
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (setq doom-nord-brighter-modeline t)
  (setq doom-nord-brighter-comments t)
  (setq doom-nord-comment-bg t)
  (setq doom-nord-padded-modeline t)
  (setq doom-nord-light-brighter-modeline t)
  (setq doom-nord-light-brighter-comments t)
  (setq doom-nord-light-comment-bg t)
  (setq doom-nord-light-padded-modeline t)
  (setq doom-nord-light-region-highlight t)
  (load-theme 'doom-nord t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config)
)

(use-package centaur-tabs
  :demand
  :ensure t
  :config
  (setq centaur-tabs-style "wave")
  (setq centaur-tabs-height 32)
  ;; (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-gray-out-icons 'buffer)
  ;; (setq centaur-tabs-set-bar 'over)
  ;; (setq centaur-tabs-set-modified-marker t)
  ;; (centaur-tabs-inherit-tabbar-faces)
  (setq centaur-tabs-set-close-button nil)
  (centaur-tabs-headline-match)
  (centaur-tabs-mode t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  ("C-c t" . centaur-tabs-counsel-switch-group)
)

(set-face-attribute 'default nil
                    :family "Office Code Pro"
                    :height 120
                    :weight 'normal
                    :width 'normal)

(use-package gcmh
  :ensure t
  :config
  (gcmh-mode 1)
  )

(use-package use-package-hydra
  :ensure t
  :after hydra)

(use-package load-relative
  :ensure t)

(use-package saveplace
  :ensure t
  :init
  (save-place-mode)
  (setq-default save-place t))

(use-package time
  :ensure t
  :custom
  (display-time-24hr-format t)
  (display-time-day-and-date t)
  (display-time-mail-file (quote none))
  (display-time-mail-function (quote ignore))
  (display-time-default-load-average nil)
  :config
  (display-time-mode))

(use-package volatile-highlights
  :ensure t
  :diminish volatile-highlights-mode
  :init
  (volatile-highlights-mode t))

(use-package hydra
  :ensure t
  :config
  (defhydra hydra-ibuffer-main (:color pink :hint nil)
    "
    ^Mark^         ^Actions^         ^View^          ^Select^              ^Navigation^
    _m_: mark      _D_: delete       _g_: refresh    _q_: quit             _k_:   ↑    _h_
    _u_: unmark    _s_: save marked  _S_: sort       _TAB_: toggle         _RET_: visit
    _*_: specific  _a_: all actions  _/_: filter     _o_: other window     _j_:   ↓    _l_
    _t_: toggle    _._: toggle hydra _H_: help       C-o other win no-select
    "
    ("m" ibuffer-mark-forward)
    ("u" ibuffer-unmark-forward)
    ("*" hydra-ibuffer-mark/body :color blue)
    ("t" ibuffer-toggle-marks)

    ("D" ibuffer-do-delete)
    ("s" ibuffer-do-save)
    ("a" hydra-ibuffer-action/body :color blue)

    ("g" ibuffer-update)
    ("S" hydra-ibuffer-sort/body :color blue)
    ("/" hydra-ibuffer-filter/body :color blue)
    ("H" describe-mode :color blue)

    ("h" ibuffer-backward-filter-group)
    ("k" ibuffer-backward-line)
    ("l" ibuffer-forward-filter-group)
    ("j" ibuffer-forward-line)
    ("RET" ibuffer-visit-buffer :color blue)

    ("TAB" ibuffer-toggle-filter-group)

    ("o" ibuffer-visit-buffer-other-window :color blue)
    ("q" quit-window :color blue)
    ("." nil :color blue)
    )
  (defhydra hydra-ibuffer-mark (:color teal :columns 5
                                       :after-exit (hydra-ibuffer-main/body))
    "Mark"
    ("*" ibuffer-unmark-all "unmark all")
    ("M" ibuffer-mark-by-mode "mode")
    ("m" ibuffer-mark-modified-buffers "modified")
    ("u" ibuffer-mark-unsaved-buffers "unsaved")
    ("s" ibuffer-mark-special-buffers "special")
    ("r" ibuffer-mark-read-only-buffers "read-only")
    ("/" ibuffer-mark-dired-buffers "dired")
    ("e" ibuffer-mark-dissociated-buffers "dissociated")
    ("h" ibuffer-mark-help-buffers "help")
    ("z" ibuffer-mark-compressed-file-buffers "compressed")
    ("b" hydra-ibuffer-main/body "back" :color blue)
    )
  (defhydra hydra-ibuffer-action (:color teal :columns 4
                                         :after-exit
                                         (if (eq major-mode 'ibuffer-mode)
                                             (hydra-ibuffer-main/body)))
    "Action"
    ("A" ibuffer-do-view "view")
    ("E" ibuffer-do-eval "eval")
    ("F" ibuffer-do-shell-command-file "shell-command-file")
    ("I" ibuffer-do-query-replace-regexp "query-replace-regexp")
    ("H" ibuffer-do-view-other-frame "view-other-frame")
    ("N" ibuffer-do-shell-command-pipe-replace "shell-cmd-pipe-replace")
    ("M" ibuffer-do-toggle-modified "toggle-modified")
    ("O" ibuffer-do-occur "occur")
    ("P" ibuffer-do-print "print")
    ("Q" ibuffer-do-query-replace "query-replace")
    ("R" ibuffer-do-rename-uniquely "rename-uniquely")
    ("T" ibuffer-do-toggle-read-only "toggle-read-only")
    ("U" ibuffer-do-replace-regexp "replace-regexp")
    ("V" ibuffer-do-revert "revert")
    ("W" ibuffer-do-view-and-eval "view-and-eval")
    ("X" ibuffer-do-shell-command-pipe "shell-command-pipe")
    ("b" nil "back")
    )
  (defhydra hydra-ibuffer-sort (:color amaranth :columns 3)
    "Sort"
    ("i" ibuffer-invert-sorting "invert")
    ("a" ibuffer-do-sort-by-alphabetic "alphabetic")
    ("v" ibuffer-do-sort-by-recency "recently used")
    ("s" ibuffer-do-sort-by-size "size")
    ("f" ibuffer-do-sort-by-filename/process "filename")
    ("m" ibuffer-do-sort-by-major-mode "mode")
    ("b" hydra-ibuffer-main/body "back" :color blue)
    )
  (defhydra hydra-ibuffer-filter (:color amaranth :columns 4)
    "Filter"
    ("m" ibuffer-filter-by-used-mode "mode")
    ("M" ibuffer-filter-by-derived-mode "derived mode")
    ("n" ibuffer-filter-by-name "name")
    ("c" ibuffer-filter-by-content "content")
    ("e" ibuffer-filter-by-predicate "predicate")
    ("f" ibuffer-filter-by-filename "filename")
    (">" ibuffer-filter-by-size-gt "size")
    ("<" ibuffer-filter-by-size-lt "size")
    ("/" ibuffer-filter-disable "disable")
    ("b" hydra-ibuffer-main/body "back" :color blue)
    )
  (defhydra hydra-outline (:color pink :hint nil)
    "
^Hide^             ^Show^           ^Move
^^^^^^------------------------------------------------------
_q_: sublevels     _a_: all         _u_: up
_t_: body          _e_: entry       _n_: next visible
_o_: other         _i_: children    _p_: previous visible
_c_: entry         _k_: branches    _f_: forward same level
_l_: leaves        _s_: subtree     _b_: backward same level
_d_: subtree

"
    ;; Hide
    ("q" outline-hide-sublevels)    ; Hide everything but the top-level headings
    ("t" outline-hide-body)         ; Hide everything but headings (all body lines)
    ("o" outline-hide-other)        ; Hide other branches
    ("c" outline-hide-entry)        ; Hide this entry's body
    ("l" outline-hide-leaves)       ; Hide body lines in this entry and sub-entries
    ("d" outline-hide-subtree)      ; Hide everything in this entry and sub-entries
    ;; Show
    ("a" outline-show-all)          ; Show (expand) everything
    ("e" outline-show-entry)        ; Show this heading's body
    ("i" outline-show-children)     ; Show this heading's immediate child sub-headings
    ("k" outline-show-branches)     ; Show all sub-headings under this heading
    ("s" outline-show-subtree)      ; Show (expand) everything in this heading & below
    ;; Move
    ("u" outline-up-heading)                ; Up
    ("n" outline-next-visible-heading)      ; Next
    ("p" outline-previous-visible-heading)  ; Previous
    ("f" outline-forward-same-level)        ; Forward - same level
    ("b" outline-backward-same-level)       ; Backward - same level
    ("z" nil "leave"))
  )

  (defhydra hydra-move ()
    "move"
    ("n" next-line)
    ("p" previous-line)
    ("f" forward-char)
    ("b" backward-char)
    ("a" beginning-of-line)
    ("e" move-end-of-line)
    ("v" scroll-up-command)
    ("c" scroll-down-command)
    ("l" recenter-top-bottom))

(use-package smex :ensure t)

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :custom
  (enable-recursive-minibuffers t)
  (ivy-display-style 'fancy)
  (ivy-use-virtual-buffers t)
  (ivy-use-selectable-prompt t)
  :bind
  (
   ("C-c C-r" . ivy-resume)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)
   ("C-M-y" . ivy-previous-line)
   )
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  )

(use-package ivy-posframe
  :ensure t
  :after ivy
  :config
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
  (ivy-posframe-mode 1)
  )

(use-package ivy-bibtex
  :ensure t
  :after ivy
  :config
  (setq ivy-re-builders-alist
      '((ivy-bibtex . ivy--regex-ignore-order)
        (t . ivy--regex-plus))))

(use-package swiper
  :ensure t
  :bind
  ("\C-s" . swiper))

(use-package counsel
  :ensure t
  :diminish counsel-mode
  :bind
  (
   ("M-x"     . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-h v"   . counsel-describe-variable)
   ("C-h f"   . counsel-describe-function)
   ("C-c 8"   . counsel-unicode-char)
   ("C-."     . counsel-imenu)
   ("M-y"     . counsel-yank-pop)
   :map read-expression-map
   ("C-r"     . counsel-expression-history)
  )
  :custom
  (counsel-find-file-at-point t)
  :config
  (counsel-mode))

(use-package all-the-icons-ivy
  :ensure t
  :config
  (all-the-icons-ivy-setup))

(use-package mwim
  :ensure t
  :bind
  (
   ("C-a" . mwim-beginning-of-line-or-code)
   ("C-e" . mwim-end-of-code-or-line)
   ("<home>" . mwim-beginning-of-line-or-code)
   ("<end>" . mwim-end-of-line-or-code)
   )
  )

(use-package comment-dwim-2
  :ensure t
  :bind
  ("M-;" . comment-dwim-2))

(use-package beginend
  :ensure t
  :diminish beginend-global-mode
  :config
  (diminish 'beginend-prog-mode)
  (diminish 'beginend-magit-status-mode)
  (diminish 'beginend-prodigy-mode)
  (diminish 'beginend-elfeed-search-mode)
  (diminish 'beginend-notmuch-search-mode)
  (diminish 'beginend-compilation-mode)
  (diminish 'beginend-org-agenda-mode)
  (diminish 'beginend-recentf-dialog-mode)
  (beginend-global-mode))

(use-package paren
  :ensure t
  :custom
  (show-paren-style (quote expression))
  :config
  (show-paren-mode))

(use-package winner
  :ensure t
  :diminish winner-mode
  :config
  (winner-mode))

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(use-package recentf
  :ensure t
  :bind
  ("C-x C-r" . 'ido-recentf-open)
  :custom
  (recentf-auto-cleanup 'never)
  (recentf-exclude (list "/\\.git/.*\\'" "/elpa/.*\\'"))
  (recentf-max-menu-items 25)
  (recentf-max-saved-items 50)
  :config
  (recentf-mode))

(use-package autorevert
  :ensure t
  :custom
  (auto-revert-verbose nil)
  (global-auto-revert-non-file-buffers t)
  :init
  (when (eq system-type 'darwin) (setq auto-revert-use-notify nil))
  :diminish auto-revert-mode
  :config
  (global-auto-revert-mode))

(use-package ibuffer
  :ensure t
  :bind
  (
   ("C-x C-b" . ibuffer)
   :map ibuffer-mode-map
   ("." . hydra-ibuffer-main/body)
   )
  :config
  (autoload 'ibuffer "ibuffer" "List buffers." t)
  (add-hook 'ibuffer-hook #'hydra-ibuffer-main/body))

(use-package projectile
  :init
  (setq projectile-completion-system 'ivy)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  :config
  (projectile-mode))

(use-package counsel-projectile
     :bind
     ("C-c p s r" . counsel-projectile-rg)
     (:map projectile-mode-map
	   ("C-c p p" . projectile-persp-switch-project)
	   ("C-c p f" . projectile-find-file))
     :init
     (counsel-projectile-mode))

(use-package ace-window
  :bind ("M-o" . hydra-window/body)
  :config
  (setq aw-dispatch-always t)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (defhydra hydra-window (:color blue)
    "window"
    ("h" windmove-left "left")
    ("j" windmove-down "down")
    ("k" windmove-up "up")
    ("l" windmove-right "right")
    ("a" ace-window "ace")
    ("s" (lambda () (interactive) (ace-window 4)) "swap")
    ("d" (lambda () (interactive) (ace-window 16)) "delete")
    ("q" nil "Quit")))

(use-package goto-chg
  :ensure t
  :bind (("C-?" . goto-last-change)))

(use-package helpful
  :ensure t
  :defer t
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h F" . helpful-function)
         ("C-h C" . helpful-command)
         ))

(use-package neotree
  :ensure t
  :defer t
  :bind (("<f4>" . neotree-toggle))
  :config (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  )

(use-package flycheck
  :ensure t
  :defer t
  :custom
  (flycheck-gfortran-language-standard "f2008")
  (flycheck-gfortran-layout (quote free))
  :config
  (add-hook 'f90-mode-hook 'flycheck-mode)
)

(use-package dumb-jump
  :ensure t
  :defer t
  :after hydra
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :hydra (hydra-dumb-jump (:color blue :columns 3)
           "Dumb Jump"
           ("j" dumb-jump-go "Go")
           ("o" dumb-jump-go-other-window "Other window")
           ("e" dumb-jump-go-prefer-external "Go external")
           ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
           ("i" dumb-jump-go-prompt "Prompt")
           ("l" dumb-jump-quick-look "Quick look")
           ("b" dumb-jump-back "Back"))
  :config
  (setq dumb-jump-selector 'ivy)
)

(use-package region-occurrences-highlighter
  :ensure t
  :defer t
  :config
  (define-key region-occurrences-highlighter-nav-mode-map "\M-n" 'region-occurrences-highlighter-next)
  (define-key region-occurrences-highlighter-nav-mode-map "\M-p" 'region-occurrences-highlighter-prev))

(use-package company
  :ensure t
  :defer 5
  :diminish
  )

(use-package company-posframe
  :ensure t
  :after company
  :diminish
  :config
  (company-posframe-mode 1)
)

(use-package lsp-mode
  :ensure t
  :commands lsp
  :diminish
  )

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :diminish
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  )

(use-package company-lsp
  :ensure t
  :commands company-lsp
  :diminish
  :config
  (push 'company-lsp company-backends)
  )

(setq dired-auto-revert-buffer t)
(setq dired-listing-switches "-alhF")
(setq dired-ls-F-marks-symlinks t)
(setq echo-keystrokes 0.1)


(defun goto-line-with-feedback (&optional line)
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive "P")
  (if line
      (goto-line line)
    (unwind-protect
        (progn
          (linum-mode 1)
          (goto-line (read-number "Goto line: ")))
      (linum-mode -1))))

(define-key global-map (kbd "C-+") #'text-scale-increase)
(define-key global-map (kbd "C--") #'text-scale-decrease)
(global-set-key [remap goto-line] #'goto-line-with-feedback)
(global-set-key [remap imenu-anywhere] 'ivy-imenu-anywhere)
(global-set-key (kbd "C-<backspace>") (lambda () (interactive) (kill-line 0)))

(use-package tex-site :ensure auctex)

(use-package tex
  :ensure auctex
  :defer t
  :custom
  (TeX-auto-local "auto")
  (TeX-auto-save t)
  (TeX-clean-confirm t)
  (TeX-debug-bad-boxes t)
  (TeX-debug-warnings t)
  (TeX-electric-math (quote ("$" . "$")))
  (TeX-electric-sub-and-superscript t)
  (TeX-parse-self t)
  (TeX-source-correlate-mode t)
  :config
  (setq-default TeX-engine 'luatex)
  (setq-default TeX-master nil)
  (unless (assoc "PDF Tools" TeX-view-program-list-builtin)
    (push '("PDF Tools" TeX-pdf-tools-sync-view) TeX-view-program-list))
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
        TeX-source-correlate-start-server t))

(use-package tex-buf
  :ensure auctex
  :defer t
  :custom
  (TeX-error-overview-open-after-TeX-run t)
  (TeX-error-overview-setup (quote separate-frame))
  (TeX-save-query t))

(use-package tex-mode :ensure auctex :defer t)

(use-package tex-style
  :ensure auctex
  :defer t
  :custom
  (LaTeX-includegraphics-read-file (quote LaTeX-includegraphics-read-file-relative)))

(use-package latex
    :ensure auctex
    :defer t
    :init
    (defcustom LaTeX-indent-level-item-continuation 4
    "*Indentation of continuation lines for items in itemize-like environments."
    :group 'LaTeX-indentation
    :type 'integer)
    (setq LaTeX-default-author "William Macready")
    (setq LaTeX-default-environment "equation")
    (setq LaTeX-default-options (quote ("11pt")))
    (setq LaTeX-default-style "scrartcl")
    (setq LaTeX-electric-left-right-brace t)
    (setq LaTeX-indent-level 2)
    (setq LaTeX-indent-level-item-continuation 4)
    (setq LaTeX-item-indent -2)
    (setq LaTeX-math-menu-unicode t)
    (setq LaTeX-top-caption-list (quote ("table" "algorithm")))
    (cond
      ((string-equal system-type "windows-nt") ; Microsoft Windows
        (progn
          (setq LaTeX-math-abbrev-prefix "`")
        ))
      ((string-equal system-type "darwin") ; Mac OS X
        (progn
          (setq LaTeX-math-abbrev-prefix "#")
        ))
      ((string-equal system-type "gnu/linux") ; linux
        (progn
          (setq LaTeX-math-abbrev-prefix "`")
        ))
    )
    (setq font-latex-match-type-command-keywords
      (quote
        (("linkgraphics" "[{"))))
    (setq font-latex-match-slide-title-keywords
      (quote
        (("framesubtitle" "{")
         ("frametitle" "{")
         ("multisubtitle" "{"))))
    (setq font-latex-match-reference-keywords
      (quote
        (("cref" "{") ("eidx" "*{"))))
    (setq LaTeX-math-list (quote
      (("C-v" "vec" ("private") nil)
       ("C-a" "abs*" ("private") nil))))
    (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
    (add-hook 'latex-mode-hook 'turn-on-reftex)
    (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
    (add-hook 'LaTeX-mode-hook 'outline-minor-mode)
; Moved to MyMathEnvironments.el
;    (add-hook 'LaTeX-mode-hook
;       (lambda ()
;           (LaTeX-add-environments
;               '("definition" LaTeX-env-label)
;               '("theorem" LaTeX-env-label)
5;               '("proposition" LaTeX-env-label)
;               '("lemma" LaTeX-env-label)
;               )))
    :config
    (add-to-list 'LaTeX-font-list '(?\C-x "\\eidx*{" "}"))
;    (add-to-list 'LaTeX-label-alist
;       '(("theorem" . "thm:")
;         ("corollary" . "thm:")
;         ("proposition" . "thm:")
;         ("lemma" . "thm:")
;         ("definition" . "thm:")
;         ))
    (add-hook 'LaTeX-mode-hook
          (lambda ()
            (local-set-key (kbd "C-$") 'replace-matching-parens)
            (local-set-key [f9] 'TeX-error-overview)
            ))
  )

(use-package bibtex
  :ensure t
  :config
  (bibtex-set-dialect 'biblatex)
  )

(use-package reftex-vars
  :ensure reftex
  :defer t
  :commands turn-on-reftex
  :diminish reftex-mode
  :init
  (setq reftex-plug-into-AUCTeX t)
  :config
  (setq reftex-auto-recenter-toc t)
  (setq reftex-default-bibliography (getenv "LIBRARYPATH"))
  (setq reftex-enable-partial-scans nil)
  (setq reftex-index-follow-mode t)
  (setq reftex-keep-temporary-buffers t)
  (setq reftex-save-parse-info nil)
  (setq reftex-toc-follow-mode t)
  (setq reftex-toc-include-context t)
  (setq reftex-toc-include-file-boundaries t)
  ;; Unsure if this is working
  (setq reftex-label-alist
      '(
        ("theorem" ?A "thm:" "~\\ref{%s}" t ("Theorem" "theorem") -3)
        ("proposition" ?B "thm:" "~\\ref{%s}" t ("Proposition" "proposition") -3)
        ("lemma" ?C "thm:" "~\\ref{%s}" t ("Lemma" "lemma") -3)
        ("definition" ?D "thm:" "~\\ref{%s}" t ("Definition" "definition") -3)
        ("remark" ?E "rem:" "~\\ref{%s}" t ("Remark" "remark") -3)
        ("corollary" ?F "thm:" "~\\ref{%s}" t ("Corollary" "corollary") -3)
  ))
  (setq reftex-trust-label-prefix '("tab:" "fig:" "eq:"))
  (add-to-list 'reftex-section-levels '("frametitle" . 4) t)
  (add-to-list 'reftex-section-levels '("framesubtitle" . 5) t)
  ;; Provide basic RefTeX support for biblatex
  (add-to-list 'reftex-cite-format-builtin
               '(biblatex "biblatex"
                          ((?\C-m . "\\cite[]{%l}")
                           (?t . "\\textcite{%l}")
                           (?a . "\\autocite[]{%l}")
                           (?p . "\\parencite{%l}")
                           (?f . "\\footcite[][]{%l}")
                           (?F . "\\fullcite[]{%l}")
                           (?x . "[]{%l}")
                           (?X . "{%l}"))))
  (setq reftex-cite-format 'biblatex)
)

(use-package pdf-tools
  :ensure t
  :magic ("%PDF" . pdf-view-mode)
  :config
  ;; open pdfs scaled to fit page
  (setq-default pdf-view-display-size 'fit-page)
  ;; use normal isearch
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  ;; keyboard shortcuts
  (define-key pdf-view-mode-map (kbd "h") 'pdf-annot-add-highlight-markup-annotation)
  (define-key pdf-view-mode-map (kbd "t") 'pdf-annot-add-text-annotation)
  (define-key pdf-view-mode-map (kbd "D") 'pdf-annot-delete)
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
  (pdf-tools-install)
  :custom
  (pdf-view-resize-factor 1.1)
  (pdf-annot-activate-created-annotations t)
  )

(use-package magit
  :ensure t
  :defer t
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  :after hydra
  :hydra (hydra-magit (:color blue :columns 8)
    "Magit"
    ("c" magit-status "status")
    ("C" magit-checkout "checkout")
    ("v" magit-branch-manager "branch manager")
    ("m" magit-merge "merge")
    ("l" magit-log "log")
    ("!" magit-git-command "command")
    ("$" magit-process "process"))
  )

(defun julia-fill-string ()
  "Fill a docstring, preserving newlines before and after triple quotation marks."
  (interactive)
  (if (and transient-mark-mode mark-active)
      (fill-region (region-beginning) (region-end) nil t)
    (cl-flet ((fill-if-string ()
                              (when (or (looking-at (rx "\"\"\""
                                                        (group
                                                         (*? (or (not (any "\\"))
                                                                 (seq "\\" anything))))
                                                        "\"\"\""))
                                        (looking-at (rx "\""
                                                        (group
                                                         (*? (or (not (any "\\"))
                                                                 (seq "\\" anything))))
                                                        "\"")))
                                (let ((start (match-beginning 1))
                                      (end (match-end 1)))
                                  ;; (ess-blink-region start end)
                                  (fill-region start end nil nil nil)))))
      (save-excursion
        (let ((s (syntax-ppss)))
          (when (cl-fourth s) (goto-char (cl-ninth s))))
        (fill-if-string)))))

(defun customize-julia-mode ()
  "Customize julia-mode."
  (interactive)
  ;; my customizations go here
  (local-set-key (kbd "M-q") 'julia-fill-string)
  (set-fill-column 92)
  )

(use-package julia-mode
  :ensure t
  :mode "\\.jl\\'"
  :interpreter "julia"
  :config
  (add-hook 'julia-mode-hook 'customize-julia-mode)  
  )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-includegraphics-read-file (quote LaTeX-includegraphics-read-file-relative) t)
 '(TeX-auto-local "auto" t)
 '(TeX-auto-save t t)
 '(TeX-clean-confirm t t)
 '(TeX-debug-bad-boxes t t)
 '(TeX-debug-warnings t t)
 '(TeX-electric-math (quote ("$" . "$")) t)
 '(TeX-electric-sub-and-superscript t t)
 '(TeX-error-overview-open-after-TeX-run t t)
 '(TeX-error-overview-setup (quote separate-frame) t)
 '(TeX-parse-self t t)
 '(TeX-save-query t t)
 '(TeX-source-correlate-mode t t)
 '(auto-revert-verbose nil)
 '(counsel-find-file-at-point t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-default-load-average nil)
 '(display-time-mail-file (quote none))
 '(display-time-mail-function (quote ignore))
 '(enable-recursive-minibuffers t)
 '(flycheck-gfortran-language-standard "f2008" t)
 '(flycheck-gfortran-layout (quote free) t)
 '(global-auto-revert-non-file-buffers t)
 '(ivy-display-style (quote fancy))
 '(ivy-use-selectable-prompt t)
 '(ivy-use-virtual-buffers t)
 '(package-selected-packages
   (quote
    (ivy-bibtex expand-region ace-window volatile-highlights use-package-hydra smex region-occurrences-highlighter projectile pdf-tools no-littering neotree mwim magit lsp-ui load-relative julia-mode ivy-posframe hydra helpful goto-chg gcmh flycheck dumb-jump doom-themes doom-modeline diminish counsel company-posframe company-lsp comment-dwim-2 centaur-tabs beginend auctex all-the-icons-ivy all-the-icons-dired)))
 '(pdf-annot-activate-created-annotations t t)
 '(pdf-view-resize-factor 1.1 t)
 '(recentf-auto-cleanup (quote never))
 '(recentf-exclude (quote ("/\\.git/.*\\'" "/elpa/.*\\'")))
 '(recentf-max-menu-items 25)
 '(recentf-max-saved-items 50)
 '(show-paren-style (quote expression)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
