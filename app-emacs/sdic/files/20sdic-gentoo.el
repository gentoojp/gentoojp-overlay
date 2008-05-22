
;;; site-lisp configuration for sdic

(autoload 'sdic-describe-word "sdic" "Look up a english word." t nil)
(global-set-key "\C-cw" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "Look up a english word at point." t nil)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)

(setq sdic-eiwa-dictionary-list nil
      sdic-waei-dictionary-list nil)
