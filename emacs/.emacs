;; for normal linux style
(add-to-list 'load-path "~/.emacs.d/")
;; for a windows spawned shell
(add-to-list 'load-path "c:/Users/jmorris/AppData/Roaming/.emacs.d/")

(load "my.el")
(load "els/ip3.el")
(load "els/modular.el")
(load "els/doxygen.el")
(load "els/html.el")
(load "els/java.el")
(load "els/c")
(load "els/c++.el")
(load "els/protobuf-mode.el")
(load "els/markdown-model.el")
(load "els/git.el")
(load "els/powershell-mode.el")
(load "els/mymisc.el")

;;(load "linenum.el")

(setq c-default-style "bsd"
      tab-width 4
      c-basic-offset 4
      indent-tabs-mode nil)


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-battery-mode t)
 '(inhibit-startup-screen t)
; '(initial-buffer-choice f)
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
; '(quote tab-stop-list)
; '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))
)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(defun save-macro (name)                  
    "save a macro. Take a name as argument
     and save the last defined macro under 
     this name at the end of your .emacs"
     (interactive "SName of the macro :")  ; ask for the name of the macro    
     (kmacro-name-last-macro name)         ; use this name for the macro    
     (defvar x "~/.emacs.d/els/mymisc.el")
     (find-file x)           ; open ~/.emacs or other user init file 
     (goto-char (point-max))               ; go to the end of the .emacs
     (newline)                             ; insert a newline
     (insert-kbd-macro name)               ; copy the macro 
     (newline)                             ; insert a newline
     (save-buffer x)
     (switch-to-buffer nil))               ; return to the initial buffer
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
