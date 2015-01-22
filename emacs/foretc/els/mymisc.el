
(fset 'single-space
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([19 32 left 134217760] 0 "%d")) arg)))


(fset 'foo
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("test)" 0 "%d")) arg)))

(fset 'foo2
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("test)" 0 "%d")) arg)))


(fset 'foo45
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([19 32 left 134217820] 0 "%d")) arg)))

