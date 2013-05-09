;;(load "c-mode")
;;
;; marking beginning of funct may be a bad idea.  some of the others that
;; assume it is set will break or do unusual things if not set right
;;
;; registers:
;;  ^o - original place
;;  ^b - beginning of function declaration
;;  ^a - place to put next arg
;;  ^d - place of next arg declaration
;;   1 - ansi function declaration
;;   2 - function name
;;   3 - argument list
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initialize regs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;
;; marks original spot (saves cursor loc in ^o register
;; marks beginning of funct decl (saves loc of first char in ^b register)
;;
(fset 'mark-beginning-of-funct-decl
  "\C-x/\C-o\C-a\C-x/\C-b"
)

;;;;;;;;;;
;; saves ansi funct decl in register 1
;;
(fset 'save-funct-decl
  "\C-xj\C-b\C-@\M-xisearch-forward-regexp\C-m[{#]\C-b\C-xx1"
)

;;;;;;;;
;; saves funct name in register 2
;;
(fset 'save-funct-name
  "\C-xj\C-b\C-s(\C-b\C-@\M-xisearch-backward-regexp\C-m[^a-zA-Z_0-9]\C-f\C-xx2"
)

;;;;;;;;
;; save argument list in register 3
;;
(fset 'save-arg-list
  "\C-xj\C-b\C-s(\C-x/\C-f\M-xisearch-forward-regexp\C-m[{#]\C-b\C-r)\C-@\C-xj\C-f\C-xx3"
)

;;;;;;;;
;; initialize all regs
;;
(fset 'initialize-registers
  "\M-xmark-beginning-of-funct-decl\C-m\M-xsave-funct-decl\C-m\M-xsave-funct-name\C-m\M-xsave-arg-list\C-m\C-xj\C-b"
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;
;; copies function name to bottom of the function and places it in comments
;;
(fset 'mark-end-of-funct
  "\M-\C-e\C-r}\C-f /*  */$\C-u4\C-b\C-xg2\C-s$\C-b\C-k\C-xj\C-b"
)

;;;;;;;;
;; places #if(__STDC__) around the ansi part of the funct decl
;;
(fset 'protect-ansi-funct
  "\M-x\initialize-registers\C-m#if(__STDC__)\C-m\C-s(\C-b\M-xisearch-forward-regexp\C-m)\C-q\C-j*{\C-b\C-@#else\C-m#endif\C-m\C-xj\C-b\C-n\C-x/\C-b"
)

;;;;;;;;
;; fancy function comment block template
;;
(fset 'function-comment-block-template
   "/*\C-u75*
 * \C-xg2\C-e
 *
 *
 * Globals:
 *
 *
 * Parameters:

 *
 * Returns:
 *
 \C-u75**/
\C-u5\C-p *   \C-xg3")

;;;;;;;;
;; make a fancy comment block header
(fset 'make-funct-comment-header
  "\C-o\M-xfunction-comment-block-template\C-m\C-xj\C-b"
)

;;;;;;;;
;; declare a function as traditional
;; the point where I go back and forward I want to set a reg to point to the
;; loc of the first arg so I can write a macro to tear up the line
;; must do protect-ansi-funct before running this one
;;
;; registers:
;;   ^a - place to put next arg
;;   ^d - place of next arg declaration
;;
(fset 'decl-funct-traditional
  "\M-xmark-end-of-funct\C-m\C-s#else\C-f\C-@\C-s#endif\C-a\C-w\C-xg1\C-s(\C-k\C-x/\C-a)\C-e\C-m,\C-b\C-xg3\C-x/\C-d"
)

;;;;;;;;
;; converts ansi args into traditional
;; registers:
;;   ^a - place to put next arg
;;   ^d - place of next arg declaration
;;
;; must run decl-funct-traditional first so that registers ^a & ^d get
;; initialized
;;
(fset 'ansi-args-to-traditional
  "\C-xj\C-d\C-s,\C-x/\C-d\C-b\C-d;\C-i\C-m\C-xj\C-d\M-xisearch-backward-regexp\C-m[A-Za-z0-9_]\C-f\M-xisearch-backward-regexp\C-m[^A-Za-z0-9_]\C-f\C-xx4\C-xj\C-a,\C-b\C-xg4\C-s,\C-x/\C-a"
)

;;;;;;;;
;; cleanup after the last ansi-args-to-traditional
;;
(fset 'cleanup-ansi-args-to-traditional
  "\C-xj\C-a\C-s)\C-b\C-b\C-d\C-s#endif\C-a\C-?\C-x\C-o"
)

;;;;;;;;
;; put big header, comment bottom of funct, make it ansi & traditional, and
;; initialize for ansi-args-to-traditional
;;
(fset 'dress-funct-ansi-and-traditional
  "\M-xprotect-ansi-funct\C-m\C-p\M-xmake-funct-comment-header\C-m\M-xdecl-funct-traditional\C-m"
)

(fset 'dress-funct
  "\M-xinitialize-registers\C-m\M-xmake-funct-comment-header\C-m\M-xmark-end-of-funct\C-m\C-xj\C-o\M-\C-f\C-a"
)

;;;;;;;;
;; put an #ifdef and place mark of forward references
;;
(fset 'make-internal-function-header
   "#if(__STDC__)\C-[i/* forward references */
#else
#endif
")

;;;;;;;;
;; declare funct as a forward reference
(fset 'forward-reference-internal
  "\M-xinitialize-registers\C-m\M-<\C-s/* forward references */\C-m\C-s#else\C-a\C-o\C-xg1\C-e;\C-d\C-s#endif\C-a\C-o\C-xg1\C-s(\C-k\C-k);\C-xj\C-b"
)

;;(fset 'extern-function
;;  "\M-xinitialize-registers\C-m\C-xo\M-<\C-sextern functions here\C-m\C-s#\C-a;\C-m\C-b\C-b\C-xg1\C-s;\C-b\C-b\C-d\C-s#\C-s\C-a;\C-m\C-b\C-b\C-xg1\C-s(\C-m\M-z;);\C-x\C-s\C-xo"
;;)

(fset 'my-c-hdr-file
   " xz>
#ifndef _gz._ xz#define gz#if(__STDC__) /* extern functions here */
#else
#endif /* extern functions */

#endif /* gz */
")

(fset 'file-comment-block
   "/**********************************************************************
 * Modular Integrated Technologies, Inc.
 * Matthew Au
 * <date>
 *
 * $Id$
 *   
 **********************************************************************/
\C-u5\C-p\C-u3\C-f")

(fset 'comment-block
   "/****************************************************************************
 * 
 ***************************************************************************/
\C-p\C-p\C-e")

(fset 'comment-line
   "\C-a\C-i/*\C-e*/\C-n")

(fset 'uncomment-line
   "\C-a\C-i\C-d\C-d\C-e\C-?\C-?\C-n")

(fset 'comment-continuation
   "\C-a\C-i*\C-i \C-n")

(fset 'extern-function
   "\C-a\C-@\C-s{\C-a\C-xx0\C-xo\C-[>\C-r#endif\C-oextern ;\C-b\C-xg0\C-s;\C-b\C-b\C-d\C-x\C-s\C-xo")

;(defun match-paren (arg)
;  "Go to the matching parenthesis if on parenthesis otherwise insert %."
;  (interactive "p")
;  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;	(t (self-insert-command (or arg 1)))))
;
;(fset 'match-paren
;  "\C-q%")


(fset 'add-line-numbers
   [?0 left down ?1 left down ?2 left down ?3 left down ?4 left down ?5 left down ?6 left down ?7 left down ?8 left down ?9])

(fset 'indent-file
   [?\C-  ?\C-[ ?> ?\C-\M-\\ ?\C-[ ?< ?\C-x ?\C-s])

(fset 'indent-dir
   [return ?\M-x ?i ?n ?d ?e ?n ?t ?- ?f ?i ?l ?e return ?\C-x ?k return ?\C-n])

(fset 'add-dar-tag
   [?\C-n ?\C-o ?/ ?/ ?  ?D ?a ?r ?  ?S ?c ?o ?t ?t return ?/ ?/ return ?/ ?/ ?  ?$ ?I ?d ?$ ?\C-x ?\C-s])

(fset 'add-rcs-id-tag
   "/*\C-m * $Id$\C-m */\C-m\C-m")

(fset 'add-dar-tag-dir
   [return ?\M-x ?a ?d ?d ?  ?d ?a ?r return ?\C-x ?k return ?\C-n])

(defconst my-c-style
  '((c-tab-always-indent        . t)
    (c-comment-only-line-offset . 2)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                   (substatement-open . 0)
                                   (case-label        . 2)
                                   (block-open        . -2)
                                   (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . t)
    )
  "My C Programming Style")

;; Customizations for all of c-mode, c++-mode, and objc-mode
(defun my-c-mode-hook ()
  ;; add my personal style and set it for the current buffer
  (c-add-style "PERSONAL" my-c-style t)
  ;; offset customizations not in my-c-style
  (c-set-offset 'member-init-intro '++)
  ;; other customizations
  (setq c-basic-offset 2)
  ;; we like hungry-delete
  (c-toggle-hungry-state 1)
  ;; keybindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, and idl-mode-map inherit from it.
  (define-key c-mode-base-map "\C-m"     'newline-and-indent)
  (define-key c-mode-base-map "\C-cf"    'dress-funct)
  (define-key c-mode-base-map "\C-c\C-d" 'ansi-args-to-traditional)
  (define-key c-mode-base-map "\C-cd"    'cleanup-ansi-args-to-traditional)
  (define-key c-mode-base-map "\C-cD"    'decl-funct-traditional)
  (define-key c-mode-base-map "\C-ci"    'forward-reference-internal)
  (define-key c-mode-base-map "\C-ci"    'internal-function)
  (define-key c-mode-base-map "\C-c\C-c" 'comment-continuation)
  (define-key c-mode-base-map "\C-cc"    'comment-block)
  (define-key c-mode-base-map "\C-cF"    'file-comment-block)
  (define-key c-mode-base-map "\C-c\C-l" 'comment-line)
  (define-key c-mode-base-map "\C-cl"    'uncomment-line)
  (define-key c-mode-base-map "\C-ch"    'my-c-hdr-file)
  (define-key c-mode-base-map "\C-ce"    'extern-function)
  (define-key c-mode-base-map "\C-cI"    'make-internal-function-header)
  (define-key c-mode-base-map "\C-ca"    'indented-text-mode)
  (define-key c-mode-base-map "\C-cu"    'my-untabify)
  (define-key c-mode-base-map "\C-c\\"   'my-align)
  )

(add-hook 'c-mode-hook 'my-c-mode-hook)

;(setq c-argdecl-indent 0)
;(setq c-indent-level 4)
;(setq c-continued-statement-offset 0)

;(defun turn-off-indent-tabs-mode()
;  "Unconditionally turn off indent-tabs-mode"
;   (setq indent-tabs-mode nil)
;)

;(add-hook 'c-mode-hook 'turn-off-indent-tabs-mode)
