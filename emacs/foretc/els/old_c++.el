(fset 'my-c-hdr-file
   "/**********************************************************************\C-m * Modular Integrated Technologies, Inc.\C-m * Matthew Au\C-m * <date>\C-m *\C-m * <class>.h\C-m *   \C-m **********************************************************************/\C-m\C-m#ifndef _<class>_h_\C-m#define _<class>_h_\C-m\C-mclass <class> {\C-m  public:\C-m      <class>();\C-m\C-m  private:\C-m};\C-m\C-m#endif /* <class> */\C-m\C-u3\C-p\C-a\C-d\C-d\C-p\C-d\C-d\C-u13\C-p\C-u3\C-f")

(defconst my-c++-style
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
  "My C++ Programming Style")

;; Customizations for all of c-mode, c++-mode, and objc-mode
(defun my-c++-mode-hook ()
  ;; add my personal style and set it for the current buffer
  (c-add-style "PERSONAL" my-c++-style t)
  ;; offset customizations not in my-c-style
  (c-set-offset 'member-init-intro '++)
  ;; other customizations
  (setq c-basic-offset 2)
  
  ;; we like auto-newline and hungry-delete
  (c-toggle-hungry-state 1)
  ;; keybindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, and idl-mode-map inherit from it.
  ;;(define-key c-mode-base-map "\C-m" 'newline-and-indent)
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
