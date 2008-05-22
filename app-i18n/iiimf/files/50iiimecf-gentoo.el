;;; iiimecf-init.el

(add-to-list 'load-path "/usr/share/emacs/site-lisp/iiimf")
(setq iiimcf-server-control-hostlist '("unix/:9010")
      iiimcf-server-control-default-language
      (let* ((locale (or (getenv "LC_ALL")
			 (getenv "LC_CTYPE")
			 (getenv "LANG")))
	     (lang-region (and locale
			       (substring locale 0 (min 5 (length locale)))))
	     (lang (and lang-region
			(substring lang-region 0 (min 2 (length lang-region))))))
	(cond ((equal lang "zh")
	       lang-region)
	      (t lang))))
(autoload 'iiimcf-server-control-activate "iiimcf-sc")

(register-input-method "iiim" "multilingual"
                       'iiimcf-server-control-activate ""
                       "IIIM server control input method")

;; put this in your .emacs file if you want to use iiimecf by default
;(setq default-input-method 'iiim-server-control)
