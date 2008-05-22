
;;; lsdb site-lisp configuration
(autoload 'lsdb-gnus-insinuate "lsdb" nil t)
(autoload 'lsdb-gnus-insinuate-message "lsdb" nil t)
(add-hook 'gnus-startup-hook 'lsdb-gnus-insinuate)

