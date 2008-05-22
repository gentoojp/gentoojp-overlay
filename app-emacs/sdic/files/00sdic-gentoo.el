
;;; sdic site-lisp configuration

(autoload 'sdic-describe-word "sdic" "��ñ��ΰ�̣��Ĵ�٤�" t nil)
(global-set-key "\C-cw" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "��������ΰ��֤α�ñ��ΰ�̣��Ĵ�٤�" t nil)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)

;;; Dummy sdic dictionary lists to be appended to later
;;; Please do not remove this!
(setq sdic-eiwa-dictionary-list nil
      sdic-waei-dictionary-list nil)