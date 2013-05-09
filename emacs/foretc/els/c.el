;;(load "c-mode")

(defconst my-c-style
  '((c-tab-always-indent        . t)
    (c-comment-only-line-offset . 4)
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
                                   (case-label        . 4)
                                   (block-open        . 0)
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
  ;; we like auto-newline and hungry-delete
  (c-toggle-auto-hungry-state 1)
  ;; keybindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, and idl-mode-map inherit from it.
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  )

(add-hook 'c-mode-hook 'my-c-mode-hook)

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

;;;;;;;;
;; cleanup after the last ansi-args-to-traditional
;;
(fset 'debug-5
      "Debug(50,\"\");\C-u3\C-b"
)

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
;; does not assume that funct name is in register 2 because the programmer
;; may change the name of the routine some day and may want to re-run this
;; routine
;;
(fset 'mark-end-of-funct
  "\M-xinitialize-registers\C-m\M-\C-e\C-r}\C-f /*  */$\C-u4\C-b\C-xg2\C-s$\C-b\C-k\C-xj\C-b"
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
(fset 'function-daniel-sep
 "\C-a\C-o//\C-u60=")

(fset 'function-comment-block-template
 "\C-a\C-o/*\C-u70*
 * Name:  
 * Description:
 * Parameters:  
 * Returns:
 */
 \C-u8\C-p\C-a")

;;;;;;;;
;; make a fancy comment block header
(fset 'make-funct-comment-header
  "\C-p\C-o\M-xfunction-comment-block-template\C-m\C-xj\C-b"
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
(fset 'dress-funct
  "\M-xprotect-ansi-funct\C-m\M-xmake-funct-comment-header\C-m\M-xdecl-funct-traditional\C-m"
)
;;;;;;;;
;; put an #ifdef and place mark of forward references
;;
(fset 'make-internal-function-header
   "#if(__STDC__)\C-[i/* forward references */
#else
#endif
")

(fset 'forward-reference-internal
  "\M-xinitialize-registers\C-m\M-<\C-s/* forward references */\C-m\C-s#else\C-a\C-o\C-xg1\C-e;\C-d\C-s#endif\C-a\C-o\C-xg1\C-s(\C-k\C-k);\C-xj\C-b"
)

(fset 'extern-function
  "\M-xinitialize-registers\C-m\C-xo\M-<\C-sextern functions here\C-m\C-s#\C-a;\C-m\C-b\C-b\C-xg1\C-s;\C-b\C-b\C-d\C-s#\C-s\C-a;\C-m\C-b\C-b\C-xg1\C-s(\C-m\M-z;);\C-x\C-s\C-xo"
)

(fset 'my-c-hdr-file
   " xz>
#ifndef _gz._ xz#define gz#if(__STDC__) /* extern functions here */
#else
#endif /* extern functions */

#endif /* gz */
")
