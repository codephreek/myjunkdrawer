(load "perl-mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mark-funct
;   set the register control-o to the orginal place where the cursor is, 
;     so that we can find our way back.
;   set the register control-a to the beginning of the subroutine
;   set the register control-e to the end of the subroutine

(fset 'mark-funct
  "\C-x/\C-o\M-\C-e\C-x/\C-e\M-\C-a\C-p\C-a\C-x/\C-a\C-xj\C-o")

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; perl-copy-funct-name-to-reg-2
;   mark key points in the subroutine, find the name and copy it to
;   register 2, and jump back to cursor's original place.

(fset 'perl-copy-funct-name-to-reg-2
    "\M-xmark-funct\C-m\C-xj\C-a\C-u4\C-f\C-@\C-e\C-xx2\C-xj\C-o")

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; perl-comment-end-of-funct
;   copy the name of the subroutine, jump to the end of the subroutine,
;   and place the name of the sub in comments at the bottom.

(fset 'perl-comment-end-of-funct
   "\M-xperl-copy-funct-name-to-reg-2\C-m\C-xj\C-e\C-r}\C-f # \C-xg2\C-e #\C-xj\C-o")

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; perl-comment-block
;   place a perl comment block at the beginning of the line in which the
;   cursor is in, and place the cursor within the block so you can start
;   commenting.

(fset 'perl-comment-block
   "\C-a\C-u75#
# 
\C-u75#
\C-p\C-p\C-e")

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; perl-funct-comment-block
;   place a comment block at the beginning of the line in which the cursor is
;   in.  This is a special comment block that has all of the pretty stuff for
;   subroutine commenting.

(fset 'perl-funct-comment-block
   "\C-a\C-u75#
# 
#   
#
# Globals:
#   
#
# Parameters:
#   
#
# Returns:
#   
#
\C-u75#
")

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; perl-dress-funct
;   dress a subroutine by commenting the end of the sub with the sub's name
;   putting a sub comment block (perl-funct-comment-block) before the sub
;   and also putting the name of the sub in this comment block.

(fset 'perl-dress-funct
  "\M-xperl-comment-end-of-funct\C-m\C-xj\C-a\C-a\C-o\M-xperl-funct-comment-block\C-m\C-a\C-u13\C-p\C-e\C-xg2\C-n\C-e")

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; perl-change-funct-name
;   if the name of a sub is changed, and already has a been commented
;   with the routines above, change the name at the end comment and
;   the beginning comment.

(fset 'perl-change-funct-name
  "\M-xperl-copy-funct-name-to-reg-2\C-m\C-xj\C-e\C-p\C-e\C-b\C-b\C-k\C-@\C-r \C-f\C-w\C-xg2\C-e #\C-r\C-m\C-y\C-m\C-k\C-xg2\C-xj\C-o")

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Key bindings
;
; ^c p - invokes perl mode
; ^c^f - dress funct
; ^c f - change funct name
; ^c^c - make simple comment block

(global-set-key "\C-cp" 'perl-mode)
(define-key perl-mode-map "\C-c\C-f" 'perl-dress-funct)
(define-key perl-mode-map "\C-cf" 'perl-change-funct-name)
(define-key perl-mode-map "\C-c\C-c" 'perl-comment-block)

(setq auto-mode-alist (append (list (cons "\\.pl$" 'perl-mode))
                              auto-mode-alist))
