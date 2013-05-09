;;;;;;;;
;; grab name of class from current line
;; create comment block and insert class name
;;
(fset 'absio-header-class-comment
      "\C-a\M-f\C-@\M-f\C-w\C-y\C-p\C-m\/**\C-m* @class \C-y\C-m* @brief\C-m*/\C-u1\C-p\C-e")


;;;;;;;;
;; comment for a method - header
;; grab name of method from current line
;; create comment block and insert method  name
;;
(fset 'absio-header-comment
      "\C-a\M-f\C-@\M-f\C-w\C-y\C-p\C-m\/**\C-m* \C-y\C-m* @brief\C-m*/\C-u1\C-p\C-e")

;;;;;;;;
;; comment for a method - header
;; grab name of method from current line
;; create comment block and insert method  name
;;
(fset 'absio-header-param
      "\C-a\M-f\C-@\M-f\C-w\C-y\C-p\C-m\/**\C-m*\C-y\C-m* @brief\C-m* @param\C-m*/\C-u2\C-p\C-e")

;;;;;;;;
;; comment for a method - header
;; grab name of method from current line
;; create comment block and insert method  name
;;
(fset 'absio-header-ret
      "\C-a\M-f\C-@\M-f\C-w\C-y\C-p\C-m\/**\C-m*\C-y\C-m* @brief\C-m* @return\C-m*/\C-u2\C-p\C-e")

;;;;;;;;
;; comment for a method - header
;; grab name of method from current line
;; create comment block and insert method  name
;;
(fset 'absio-header-param-ret
      "\C-a\M-f\C-@\M-f\C-w\C-y\C-p\C-m\/**\C-m*\C-y\C-m* @brief\C-m* @param\C-m* @return\C-m*/\C-u2\C-p\C-e")

;;;;;;;;
;;
(fset 'absio-header-method-add-param
      "\C-e\C-m* @param\C-e")



;;;;;;;;
;; put copyright info at point
;;
(fset 'absio-header-copyright
      "/\C-u76*\C-m ** Copyright (C) 2009-2011 iP3 Corporation. All rights reserved.          **
                    ** Copyright (C) 2011  Absio. All rights reserved.                        **
      \C-u76*/\C-m\C-m")

;;;;;;;;
;; header top
;;
(fset 'absio-header-top
      "/**\C-m*\C-m* @file \C-m* @author Juan Morris <juan.morris@absio.com>\C-m* @author Absio\C-m* @date yyyy-mm-dd\C-m* @brief\C-m*\C-m*/\C-m\M-xabsio-header-copyright\C-m\C-u11\C-p\C-e")

;;;;;;;;
;; My TODO
;;
(fset 'absio-todo
      "\C-a\C-m\C-u1\C-p// TODO(juan.morris@absio.com)\C-m//    - ")

;;;;;;;;
;; comment for a method - source
;;
(fset 'absio-source-comment
      "/\C-u64*\C-m*\C-m* \C-m*\C-m*/\C-m\C-u4\C-p\C-e")


