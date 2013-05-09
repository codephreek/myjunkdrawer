(load "fortran")

(fset 'fortran-comment-block
  "\C-a\C-u71C\C-m\C-u71C\C-m\C-p\C-oC\C-i")

;(define-key fortran-mode-map "\M-\C-m" 'fortran-split-line)
(define-key fortran-mode-map "\C-cc" 'fortran-comment-block)
