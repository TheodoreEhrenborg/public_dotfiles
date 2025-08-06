;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Theodore Ehrenborg"
      user-mail-address "theodore.ehrenborg@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(after! org
        (setq org-roam-directory "~/org/roam/")
        (setq org-roam-index-file "~/org/roam/index.org"))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!



;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;(setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;;(setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "sans" :size 13))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Allow me to wrap lines in Org Mode
(global-set-key (kbd "M-p") 'toggle-truncate-lines)


;; Allow Org mode to export to Markdown
(require 'ox-md)

;; Log when I finish a task
(setq org-log-done 'time)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Blacken
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(add-hook 'python-mode-hook 'blacken-mode)

;;(setq blacken-line-length 60)
;;(setq blacken-line-length 88)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; abbreviations                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default abbrev-mode t)
;; save abbreviations upon exiting xemacs
(setq save-abbrevs t)
;; set the file storing the abbreviations
(setq abbrev-file-name "~/docs/my-abbreviations.el")
;; reads the abbreviations file on startup
(quietly-read-abbrev-file)







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Window size
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 130)) ;; Looks like good doom style https://github.com/zaiste/.doom.d/blob/master/config.el



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Magit shortcut commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Font size
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;(setq doom-font (font-spec :family "SF Mono" :size 20)
;      )
;; Downloaded from https://www.cufonfonts.com/font/sf-mono
;; Good because monospace with a bold font
;;Typsnittbok = FontBook shows what fonts I can use
;; Installed SF Mono in Fontbook


;Bad Doom style:
;(set-face-attribute 'default (selected-frame) :height 200) ;; So font size is 20



;; Allow bold and italics---Not necessary with this theme,
;; but keep it around just in case I'll need it
;(after! doom-themes
;  (setq doom-themes-enable-bold t doom-themes-enable-italic t ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Org-roam
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (setq org-roam-directory "~/org/roam")

(setq org-roam-dailies-capture-templates
'(("d" "default" entry "* %?" :target
  (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n\n* Gratitude/Savoured\n 1.\n 2.\n 3."))))
;; (setq org-roam-dailies-capture-templates
;;       '(("d" "default" entry
;;          #'org-roam-capture--get-point
;;          "* %?"
;;          :file-name "daily/%<%Y-%m-%d>"
;;          :head "#+title: %<%a %Y-%m-%d>\n\n* Gratitude/Savoured\n 1.\n 2.\n 3.")))


(setq org-roam-db-update-method 'immediate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Org-capture
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-capture-templates
      '(( "n" "Todo" entry (file+headline "~/org/roam/20210409144106-inbox.org" "Tasks")
         "* TODO %?\n  %i\n  %a") ) )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; LaTeX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;(setq LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)")))
;; Gets minted to work. But this is dangerous to use on untrusted TeX documents

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Minimize window
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "s-m") 'suspend-frame)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Move files from directory to directory
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(setq dired-dwim-target t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Change buffer to rot13
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "s-y") 'toggle-obscure-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; For changing timestamps
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(global-set-key (kbd "s-t") 'org-time-stamp-inactive)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Like other-window, but in reverse
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x O") (lambda ()
                                (interactive)
                                (other-window -1)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Makes flycheck work with stable Rust, see https://github.com/brotzeit/rustic#clippy
;;;;;
;;;;; Format Rust buffer when saving
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(setq rustic-flycheck-clippy-params "--message-format=json")
;;
;;(setq rustic-format-trigger 'on-save)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Shortcut for a slightly more convenient emacs calc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-fancy-calc ()
  "Does calculation of e.g. 1+1, prints 2, and copies '1+1 = 2'"
  (interactive)
  (set 'temp-expr (read-string "Enter expression in algebraic notation: "))
  (set 'temp-result (calc-eval temp-expr))
  (message temp-result)
  (with-temp-buffer
    (insert
     (concat temp-expr " = " temp-result )
     )
    (clipboard-kill-region (point-min) (point-max)))
  )
(global-set-key (kbd "s-c") 'my-fancy-calc)
(global-set-key (kbd "M-c") 'my-fancy-calc)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; org-global-cycle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "s-b") 'org-global-cycle)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; org-dblock-update
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "s-d") 'org-dblock-update)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Make yank work
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key evil-insert-state-map (kbd "C-y") 'org-yank)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Delete all windows but one
;;;;; Help from https://tecosaur.github.io/emacs-config/config.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(after! window
        (map! :map evil-window-map
        "o"    #'delete-other-windows
        "b"    #'+ivy/switch-buffer-other-window
        "C-o"       #'doom/window-enlargen))

;;(define-key evil-normal-state-map (kbd "<leader> w C-o")
;;(define-key evil-normal-state-map (kbd "<leader> w o")





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Stop emacs from overwriting the clipboard I copied from elsewhere
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq save-interprogram-paste-before-kill t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Don't clock out when state changes to Done
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-clock-out-when-done nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Save the buffer after I clock in, so I don't have to see the time
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(advice-add 'org-clock-in :after 'save-buffer)
; [2025-06-20 Fri 16:11] This causes an error when it's in a different buffer, I think

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Org roam completion was getting annoying
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-roam-completion-everywhere nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; C-c C-x C-d should show all time, not just this year
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-clock-display-default-range 'untilnow)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Space-a clocks in
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(map! :n :leader "a" 'nil)
;; (map! :n :when org-mode-map :mode org-mode :leader "a" 'org-clock-in)
;; (map! :n :after 'org-mode
;;       :map org-mode-map
;;       :leader "a" 'org-clock-in)
;; (define-key evil-normal-state-map (kbd "<tab>") 'my/tab-jump-or-org-cycle)
;; See https://stackoverflow.com/a/41080009
(map! :n :when org-mode-map :mode org-mode :leader "a" 'my/org-clock-in)
  (defun my/org-clock-in ()
    "Clocks in on heading if I am in org mode"
    (interactive)
    (if (equal major-mode 'org-mode)
        (org-clock-in)
      (nil))
    )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Space-space looks in all known files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(map! "SPC SPC" #'projectile-find-file-in-known-projects)
;(map! "SPC SPC" nil)
;(global-set-key (kbd "SPC") #'do-something)
;(map! :leader "SPC" #'projectile-find-file-in-known-projects)

; (setq projectile-sort-order 'recently-active)
; Don't bother, it's buggy and doesn't work if I'm outside a project

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Space-space looks in all recent files or buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :leader "SPC" #'counsel-buffer-or-recentf)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; No company mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(setq company-global-modes '(not org-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Don't want to accidentally close workspaces or buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! "s-w" nil)
(map! "s-k" nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Adjust company mode delay
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq company-idle-delay 0.5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; By default (i.e. b b) I want to see all buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :leader "b B" #'+ivy/switch-workspace-buffer)
(map! :leader "b b" #'+ivy/switch-buffer)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Space-d goes to today
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :leader "d" 'org-roam-dailies-goto-today)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Space-m c o works even when not in org mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (map! :leader "m c o" 'org-clock-out)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; I want to see more recent files (Doom default seems to be 200)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; I think I need to set this first, else recentf-max-saved-items
; gets ?overwritten to the default:
(recentf-mode 1)
(setq recentf-max-saved-items 4000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Use isearch, because I'm used to ESC /not/ putting me where I started
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(evil-select-search-module 'evil-search-module 'isearch)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Swiper
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "s-f") 'counsel-grep)
(global-set-key (kbd "C-s") 'swiper)
;(evil-global-set-key 'normal  "/" 'swiper)
;(evil-global-set-key 'visual  "/" 'swiper)
(setq counsel-grep-swiper-limit 6000000)
;; (evil-global-set-key 'visual  "/" #'+evil:swiper)
;; (evil-global-set-key 'normal  "?" 'evil-search-forward)
;; (evil-global-set-key 'visual  "?" 'evil-search-forward)
;; (evil-global-set-key 'normal  "?" 'evil-search-backward)
;; (evil-global-set-key 'visual  "?" 'evil-search-backward)
;;;; Swiper ignores word order
(setq ivy-re-builders-alist
      '((swiper . ivy--regex-ignore-order)
        (t      . ivy--regex-ignore-order)))
;; (map! :n "/" #'+evil:swiper)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; No more automatically opening org roam buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq +org-roam-open-buffer-on-find-file 'nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Space-, activates ranger
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :leader "," 'ranger)
(map! :leader "." (lambda () (interactive) (ranger) (ranger-travel)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Space q q does not quit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :leader "q q" 'nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Obscure text almost perfectly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar obscure-display-table4
  (let ((table (make-display-table))
	(i 0))
      (aset table ?\s (vector (+ (% 23 26) ?a)))
    (while (< i 26)
      (aset table (+ i ?a) (vector (+ (% 23 26) ?a)))
      (aset table (+ i ?A) (vector (+ (% 23 26) ?a)))
      (setq i (1+ i))) table) )
; https://www.gnu.org/software/emacs/manual/html_node/elisp/Basic-Char-Syntax.html

;;;###autoload
(defun toggle-obscure-mode ()
  (interactive)
  (if (eq (window-display-table) obscure-display-table4)
      (set-window-display-table (selected-window) nil)
    (if (null (window-display-table))
(set-window-display-table (selected-window)
obscure-display-table4))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Shrink windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! "C-x &" 'shrink-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Move between windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :leader "k" 'evil-window-up)
(map! :leader "j" 'evil-window-down)
(map! :leader "h" 'evil-window-left)
(map! :leader "l" 'evil-window-right)
;;(map! "M-k" 'evil-window-up)
;;(map! "M-j" 'evil-window-down)
;;(map! "M-l" 'evil-window-left)
;;(map! "M-h" 'evil-window-right)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Else TeX tries to use evince, fails, and complains
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq TeX-view-program-selection '((output-pdf "Preview.app")))

;; (setq TeX-view-program-selection '((output-pdf "Evince") (output-pdf "Zathura") (output-dvi "open") (output-pdf "open") (output-html "open") (output-pdf "preview-pane")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Only turn underscores to subscripts if I export like x_{}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-export-with-sub-superscripts '{})

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; By default I want to see all buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :leader "b n" 'evil-next-buffer)
(map! :leader "b p" 'evil-prev-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Save with super-s
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "s-s") 'save-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Make keys move visually, so visual line jumping works
;;;;; https://stackoverflow.com/a/32660401
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(defun evil-next-line--check-visual-line-mode (orig-fun &rest args)
  ;(if visual-line-mode
      ;(apply 'evil-next-visual-line args)
    ;(apply orig-fun args)))
;
;(advice-add 'evil-next-line :around 'evil-next-line--check-visual-line-mode)
;
;(defun evil-previous-line--check-visual-line-mode (orig-fun &rest args)
  ;(if visual-line-mode
      ;(apply 'evil-previous-visual-line args)
    ;(apply orig-fun args)))
;
;(advice-add 'evil-previous-line :around 'evil-previous-line--check-visual-line-mode)
;
;(visual-line-mode 'relative)
;
;(global-display-line-numbers-mode 'relative)
;(global-display-line-numbers-mode 'visual)
;
;(setq global-display-line-numbers-mode 'visual)
;(setq display-line-numbers 'visual)
;(setq display-line-numbers-type 'relative)
;(setq display-line-numbers-type 'visual)
(setq display-line-numbers-type 'normal)
;(setq visual-line-mode 1)
;(setq global-visual-line-mode 1)
;
;(setq evil-respect-visual-line-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; Let's try avy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;(evil-global-set-key 'normal  (kbd "s") 'avy-goto-char-timer)
;;;;;;(after! evil-snipe
;;;;;  ;(evil-snipe-mode -1))
;;;;;;(evil-snipe-mode -1)
;;;;;;(setq avy-timeout-seconds 0.25)
;;;;;(map! :map general-override-mode-map :nv "s" 'avy-goto-char-timer)
;;;;;(setq avy-timeout-seconds 25)
;;;;;; hence I usually just press enter to select
;;;;;(setq avy-style 'words)
;;;;;(setq avy-all-windows t)
;;;;;(setq avy-single-candidate-jump t)
;;;;;;(global-set-key (kbd "C-s") 'avy-goto-char-timer)
;;;;;;(evil-global-set-key 'motion  (kbd "s") 'avy-goto-char-timer)
;;;;;;
;;;;;;(map! :after evil-snipe
;;;;;      ;(:map evil-snipe-local-mode-map
;;;;;       ;:m "s" nil
;;;;;       ;:m "S" nil))

;(with-eval-after-load 'evil-maps
  ;(define-key evil-motion-state-map (kbd "s") 'avy-goto-char-timer))
;(counsel-fzf "" nil "echo hi | fzf")

(setq exec-path (cons "/home/theo/.nix-profile/bin" exec-path))


; Don't turn on battery mode---it makes org-agenda freeze when I switch
; to a different workspace when org-agenda is full-screen
;(display-battery-mode 1)

(defun my-time-stamp ()
  ; Thanks to https://stackoverflow.com/a/12829884
  (interactive)
  (let ((current-prefix-arg 1)) ;; emulate C-u
    (call-interactively 'org-time-stamp-inactive)
    )
  )
(map! :leader "T" 'my-time-stamp)
;(counsel-fzf "" "..")




;; In ses mode, bind j to evil-next-line
(map! :after ses
      :map ses-mode-print-map
      "j" 'evil-next-line
      )

; In org mode, also enable literate calc minor mode
;(add-hook 'org-mode-hook 'literate-calc-minor-mode)
; On second thought, this made
; org mode noticeably slower for big files (~4.4k lines)
; So only activate it for small files
;(setq literate-calc-mode-max-buffer-size 2000)

; [2025-02-16 Sun 16:24] On third thought, let's leave it off by default
; I think it might cause hangs for ?large buffers, with a message like:
; Error running timer ‘literate-calc-eval-buffer’: (error "Selecting deleted buffer")


(setq org-agenda-prefix-format
        '((agenda . " %i %-12:c%?-12t%-6e% s")
        (todo . " %i %-12:c")
        (tags . " %i %-12:c")
        (search . " %i %-12:c")))

(defun life 'nil)
(defun life-mode 'nil)
(defun blackbox 'nil)
(defun dunnet 'nil)


(map! :n :when org-mode-map :mode org-mode "M-r" 'org-meta-return)


(after! magit
  (map! :n :when magit-status-mode-map :mode magit-mode "C-c ^ a" 'magit-smerge-keep-all))

; Make comments more visible
; See https://github.com/doomemacs/themes/issues/528 and https://www.benkuhn.net/syntax/
(custom-set-faces!
  `(font-lock-comment-face :foreground ,(doom-lighten 'cyan -.0))
  `(font-lock-doc-face     :foreground ,(doom-lighten 'cyan .0)))

; Faster reloading of org agenda
(setq org-agenda-sticky t)


(setq org-pretty-entities 1)


(setq calc-multiplication-has-precedence 'nil)


(map! :n :when org-mode-map :mode org-mode :leader "e l" 'literate-calc-eval-line)
(map! :n :when org-mode-map :mode org-mode :leader "e b" 'literate-calc-eval-buffer)

; Use org encryption
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
(setq org-crypt-key "Theodore Ehrenborg (2024-03-15) <theodore.ehrenborg@gmail.com>")
; So I don't accidentally save plaintext messages:
; (setq auto-save-default nil)
; [2025-06-19 Thu 17:59] But I think the threat of losing timesheets is worse
; Another solution is to get the "save when clock in" function working even on other buffers.
; But this wouldn't solve the problem of lost notes
; I maybe should restrict this just to org files because of code formatters/etc



; TODO This after statement doesn't work
;(after! lsp
;  (map! :n :mode lsp-mode :leader "c r" 'lsp-rename))


; https://discourse.julialang.org/t/emacs-lsp-mode/53427/6
(after! julia-mode
  (add-hook! 'julia-mode-hook
    (setq-local lsp-enable-folding t
                lsp-folding-range-limit 100)))



; https://www.reddit.com/r/emacs/comments/7wsnoi/using_countdown_timers_for_alerts/
(defun show-msg-after-timer ()
  "Show a message after timer expires. Based on run-at-time and can understand time like it can."
  (interactive)
  (let* ((msg-to-show (read-string "Enter msg to show: "))
         (time-duration (read-string "Time? ")))
    (message time-duration)
    (run-at-time time-duration nil #'message-box msg-to-show)))

(setq bidi-display-reordering 'nil)

(setq-default bidi-paragraph-direction 'left-to-right)


(defalias 'move-todo
   (kmacro "C-x o Y SPC m t d j C-x o O * S-SPC <escape> p 0"))





; https://emacs.stackexchange.com/a/46059/
(defface my-read-only '((default . (:background "beige")))
  "Face for `my-read-only-region'")

(defun my-read-only-region (begin end)
  "Make the marked region read-only.  See also `my-writeable-region'.

Read-only text is given the face `my-read-only'."
  (interactive "r")
  (let ((inhibit-read-only t))
    (with-silent-modifications
      (add-text-properties begin end '(read-only t))
      (let ((overlay (make-overlay begin end)))
        (overlay-put overlay 'my-type 'read-only)
        (overlay-put overlay 'face 'my-read-only)))))

(defun my-writeable-region (begin end)
  "Make the marked region writeable.  See also `my-read-only-region'."
  (interactive "r")
  (let ((inhibit-read-only t))
    (with-silent-modifications
      (remove-text-properties begin end '(read-only t))
      (remove-overlays begin end 'my-type 'read-only))))

(defun pipe-buffer-through-calc ()
  "Pipe the current buffer through the calculator and replace with output."
  (interactive)
  (let ((original-window-states (mapcar
                                (lambda (w)
                                  (list w (window-point w) (window-start w)))
                                (get-buffer-window-list))))
    (shell-command-on-region (point-min) (point-max)
                           "/home/theo/projects/macmahon/target/release/rust_calculator" nil t)
    (dolist (win-stt original-window-states)
      (set-window-point (car win-stt) (nth 1 win-stt))
      (set-window-start (car win-stt) (nth 2 win-stt)))))



(defun macmahon ()
  "Placeholder for macmahon functionality."
  (interactive)
  (message "MacMahon function called")
  (pipe-buffer-through-calc)
  )


(define-minor-mode macmahon-mode
  "TODO docs"
  :lighter " MacMahon"
  (if macmahon-mode
        (add-hook 'before-save-hook 'macmahon nil t)
    (remove-hook 'before-save-hook 'macmahon t)))


(setq flycheck-dafny-executable "/nix/store/frfz00xdrc3bhwdcfh6cnik8m7xygbw3-Dafny-4.10.0/bin/dafny")
(setq dafny-verification-backend 'cli)



(custom-set-variables
  '(auto-save-visited-mode t))

(defvar auto-save-visited-restore-timer nil
  "Timer to restore auto-save-visited-mode.")

(defun disable-auto-save-visited-for-hour ()
  "Disable auto-save-visited-mode for an hour, then re-enable it."
  (interactive)
  (if auto-save-visited-mode
      (progn
        (auto-save-visited-mode -1)
        (message "Disabled auto-save-visited-mode for one hour")
        ;; Cancel existing timer if there is one
        (when auto-save-visited-restore-timer
          (cancel-timer auto-save-visited-restore-timer)
          (setq auto-save-visited-restore-timer nil))
        ;; Set new timer
        (setq auto-save-visited-restore-timer
              (run-at-time "1 hour" nil
                          (lambda ()
                            (auto-save-visited-mode 1)
                            (message "Re-enabled auto-save-visited-mode")
                            (setq auto-save-visited-restore-timer nil)))))
    (message "auto-save-visited-mode is already disabled")))

(defun cancel-auto-save-visited-restore ()
  "Cancel scheduled restoration of auto-save-visited-mode."
  (interactive)
  (if auto-save-visited-restore-timer
      (progn
        (cancel-timer auto-save-visited-restore-timer)
        (setq auto-save-visited-restore-timer nil)
        (message "Cancelled scheduled restoration of auto-save-visited-mode"))
    (message "No scheduled restoration to cancel")))

;; In Verus, highlight assume like in Dafny mode
(add-hook 'rust-mode-hook
          (lambda ()
            (font-lock-add-keywords nil
                                   '(("\\bassume\\b" 0
                                      (list 'face '(:background "red" :foreground "white")) t)))))
