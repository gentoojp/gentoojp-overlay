
;;; EDICT  site-lisp configuration

(setq sdic-waei-dictionary-list
    (cons '(sdicf-client "/usr/share/dict/jedict.sdic") sdic-waei-dictionary-list))
(setq sdic-eiwa-dictionary-list
    (cons '(sdicf-client "/usr/share/dict/eedict.sdic") sdic-eiwa-dictionary-list))
