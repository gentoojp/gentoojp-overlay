
;;; mew site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
