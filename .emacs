;;; Emacs Load Path
(setq load-path (cons "~/.emacs.d" load-path))

;;; Make all "yes or no" prompts show "y or n" instead
(fset 'lisp-eval-last-sexp 'eval-last-sexp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					; Gambit Scheme.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if nil
    (progn 
	    (setq load-path (cons "/Library/Gambit-C/v4.4.4/share/emacs/site-lisp" load-path))
	    (autoload 'gambit-inferior-mode "gambit" "Hook Gambit mode into cmuscheme.")
	    (autoload 'gambit-mode "gambit" "Hook Gambit mode into scheme.")
	    (add-hook 'inferior-scheme-mode-hook (function gambit-inferior-mode))
	    (add-hook 'scheme-mode-hook (function gambit-mode))
	    
	    (setq scheme-program-name "/usr/bin/gsc -:d-") ; if gsi not in executable path
	    (setq gambit-highlight-color "gray") ; if you don't like the default
	    (setq gambit-repl-command-prefix "\e") ; if you want M-c, M-s, etc
	    (require 'gambit)

))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	    
;; clojure mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	    
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/clojure-mode-1.7.1"))
(require 'clojure-mode-autoloads)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/clojure-test-mode-1.4"))
(require 'clojure-test-mode-autoloads)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	    
;; slime
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	    
;(setq inferior-lisp-program "/Users/smcho/bin/clojure")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/slime-20100404"))
(require 'slime-autoloads)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/slime-repl-20100404"))
(require 'slime-repl-autoloads)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	    
(if t
    (progn 
	    (setq inferior-lisp-program (expand-file-name "~/bin/clj"))
	    (require 'clojure-mode)
	    (setq auto-mode-alist
		  (cons '("\\.clj$" . clojure-mode)
			auto-mode-alist))
	    
	    (add-hook 'clojure-mode-hook
		      '(lambda ()
			 (define-key clojure-mode-map "\C-c\C-e" 'lisp-eval-last-sexp)))
	    ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	    
;; Howto install package manager 
;;[wa] from http://tromey.com/elpa/install.html
(if nil
    (progn
	    (let ((buffer (url-retrieve-synchronously
			   "http://tromey.com/elpa/package-install.el")))
	      (save-excursion
		(set-buffer buffer)
		(goto-char (point-min))
		(re-search-forward "^$" nil 'move)
		(eval-region (point) (point-max))
		(kill-buffer (current-buffer))))
))


;;
;;
;;


;;(require 'clojure-mode)

;; Hash key because of British keyboard.

(global-set-key "\M-3" "#")

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.

;;[wa] from http://tromey.com/elpa/install.html
;; Once you have installed the package manager, type M-x package-list-packages.
;; Type r in the package menu buffer to update the list of packages available from the server. 
;; If you want a particular package, type i next to its name to mark it for installation, and then x to download and install it.

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


;;[wa] see  http://www.emacswiki.org/emacs/InteractivelyDoThings

(if nil
    (progn (
	    (require 'ido)
	    (ido-mode t)
	    (setq ido-enable-flex-matching t) ;; enable fuzzy matching
	    )))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))



	    
(global-set-key "\C-c\C-k" 'compile) ; formerly undef (text-mode)

;; (setq c-default-style "gnu")
;; (add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))

;; http://www.emacswiki.org/emacs/IndentingC
(setq-default c-indent-tabs-mode t     ; Pressing TAB should cause indentation
			  c-indent-level 4         ; A TAB is equivilent to four spaces
			  c-argdecl-indent 0       ; Do not indent argument decl's extra
			  c-tab-always-indent t
			  backward-delete-function nil) ; DO NOT expand tabs when deleting
(c-add-style "my-c-style" '((c-continued-statement-offset 4))) ; If a statement continues on the next line, indent the continuation by 4
(defun my-c-mode-hook ()
  (c-set-style "my-c-style")
  (c-set-offset 'substatement-open '0) ; brackets 
should be at same indentation level as the statements they open
  (c-set-offset 'inline-open '+)
  (c-set-offset 'block-open '+)
  (c-set-offset 'brace-list-open '+)   ; all "opens" should be indented by the c-indent-level
  (c-set-offset 'case-label '+))       ; indent case labels by c-indent-level, too
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)