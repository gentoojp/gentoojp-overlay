;;; mapae site-lisp configuration

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mapae")
(require 'mapae)
(setq mapae-perl-command "/usr/bin/perl")
(setq mapae-command "/usr/share/emacs/site-lisp/mapae/mapae.pl")
(global-set-key "\C-cwn" 'mapae-new-post)
(global-set-key "\C-cwr" 'mapae-get-recent-post)
(global-set-key "\C-cwg" 'mapae-get-post)
(global-set-key "\C-cwl" 'mapae-get-recent-titles)
