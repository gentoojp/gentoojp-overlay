;;; japanese-holidays site-lisp configuration
(add-to-list 'load-path "@SITELISP@")

;; japanese-holidays.el $B$OI,$:(B byte-compile $B$9$k$3$H!#(B
(add-hook 'calendar-load-hook
	  (lambda ()
	    (require 'japanese-holidays)
	    (setq calendar-holidays
		  (append japanese-holidays local-holidays other-holidays)
		  mark-holidays-in-calendar t)))

;;; $BF|MKF|$r@V;z$K(B
(add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
(add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend)
;; (setq calendar-weekend '(0 6)) ;;; $BEZF|$r@V;z$K(B (.emacs$B$K=q$/(B)

;;; $B!H$-$g$&!I$K%"%s%@!<%i%$%s(B
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
