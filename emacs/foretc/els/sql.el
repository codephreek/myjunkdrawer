(fset 'sql-comment-block
   "\C-a----------------------------------------------------------------------
-- 
----------------------------------------------------------------------
\C-p\C-p\C-e")

(fset 'sql-put-line
   "DBMS_OUTPUT.PUT_LINE('');\C-b\C-b\C-b")

(fset 'sql-htp-print
   "htp.print('');\C-b\C-b\C-b")

(fset 'sql-function
  "----------------------------------------------------------------------
-- $$$ 
----------------------------------------------------------------------

FUNCTION $$$
(
  
)
RETURN %%% IS

  proc_name	VARCHAR2(128) := '$$$';

BEGIN
  logit.DEBUG(1,'at '|| package_name || '.' || proc_name);

EXCEPTION
  WHEN OTHERS THEN
    logit.fatal(package_name,proc_name,SQLERRM(SQLCODE),k.errOthers);
END $$$;
\C-u18\C-p\C-a")

(fset 'sql-procedure
  "----------------------------------------------------------------------
-- $$$
----------------------------------------------------------------------

PROCEDURE $$$
(

)
IS

  proc_name	VARCHAR2(128) := '$$$';

BEGIN
  logit.DEBUG(1,'at '|| package_name || '.' || proc_name);

EXCEPTION
  WHEN OTHERS THEN
    logit.fatal(package_name,proc_name,SQLERRM(SQLCODE),k.errOthers);
END $$$;
\C-u18\C-p\C-a")

(fset 'sql-package
 "--
-- RockRidge Systems, Ltd.
-- <author>
-- <date>
--
-- <package>.pkg
--   <description>
--
-- $Id$
--

SET DEFINE OFF;

PROMPT Creating specification for <package>

CREATE OR REPLACE PACKAGE <package>
IS

  package_name		CONSTANT VARCHAR2(255) := '<package>';
  package_version	CONSTANT VARCHAR2(255) := '$Id$';

PROCEDURE version;

END <package>;
/
show errors;

PROMPT Creating body for <package>

CREATE OR REPLACE PACKAGE BODY <package>
IS

----------------------------------------------------------------------
-- version
----------------------------------------------------------------------

PROCEDURE version
IS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Package Name: ' || package_name);
  DBMS_OUTPUT.PUT_LINE('Version: ' || package_version);
END version;

END <package>;
/
show errors;
\M-<\C-n\C-n\C-u3\C-f")

(fset 'sql-varchar2
  "VARCHAR2")

(fset 'sql-boolean
  "BOOLEAN")

(fset 'sql-number
  "NUMBER")

(fset 'sql-integer
  "INTEGER")

(fset 'sql-date
  "DATE")

(fset 'sql-debug
  "logit.DEBUG(1,'');\C-b\C-b\C-b");

(fset 'sql-clean-log-params
   [?\C-u ?1 ?0 ?0 ?0 escape ?l escape ?< escape ?% ?: return tab ?I ?N ?  ?, return ?! escape ?< ?\C-c ?5 ?^ ?  ?  ?  ?. ?* ?\C-q ?\C-j return return ?! escape ?< escape ?% ?\C-q ?\C-j ?\C-q ?\C-j return ?\C-q ?\C-j return ?!])

(fset 'sql-return-and-indent
   "\C-j\C-i")

(fset 'ges-shells
  "\M-xshell\C-m\M-xrename-buffer\C-m*gadm-shell*\C-m\M-xshell\C-m\M-xrename-buffer\C-m*ges-shell*\C-m")

(fset 'ota-shells
  "\M-xshell\C-m\M-xrename-buffer\C-ma*ota-shell*\C-m\M-xshell\C-m\M-xrename-buffer\C-m*wbota-shell*\C-m\M-xshell\C-m\M-xrename-buffer\C-m*rota-shell*")

(fset 'clv-shells
  "\M-xshell\C-m\M-xrename-buffer\C-m*clv-shell*\C-m")

(fset 'gts-shell
  "\M-xshell\C-m\M-xrename-buffer\C-m*gts-shell*\C-m")

;(define-key indented-text-mode-map "\C-cp" 'sql-procedure)
;(define-key indented-text-mode-map "\C-cf" 'sql-function)
;(define-key indented-text-mode-map "\C-c\C-d" 'sql-debug);
;(define-key indented-text-mode-map "\C-cc" 'sql-comment-block)
;(define-key indented-text-mode-map "\C-co" 'sql-put-line)
;(define-key indented-text-mode-map "\C-ch" 'sql-htp-print)
;(define-key indented-text-mode-map "\C-cv" 'sql-varchar2)
;(define-key indented-text-mode-map "\C-cb" 'sql-boolean)
;(define-key indented-text-mode-map "\C-cn" 'sql-number)
;(define-key indented-text-mode-map "\C-ci" 'sql-integer)
;(define-key indented-text-mode-map "\C-cd" 'sql-date)
;(define-key indented-text-mode-map "\C-m"  'sql-return-and-indent)

(setq auto-mode-alist (append (list (cons "\\.sql$" 'indented-text-mode))
                               auto-mode-alist))

(setq auto-mode-alist (append (list (cons "\\.pkg$" 'indented-text-mode))
                               auto-mode-alist))

;(setq-default indent-tabs-mode nil)

;(setq-default tab-stop-list '(1 2 4 6 8 10 12 14 16 24 32 40 48 56 64 72 80))

;(global-set-key "\C-m" 'return-and-indent)
