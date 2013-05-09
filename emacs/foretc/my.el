;;HELLO

(global-unset-key "\C-xn")
(global-unset-key "\C-xp")
(global-unset-key "\C-[\C-[")
;;(global-unset-key "\C-xf")
(global-unset-key "\C-]")
(global-unset-key "\C-x\C-n")
(global-unset-key "\C-x\C-o")
(global-unset-key "\C-z")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Ctrl-c
(global-set-key "\C-c2" 'indent-rigidly-2)
(global-set-key "\C-c4" 'indent-rigidly-4)
(global-set-key "\C-c5" 'query-replace-regexp)
(global-set-key "\C-cA" 'p2-action-body)
(global-set-key "\C-ca" 'console-action-body)
(global-set-key "\C-cb" 'html-word-bold)                  ;;;HTML
(global-set-key "\C-cC" 'comment-top)
(global-set-key "\C-cc" 'comment-block)
(global-set-key "\C-cD" 'dox-class-comment)
(global-set-key "\C-cd" 'dox-comment-block)
(global-set-key "\C-cf" 'dox-comment-block-2)
(global-set-key "\C-ce" 'dox-comment-top)
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-cG" 'grep)
(global-set-key "\C-cI"    'inline-it)
(global-set-key "\C-ci"    'html-italics)	              ;;;HTML
(global-set-key "\C-ck" 'my-compile)
(global-set-key "\C-cK" 'compile)
(global-set-key "\C-cP"    'phat-seperation)
(global-set-key "\C-cp"    'html-preformat)	              ;;;HTML
(global-set-key "\C-cr" 'return-it)
(global-set-key "\C-cs" 'shell-window)
(global-set-key "\C-ct" 'set-truncate-line)
(global-set-key "\C-cT" 'unset-truncate-line)
(global-set-key "\C-cv" 'transient-mark-mode)
(global-set-key "\C-cw" 'what-line)
(global-set-key "\C-cW" 'what-cursor-position)
(global-set-key "\C-cX" 'html-start-bold)
(global-set-key "\C-cx" 'html-end-bold)
(global-set-key "\C-cY" 'html-start-italic)
(global-set-key "\C-cy" 'html-end-italic)
(global-set-key "\C-c " 'spaces-to-tab)
(global-set-key "\C-c]" 'rcs-co-buffer)
(global-set-key "\C-c[" 'rcs-ci-buffer)
(global-set-key "\C-c}" 'rcs-co-file)
(global-set-key "\C-c{" 'rcs-ci-file)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Ctrl-c Ctrl-
(global-set-key "\C-c\C-b" 'html-bold-mark-set)               ;;;HTML
(global-set-key "\C-c\C-i" 'html-italics-mark-set)            ;;;HTML
(global-set-key "\C-c\C-p" 'html-preformat-mark-set)          ;;;HTML
(global-set-key "\C-c\C-t" 'html-title-mark-set)              ;;;HTML
(global-set-key "\C-x\C-c"  nil)
(global-set-key "\C-x\C-q" 'kill-emacs) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Ctrl-c META
(global-set-key "\C-c\M-g" 'goto-char)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Ctrl-x
(global-set-key "\C-xA" 'p2-action-src)
(global-set-key "\C-x6" 'shrink-window)
(global-set-key "\C-xO"    'prev-window)
(global-set-key "\C-xp" 'pc2unix)
(global-set-key "\C-xs" 'save-buffer)
(global-set-key "\C-x'" 'next-error)
(global-set-key "\C-x." 'scroll-left)
(global-set-key "\C-x," 'escroll-right)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Ctrl-x Ctrl-
(global-set-key "\C-x\C-e" 'eval-last-sexp)
(global-set-key "\C-x\C-m" 'man)
(global-set-key "\C-x\C-o" 'other-window)
;(global-set-key "\C-xa" 'console-action-src)
;(global-set-key "\C-xC" 'kill-emacs)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; META
(global-set-key "\M-s"  'save-buffer)
(global-set-key "\M-r"  'revert-buffer)

;; automatically revert files if modified externally
(global-auto-revert-mode 1)

;; Treat 'y' or <CR> as yes, 'n' as no.
(fset 'yes-or-no-p 'y-or-n-p)
    (define-key query-replace-map [return] 'act)
    (define-key query-replace-map [?\C-m] 'act)

(setq-default fill-column 79)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;(setq indent-tabs-mode nil)
;;(setq tab-width 4)


(setq default-frame-alist '((background-color . "black")
                            (foreground-color . "gray")))