(require 'dired)

(defvar dired-font-lock-keywords
  (list
   ;;
   ;; Directory headers.
   (list dired-subdir-regexp '(1 font-lock-type-face))
   ;;
   ;; We make heavy use of MATCH-ANCHORED, since the regexps don't identify the
   ;; file name itself.  We search for Dired defined regexps, and then use the
   ;; Dired defined function `dired-move-to-filename' before searching for the
   ;; simple regexp ".+".  It is that regexp which matches the file name.
   ;;
   ;; Dired marks.
   (list dired-re-mark
	 '(0 font-lock-constant-face)
	 '(".+" (dired-move-to-filename) nil (0 font-lock-function-face)))
   ;; People who are paranoid about security would consider this more
   ;; important than other things such as whether it is a directory.
   ;; But we don't want to encourage paranoia, so our default
   ;; should be what's most useful for non-paranoids. -- rms.
;;;   ;;
;;;   ;; Files that are group or world writable.
;;;   (list (concat dired-re-maybe-mark dired-re-inode-size
;;;		 "\\([-d]\\(....w....\\|.......w.\\)\\)")
;;;	 '(1 font-lock-comment-face)
;;;	 '(".+" (dired-move-to-filename) nil (0 font-lock-comment-face)))
   ;;
   ;; Subdirectories.
   (list dired-re-dir
	 '(".+" (dired-move-to-filename) nil (0 font-lock-function-name-face)))
   ;;
   ;; Symbolic links.
   (list dired-re-sym 
	 '(".+" (dired-move-to-filename) nil (0 font-lock-function-face)))
   ;;
   ;; Files suffixed with `completion-ignored-extensions'.
   '(eval .
     (let ((extensions (mapcar 'regexp-quote completion-ignored-extensions)))
       ;; It is quicker to first find just an extension, then go back to the
       ;; start of that file name.  So we do this complex MATCH-ANCHORED form.
       (list (concat "\\(" (mapconcat 'identity extensions "\\|") "\\|#\\)$")
	     '(".+" (dired-move-to-filename) nil (0 font-lock-function-face))))))
  "Additional expressions to highlight in Dired mode.")
