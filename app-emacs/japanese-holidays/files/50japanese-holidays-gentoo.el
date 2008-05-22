;;; japanese-holidays site-lisp configuration
(add-to-list 'load-path "@SITELISP@")

;; japanese-holidays.el は必ず byte-compile すること。
(add-hook 'calendar-load-hook
	  (lambda ()
	    (require 'japanese-holidays)
	    (setq calendar-holidays
		  (append japanese-holidays local-holidays other-holidays)
		  mark-holidays-in-calendar t)))

;;; 日曜日を赤字に
(add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
(add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend)
;; (setq calendar-weekend '(0 6)) ;;; 土日を赤字に (.emacsに書く)

;;; “きょう”にアンダーライン
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
