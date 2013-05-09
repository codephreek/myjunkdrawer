(defconst my-java-style
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
                                   ;defun-close-semi
                                   ))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                   (substatement-open . 0)
                                   (statement-cont    . 0)
                                   (case-label        . 4)
                                   (block-open        . 0)
				   (inline-open       . 0)
				   (comment-intro     . 0)
                                   (knr-argdecl-intro . -)))
    
    (c-echo-syntactic-information-p . t)
    )
  "My Java Programming Style")

;; Customizations for all of c-mode, c++-mode, and objc-mode
(defun my-java-mode-hook ()
  ;; add my personal style and set it for the current buffer
  (c-add-style "PERSONAL" my-java-style t)
  ;; offset customizations not in my-c-style
  (c-set-offset 'member-init-intro '++)
  ;; other customizations
  
  ;; we like auto-newline and hungry-delete
  (c-toggle-hungry-state 1)
  ;; keybindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, and idl-mode-map inherit from it.
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  )

(add-hook 'java-mode-hook 'my-java-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'java-kl
"\C-k\)"
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'java-serial
"/** @serial  */\C-u15\C-b"
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-indent-tmpl
  "\C-i\C-n"
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-println
  "System.out.println(\"\");\C-u3\C-b"
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'java-debug-writeln
  "Debug.writeln(\"\");\C-u3\C-b"
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'java-debug-write
  "Debug.write(\"\");\C-u3\C-b"
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'java-debug-tabln
  "Debug.tabln(\"\");\C-u3\C-b"
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'java-debug-tab
  "Debug.tab(\"\");\C-u3\C-b"
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'java-debug-divider
  "Debug.divider(\"\");\C-u3\C-b"
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'java-link
  "{@link #}.\C-u2\C-b"
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-exception-tmpl
  "/* $class.java */
/**
 * @author Modular Integrated Technologies, Inc.
 * @author Juan Morris
 *
 * $description
 *
 * @version $Id$
 *
 */

package com.modit;

import java.lang.*;

/*\C-u70*
 * $class
 */
/**
 * $description
 */

public class $class extends Exception
{
    /*\C-u70*
     * $class
     */
    /**
     * The $class class provides information on $describe errors.
     *
     * @param     msg a brief description of the error.
     *
     */
    
    public $class(String msg)
    {
	super(msg);
    } /* $class */
} /* $class */
")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-class-tmpl
  "/* $class.java */
/**
 * @author Modular Integrated Technologies, Inc.
 * @author Juan Morris
 *
 * $description
 *
 * @version $Id$
 *
 */

package com.modit;

import java.lang.*;
import java.io.*;

/*\C-u70*
 * $class
 */
/**
 * $description
 */

public class $class
{

 /*\C-u70*
 * $class
 */
/**
 * $description
 *
 * @param     name description
 * 
 */

public $class()
{
}/* $class */

} /* $class */
\M-<")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-comment-block
  "\C-a\C-o/*\C-u70*
 * $method
 */
/**
 * $description
 *
 * @param     name description
 * 
 * @return    description
 *
 * @exception name description
 */
\C-u12\C-p\C-a")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-method-tmpl
  "\C-a\C-o/*\C-u70*
 * $method
 */
/**
 * $description
 *
 * @param     name description
 * 
 * @return    description
 *
 * @exception name description
 */

public $retType $method()
    throws	
{
} /* $method */
\C-u17\C-p\C-a")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-ctor-tmpl
  "\C-a\C-o/*\C-u70*
 * $method
 */
/**
 * $description
 *
 * @param     name description
 * 
 */

public void $method()
{
} /* $method */
\C-u13\C-p\C-a")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-set-tmpl
  "\C-a\C-o/*\C-u70*
 * $method
 */
/**
 * $description
 *
 * @param     name description
 * 
 */

public void $method()
{
} /* $method */
\C-u13\C-p\C-a")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-get-tmpl
  "\C-a\C-o/*\C-u70*
 * $method
 */
/**
 * $description
 *
 * @return     name description
 * 
 */

public $retType $method()
{
return();
} /* $method */
\C-u13\C-p\C-a")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-bu-tmpl
 "\C-a\C-o/*\C-u70*
 * setmethod
 */
/**
 * $description
 *
 * @param     name description
 * 
 */

public void setmethod()
{
} /* setmethod */

 /*\C-u70*
 * getmethod  
 */ 
/** 
 * $description
 * 
 *  @return     name description
 *  
 */ 

public $retType getmethod() 
{ 
 return();
 } /* getmethod */ 
 \C-u27\C-p\C-a")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-bv-tmpl
 "\C-a\C-o/*\C-u70*
 * setmethod
 */
/**
 * $description
 *
 * @param     name description
 * 
 */

private void setmethod()
{
} /* setmethod */

 /*\C-u70*
 * getmethod  
 */ 
/** 
 * $description
 * 
 *  @return     name description
 *  
 */ 

private $retType getmethod() 
{ 
 return();
 } /* getmethod */ 
 \C-u27\C-p\C-a")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-main-tmpl
  "\C-a\C-o/*\C-u70*
 * main
 */
/**
 * $description
 *
 * @param     name description
 * 
 * @return    description
 *
 * @exception name description
 */

public static void main(String argv[])
{
} /* main */
\C-u16\C-p\C-a")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-finalize-tmpl
"\C-a\C-o/*\C-u70*
 * finalize
 */
/**
 * $description
 *
 * @param     name description
 * 
 * @return    description
 *
 * @exception name description
 */

protected void finalize()
    throws	Throwable
{
} /* finalize */
\C-u16\C-p\C-a")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-field-integer
 "
/** Description
* @see #reference name
*/ 
private int fld;\C-u5\C-b"
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'java-field-string
"
/** Description
* @see #reference name
*/ 
private String fld;\C-u5\C-b"
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'java-field-generic
"
/** Description
* @see #reference name
*/ 
private $type fld;\C-u5\C-b"
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'java-makefile-tmpl
"# Modular Integrated Technologies, Inc.
# Juan Morris
# $Id$
#
.SUFFIXES:	.java .class
.java.class:
	  $(JAVAC) $(JFLAGS) $<

JDK		=	/usr/java

JAVAC		=	$(JDK)/bin/javac

JFLAGS		=	-d $(CLASSDIR)

# NOTE for CLASSIR to work right it must be defined in CLASSPATH, which must
#      be set before running 'make'.
CLASSDIR	=	/rridge/java

DOMAIN	=	com/rridge

# Examples of directories where classes go
#UTIL	= 	$(CLASSDIR)/$(DOMAIN)/util
#TESTER	=	$(CLASSDIR)/$(DOMAIN)/tester

CLASSES	=	

all:	$(CLASSES)

##################################################

clean: 
	 -rm -f *.class $(UTIL)/*.class $(TESTER)/*.class
	 -rm -f *~
")




