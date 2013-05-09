(setq auto-mode-alist (append (list (cons "\\.html$" 'indented-text-mode))
				auto-mode-alist))

(setq auto-mode-alist (append (list (cons "\\.htm$" 'indented-text-mode))
				auto-mode-alist))

;(fset 'html-bold
;  "\C-a<b>\C-e</b>\C-n")
;(fset 'html-bold-mark-set
;  "</b>\C-x\C-x<b>\C-x\C-x")
;(fset 'html-italics
;  "\C-a<i>\C-e</i>\C-n")
;(fset 'html-italics-mark-set
;  "</i>\C-x\C-x<i>\C-x\C-x")
;(fset 'html-preformat
;  "\C-a<pre>\C-e</pre>\C-n")
;(fset 'html-preformat-mark-set
					;  "</pre>\C-x\C-x<pre>\C-x\C-x")
;(fset 'html-title-mark-set
;  "x1
;</TITLE><TITLE>
;\C-s</TITLE>\C-[
;
;</H1>g1<H1>\C-s</H1>\C-[")
;(global-set-key "\C-cb"    'html-bold)
;(global-set-key "\C-c\C-b" 'html-bold-mark-set)
;(global-set-key "\C-ci"    'html-italics)
;(global-set-key "\C-c\C-i" 'html-italics-mark-set)
;(global-set-key "\C-cp"    'html-preformat)
;(global-set-key "\C-c\C-p" 'html-preformat-mark-set)
;(global-set-key "\C-c\C-t" 'html-title-mark-set)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'html-mouseOver-blank
      "onMouseOver=\"window.status=\'\';return true\">")
(fset 'html-viper-footnote
      "<a href=\"footNote.html#\" target=\"footnote_window\" onMouseOver=\"window.status=\'\';return true\">")
(fset 'html-local-anchor
      "<a href=\"#\" onMouseOver=\"window.status=\'\';return true\">")
(fset 'html-fillin
      "<font color=\"red\"><blink>BLANK - TO BE FILLED IN</blink></font>")
(fset 'html-newrow
      "<tr></tr>\C-u5\C-b")
(fset 'html-newdata
      "<td></td>\C-u5\C-b")
(fset 'html-word-bold
      "\M-b\C-@\M-f\C-w<b>\C-y</b>")
(fset 'html-word-italic
    "\M-b\C-@\M-f\C-w<i>\C-y</i>")
(fset 'html-start-bold
      "<b>")
(fset 'html-end-bold
      "</b>")
(fset 'html-start-italic
      "<i>")
(fset 'html-end-italic
      "</i>")











