
;;; sdic site-lisp configuration

(autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
(global-set-key "\C-cw" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)

;;; Dummy sdic dictionary lists to be appended to later
;;; Please do not remove this!
(setq sdic-eiwa-dictionary-list nil
      sdic-waei-dictionary-list nil)