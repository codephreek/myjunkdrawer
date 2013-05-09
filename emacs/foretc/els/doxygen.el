(fset 'dox-comment-top
      "/** $Id$ */\C-m\C-m/**\C-m* Ridge Software Technology Associates LLC.\C-m* Juan Morris\C-m* Date://\C-m*/\C-m")

(fset 'dox-comment-block
      "/**\C-m* \\if\C-m* \C-m* \\endif\C-m*/\C-m\C-u4\C-p\C-e ")
(fset 'dox-comment-block-2
      "/**\C-m*\C-m* \C-m*\C-m*/\C-m\C-u4\C-p\C-e ")
(fset 'dox-bold
      "\M-b\C-@\M-f\C-w<b>\C-y</b>")
(fset 'dox-italic
      "\M-b\C-@\M-f\C-w<i>\C-y</i>")
(fset 'dox-var
      "/** */\C-u2\C-b")
(fset 'dox-see
      "* \\see\C-e ")
(fset 'dox-return
      "* \\return\C-e ")
(fset 'dox-param
      "* \\param\C-e ")
(fset 'dox-author
      "* \\author\C-e ")
(fset 'dox-me
      "* \\author Juan Morris\C-m* \\author Ridge Software Technology Associates LLC.\C-e")
(fset 'dox-if
      "* \\if")
(fset 'dox-end_if
      "* \\endif")
(fset 'dox-class-comment
      "\C-a\M-f\C-@\M-f\C-w\C-y\C-p\C-m\/**\C-m* @class \C-y\C-m\M-xdox-me\C-m\C-m* @brief\C-m*\C-m* @bug as of\C-m*/\C-u1\C-p\C-e")

(fset 'dox-action-comment
      "\C-a\M-f\M-f\C-@\M-f\C-w\C-y\C-a\C-q\t/*************\C-m* \C-y\C-m*/\C-m/**\C-m* dynamically casts the <i>&s</i> to a BusinessRulesNode\C-m* and calls extractMessage(Input &in) mehtod.\C-m*\C-m* @see BusinessRulesNode::extractMessage(Input &in)\C-m*/\C-m\C-u5\C-p")


(fset 'dox-protocol-comment
 "/**\C-m* \\if description\C-m*\C-m*  \\if description2\C-m*\C-m*  \\endif\C-m* \\endif\C-m*\C-m* \\if show_params\C-m*\C-m* \\endif\C-m*\C-m* \\if programmer\C-m*  <b> Usage</b>\C-m*  \\code\C-m*    {\C-m*    }\C-m*  \\endcode\C-m* \\endif\C-m*\C-m* \\if show_sample\C-m*  <b>Message Sample</b>\C-m*  \\code\C-m*    </>\C-m*  \\endcode\C-m* \\endif\C-m*/\C-u24\C-p")