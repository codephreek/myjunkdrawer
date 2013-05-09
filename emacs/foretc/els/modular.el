;;;;;;;;;;;;c++


;(fset 'get-classname
;     "\C-a\C-@\C-e\C-w")

;(fset 'top-header
;      "/**********************************************************************\C-m * Modular Integrated Technologies Inc.\C-m * Juan Morris\C-m * <date>\C-m *\C-m * \C-y.h\C-m * \C-m * $Id:$   \C-m **********************************************************************/\C-m")

;(fset 'defines-class
;      "#ifndef _\C-y_h\C-a\C-u9\C-f\M-l\C-e\C-m#define _\C-y_h\C-a\C-u9\C-f\M-l\C-e\C-m\C-m")

;(fset 'misc-includes
;      "\C-m\M-xfucking-pragmas\C-m")

;(fset 'class-top
;      "\C-mnamespace Modit\C-m{\C-mclass \C-y \C-m{")

;(fset 'public-defs
;      "\C-npublic:\C-n\C-y();\C-nvirtual ~\C-y();")

;(fset 'private-defs
;      "\C-nprivate:\C-n")

;(fset 'make-header-file
;      "\M-xget-classname\C-m\M-xdefines-class\C-m\M-xmisc-includes\C-m\M-xclass-top\C-m\M-xpublic-defs\C-m\C-m\M-xprivate-defs\C-m};\C-m}\C-m#endif\M-<\M-@\M->\M-xindent-region")

;(fset 'open-cpp-file
;      "\M-xfind-file\C-m\C-y.cpp")

;(fset 'make-cpp-header
;      "\M-<\M-xtop-header\C-m\M-<\C-u5\C-n\C-e\C-b\C-b\C-d\C-d.cpp\C-e\M->\C-m\C-m")

;(fset 'add-includes-cpp
;      "\M-xfucking-pragmas\C-m#include \"\C-y.h\"\C-m\C-musing namespace Modit;\C-m\C-m")

;(fset 'const-cpp
;      "/****************************************************************************\C-m*Constructor\C-m***************************************************************************/\C-m\C-y::\C-y()\C-m{\C-m}\C-m\C-m")

;(fset 'deconst-cpp
;      "/****************************************************************************\C-m*Destructor\C-m***************************************************************************/\C-m\C-y::~\C-y()\C-m{\C-m}"
;      )
;
;(fset 'const-deconst-cpp
;      "\M-xconst-cpp\C-m\M-xdeconst-cpp"
;      )
;
;(fset 'make-cpp-file
;      "\M-xopen-cpp-file\C-m\M-xmake-cpp-header\C-m\M-xadd-includes-cpp\C-m\M-xconst-deconst-cpp"
;      )
;
;(fset 'build-a-class
;      "\M-xmake-header-file\C-m\C-x\C-s\M-xmake-cpp-file\C-m\C-x\C-s\M-xfind-file\C-m\C-y.h\C-m\M-<\C-x2\C-xo\M-xfind-file\C-m\C-y.cpp\C-m\M-<"
;      )
;
;(fset 'inline-it
;      "\C-a\C-iinline \C-e {};\C-e\C-b\C-b"
;      )




;;;;;;;;;;;;c
;(fset 'fucking-pragmas
;  "#pragma warning(disable:4786)\C-n#pragma warning(disable:4503)\C-n#pragma warning(disable:87)")
;


;(fset 'comment-top
;      "/** $Id$*/\C-m\C-m/**\C-m* Ridge Software Technology Associates LLC.\C-m* Juan Morris\C-m* Date://\C-m* \C-m*\C-m\*/\C-m\C-u4\C-p\C-e\C-u2\C-b")
;
;(fset 'insert-p2action
;      "P2Action\C-m")
;(fset 'insert-consoleaction
;      "ConsoleAction\C-m")
;(fset 'insert-class-comment
;      "/**\C-m* @class $\C-m* @author Juan Morris\C-m* @author Ridge Software Technology Associates LLC.\C-m* @brief\C-m*\C-m@bug as of \C-m*/")
;(fset 'insert-class-line
;      "class $ : public \M-xinsert-p2action")
;
;(fset 'first-const-p2action
;      "/**\C-m* @if pa\C-m* Constructor\C-m* @param *cmd\C-m* @param &description\C-m* @param &params\C-m* @endif\C-m*/\C-m$(const char *cmd, const string &description,\C-mconst Parameters &params=NullParameters());\C-m")
;(fset 'second-const-p2action
;      "/**\C-m* @if pa\C-m* Constructor\C-m* @param &cmds\C-m* @param &description\C-m* @param &params\C-m* @endif\C-m*/\C-m$(const CmdAlias &cmds, const string &description,\C-mconst Parameters &params=NullParameters());\C-m")
;
;(fset 'third-const-p2action
;      "/**\C-m* @if pa\C-m* Constructor\C-m* @param *cmd\C-m* @endif\C-m*/\C-m$(CXCommand *cmd=MULL);\C-m")
;
;(fset 'destructor-p2action
;      "/**\C-m* @if pa\C-m* Destructor\C-m* @endif\C-m*/\C-mvirtual ~$();\C-m")
;
;(fset 'itor-p2action
;      "/**\C-m* @if pa\C-m* Action Instantiator\C-m* @endif\C-m*/\C-mACTION_ITOR($);\C-m")
;
;(fset 'action-p2action
;      "/**\C-m* @if pa\C-m* Action \C-m* @endif\C-m*/\C-mvirtual bool action(Storage &st,const Input &in);\C-m")
;
;(fset 'p2-action-body
;      "\C-m\M-xinsert-class-comment\C-m\C-m\M-xinsert-class-line\C-m{\C-mpublic:\C-m\M-xfirst-const-p2action\C-m\C-m\M-xsecond-const-p2action\C-m\C-m\M-xthird-const-p2action\C-m\C-m\M-xdestructor-p2action\C-m\C-m\M-xitor-p2action\C-m\C-m\M-xaction-p2action\C-m\C-mprivate:\C-m};")
;
;(fset 'console-action-body
;      "/\C-u75*\C-m* $\C-m\C-u75*/\C-mclass $ : public \M-xinsert-consoleaction\C-m{\C-mpublic:\C-m$(CXCommand *cmd=NULL);\C-mvirtual ~$();\C-m\C-mACTION_ITOR($);\C-m\C-mvirtual bool action(Storage &st,const Input &in);\C-mprivate:\C-m};\C-u12\C-p\C-u2\C-b")
;
;(fset 'p2-action-src
;      "/**\C-m* $ Constructor\C-m*/\C-m$::$(const char *cmd,const string &description,\C-mconst Parameters &params):\C-m__Action(cmd, description, params)\C-m{\C-m}\C-m\C-m/**\C-m* $ Constructor\C-m*/\C-m$::$(const CmdAlias &cmds,const string &description,\C-mconst Parameters &params):\C-m__Action(cmds, description, params)\C-m{\C-m}\C-m\C-m/**\C-m* $ Constructor\C-m*/\C-m$::$(CXCommand *cmd):\C-m__Action(cmd)\C-m{\C-m}\C-m\C-m/**\C-m* $ Destructor\C-m*/\C-m$::~$()\C-m{\C-m}\C-m\C-m/**\C-m* $ Action\C-m*/\C-mbool $::action(Storage &s, const Input &InValue)\C-m{\C-m\M-xtry-line\C-i\C-m\M-xcatch-line-bad-cast\C-i\C-mreturn(true);\C-m}\C-u28\C-p")
;
(fset 'comment-block
   "/\C-u75*\C-m*\C-m\C-u75*/\C-m\C-u2\C-p\C-e")

(fset 'comment-line
   "\C-a\C-i/*\C-e*/\C-n")

(fset 'uncomment-line
   "\C-a\C-i\C-d\C-d\C-e\C-?\C-?\C-n")

(fset 'comment-continuation
   "\C-a\C-i*\C-i \C-n")


(fset 'phat-seperation
      "//////\C-u70*//\C-m//////\C-u70 //\C-m//////\C-u70 //\C-m//////\C-u70 //\C-m//////\C-u70*//\C-u3\C-p\C-a\C-u7\C-f$")

(fset 'try-line
      "\C-atry\C-m{\C-m\C-e\C-m}\C-n")
(fset 'catch-line
      "\C-acatch(...)\C-m{\C-m\C-e\C-m}\C-n")
(fset 'catch-line-bad-cast
      "\C-acatch(std::bad_cast)\C-m{\C-m\C-e\C-m}\C-n")
(fset 'try-catch-e
      "\M-xtry-line\C-i\C-m\M-xcatch-line\C-i\C-m\C-u2\C-p\C-e\C-u5\C-b")
(fset 'try-catch-bad-cast
      "\M-xtry-line\C-i\C-m\M-xcatch-line-bad-cast\C-i\C-m\C-u2\C-p\C-e\C-u5\C-b")
(fset 'return-it
      "return();\C-b\C-b")

(fset 'return-it-also
      "\M-b(\M-f);\M-b\C-breturn")


;(fset 'define-it
;      "\C-a#ifndef _XX_h\C-n#define _XX_h\C-n\M-xfucking-pragmas\C-i\C-m\C-n\C-n#endif")
;
;(defun match-paren (arg)
;  "Go to the matching parenthesis if on parenthesis otherwise insert %."
;  (interactive "p")
;  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;	 ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;	 (t (self-insert-command (or arg 1)))))

;(define-key c-mode-map "%" 'match-paren)
;(define-key c-mode-map "\C-cf"    'dress-funct)
;(define-key c-mode-map "\C-c\C-d" 'ansi-args-to-traditional)
;(define-key c-mode-map "\C-cd"    'cleanup-ansi-args-to-traditional)
;(define-key c-mode-map "\C-cD"    'decl-funct-traditional)
;(define-key c-mode-map "\C-ci"    'forward-reference-internal)
;(define-key c-mode-map "\C-ci" 'internal-function)

;(define-key c-mode-map "\C-c\C-c" 'comment-continuation)
;(define-key c-mode-map "\C-cc" 'comment-block)
;(define-key c-mode-map "\C-cF" 'file-comment-block)
;(define-key c-mode-map "\C-c\C-l" 'comment-line)
;(define-key c-mode-map "\C-cl" 'uncomment-line)
;(define-key c-mode-map "\C-ch" 'my-c-hdr-file)
;(define-key c-mode-map "\C-ce" 'extern-function)
;(define-key c-mode-map "\C-cI" 'make-internal-function-header)
;(define-key c-mode-map "\C-ca" 'indented-text-mode)
;(define-key c-mode-map "\C-cu" 'my-untabify)
;(define-key c-mode-map "\C-c\\" 'my-align)

;(setq c-argdecl-indent 0)
;(setq c-indent-level 4)
;(setq c-continued-statement-offset 0)

;(defun turn-off-indent-tabs-mode()
;  "Unconditionally turn off indent-tabs-mode"
;   (setq indent-tabs-mode nil)
;)

;(add-hook 'c-mode-hook 'turn-off-indent-tabs-mode)
(fset 'std::cout
      "std::cout << \"\" << std::endl;\C-u15\C-b")
(fset 'std::cerr
      "std::cerr << \"\" << std::endl;\C-u15\C-b")

