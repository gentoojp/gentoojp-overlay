;;; japanese-holidays.el --- calendar functions for the Japanese calendar

;; Copyright (C) 1999 Takashi Hattori <hattori@sfc.keio.ac.jp>
;; Copyright (C) 2005 Hiroya Murata <lapis-lazuli@pop06.odn.ne.jp>

;; Author: Takashi Hattori <hattori@sfc.keio.ac.jp>
;;	Hiroya Murata <lapis-lazuli@pop06.odn.ne.jp>
;; Keywords: calendar

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Original program created by T. Hattori 1999/4/20

;; $B$3$N%W%m%0%i%`$O!"(Bcalender $B$GI=<(=PMh$kMM$KF|K\$N=KF|$r@_Dj$7$^$9!#(B
;; $B;HMQ$9$k$K$O!"$3$N%U%!%$%k$r(B load-path $B$NDL$C$?=j$KCV$-!"(B~/.emacs $B$K(B
;; $B0J2<$N@_Dj$rDI2C$7$^$9!#(B

;;  (add-hook 'calendar-load-hook
;;            (lambda ()
;;              (require 'japanese-holidays)
;;              (setq calendar-holidays
;;                    (append japanese-holidays local-holidays other-holidays))))
;;  (setq mark-holidays-in-calendar t)

;; $B!H$-$g$&!I$r%^!<%/$9$k$K$O0J2<$N@_Dj$rDI2C$7$^$9!#(B
;;  (add-hook 'today-visible-calendar-hook 'calendar-mark-today)

;; $BF|MKF|$r@V;z$K$9$k>l9g!"0J2<$N@_Dj$rDI2C$7$^$9!#(B
;;  (setq calendar-weekend-marker 'diary)
;;  (add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
;;  (add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend)

;;; Code:
;;

(eval-when-compile
  (require 'cl)
  (defvar displayed-month)
  (defvar displayed-year)
  (when noninteractive
    (require 'holidays)))

(autoload 'solar-equinoxes/solstices "solar")

(defcustom japanese-holidays
  '(;; $BL@<#(B6$BG/B@@/41I[9pBh(B344$B9f(B
    (holiday-range
     (holiday-fixed 1 3 "$B85;O:W(B") '(10 14 1873) '(7 20 1948))
    (holiday-range
     (holiday-fixed 1 5 "$B?7G/1c2q(B") '(10 14 1873) '(7 20 1948))
    (holiday-range
     (holiday-fixed 1 30 "$B9'L@E79D:W(B") '(10 14 1873) '(9 3 1912))
    (holiday-range
     (holiday-fixed 2 11 "$B5*85@a(B") '(10 14 1873) '(7 20 1948))
    (holiday-range
     (holiday-fixed 4 3 "$B?@IpE79D:W(B") '(10 14 1873) '(7 20 1948))
    (holiday-range
     (holiday-fixed 9 17 "$B?@>(:W(B") '(10 14 1873) '(7 5 1879))
    (holiday-range
     (holiday-fixed 11 3 "$BE7D9@a(B") '(10 14 1873) '(9 3 1912))
    (holiday-range
     (holiday-fixed 11 23 "$B?7>(:W(B") '(10 14 1873) '(7 20 1948))
    ;; $BL@<#(B11$BG/B@@/41I[9p(B23$B9f(B
    (let* ((equinox (solar-equinoxes/solstices 0 displayed-year))
	   (m (extract-calendar-month equinox))
	   (d (truncate (extract-calendar-day equinox))))
      (holiday-range
       (holiday-fixed m d "$B=U5(9DNn:W(B") '(6 5 1878) '(7 20 1948)))
    (let* ((equinox (solar-equinoxes/solstices 2 displayed-year))
	   (m (extract-calendar-month equinox))
	   (d (truncate (extract-calendar-day equinox))))
      (holiday-range
       (holiday-fixed m d "$B=)5(9DNn:W(B") '(6 5 1878) '(7 20 1948)))
    ;; $BL@<#(B12$BG/B@@/41I[9p(B27$B9f(B
    (holiday-range
     (holiday-fixed 10 17 "$B?@>(:W(B") '(7 5 1879) '(7 20 1948))
    ;; $B5YF|%K4X%9%k7o(B ($BBg@585G/D<NaBh(B19$B9f(B)
    (holiday-range
     (holiday-fixed 7 30 "$BL@<#E79D:W(B") '(9 3 1912) '(3 3 1927))
    (holiday-range
     (holiday-fixed 8 31 "$BE7D9@a(B") '(9 3 1912) '(3 3 1927))
    ;; $BBg@5(B2$BG/D<Na(B259$B9f(B
    (holiday-range
     (holiday-fixed 10 31 "$BE7D9@a=KF|(B") '(10 31 1913) '(3 3 1927))
    ;; $B5YF|%K4X%9%k7o2~@5%N7o(B ($B><OB(B2$BG/D<NaBh(B25$B9f(B)
    (holiday-range
     (holiday-fixed 4 29 "$BE7D9@a(B") '(3 3 1927) '(7 20 1948))
    (holiday-range
     (holiday-fixed 11 3 "$BL@<#@a(B") '(3 3 1927) '(7 20 1948))
    (holiday-range
     (holiday-fixed 12 25 "$BBg@5E79D:W(B") '(3 3 1927) '(7 20 1948))
    ;; $B9qL1$N=KF|$K4X$9$kK!N'$N0lIt$r2~@5$9$kK!N'(B ($B><OB(B60$BG/K!N'Bh(B103$B9f(B)
    (holiday-national
     ;; $B9qL1$N=KF|$K4X$9$kK!N'$N0lIt$r2~@5$9$kK!N'(B ($B><OB(B48$BG/K!N'Bh(B10$B9f(B)
     (holiday-substitute
      (nconc
       ;; $B9qL1$N=KF|$K4X$9$kK!N'(B ($B><OB(B23$BG/K!N'Bh(B178$B9f(B)
       (holiday-range
	(holiday-fixed 1 1 "$B85F|(B") '(7 20 1948))
       (holiday-range
	(holiday-fixed 1 15 "$B@.?M$NF|(B") '(7 20 1947) '(1 1 2000))
       (let* ((equinox (solar-equinoxes/solstices 0 displayed-year))
	      (m (extract-calendar-month equinox))
	      (d (truncate (extract-calendar-day equinox))))
	 ;; $B=UJ,$NF|$O!"87L)$K$OA0G/(B2$B7n$N41Js$K$h$j7hDj$5$l$k(B
	 (holiday-range
	  (holiday-fixed m d "$B=UJ,$NF|(B") '(7 20 1948)))
       (holiday-range
	(holiday-fixed 4 29 "$BE79DCB@8F|(B") '(7 20 1948) '(2 17 1989))
       (holiday-range
	(holiday-fixed 5 3 "$B7{K!5-G0F|(B") '(7 20 1948))
       (holiday-range
	(holiday-fixed 5 5 "$B$3$I$b$NF|(B") '(7 20 1948))
       (let* ((equinox (solar-equinoxes/solstices 2 displayed-year))
	      (m (extract-calendar-month equinox))
	      (d (truncate (extract-calendar-day equinox))))
	 ;; $B=)J,$NF|$O!"87L)$K$OA0G/(B2$B7n$N41Js$K$h$j7hDj$5$l$k(B
	 (holiday-range
	  (holiday-fixed m d "$B=)J,$NF|(B") '(7 20 1948)))
       (holiday-range
	(holiday-fixed 11 3 "$BJ82=$NF|(B") '(7 20 1948))
       (holiday-range
	(holiday-fixed 11 23 "$B6PO+46<U$NF|(B") '(7 20 1948))
       ;; $B9qL1$N=KF|$K4X$9$kK!N'$N0lIt$r2~@5$9$kK!N'(B ($B><OB(B41$BG/K!N'Bh(B86$B9f(B)
       ;;   $B7z9q5-G0$NF|$H$J$kF|$rDj$a$k@/Na(B ($B><OB(B41$BG/@/NaBh(B376$B9f(B)
       (holiday-range
	(holiday-fixed 2 11 "$B7z9q5-G0$NF|(B") '(6 25 1966))
       (holiday-range
	(holiday-fixed 9 15 "$B7IO7$NF|(B") '(6 25 1966) '(1 1 2003))
       (holiday-range
	(holiday-fixed 10 10 "$BBN0i$NF|(B") '(6 25 1966) '(1 1 2000))
       ;; $B9qL1$N=KF|$K4X$9$kK!N'$N0lIt$r2~@5$9$kK!N'(B ($BJ?@.85G/K!N'Bh(B5$B9f(B)
       (holiday-range
	(holiday-fixed 4 29 "$B$_$I$j$NF|(B") '(2 17 1989) '(1 1 2007))
       (holiday-range
	(holiday-fixed 12 23 "$BE79DCB@8F|(B") '(2 17 1989))
       ;; $B9qL1$N=KF|$K4X$9$kK!N'$N0lIt$r2~@5$9$kK!N'(B ($BJ?@.(B7$BG/K!N'Bh(B22$B9f(B)
       (holiday-range
	(holiday-fixed 7 20 "$B3$$NF|(B") '(1 1 1996) '(1 1 2003))
       ;; $B9qL1$N=KF|$K4X$9$kK!N'$N0lIt$r2~@5$9$kK!N'(B ($BJ?@.(B10$BG/K!N'Bh(B141$B9f(B)
       (holiday-range
	(holiday-float 1 1 2 "$B@.?M$NF|(B") '(1 1 2000))
       (holiday-range
	(holiday-float 10 1 2 "$BBN0i$NF|(B") '(1 1 2000))
       ;; $B9qL1$N=KF|$K4X$9$kK!N'5Z$SO7?MJ!;cK!$N0lIt$r2~@5$9$kK!N'(B ($BJ?@.(B13$BG/K!N'Bh(B59$B9f(B)
       (holiday-range
	(holiday-float 7 1 3 "$B3$$NF|(B") '(1 1 2003))
       (holiday-range
	(holiday-float 9 1 3 "$B7IO7$NF|(B") '(1 1 2003))
       ;; $B9qL1$N=KF|$K4X$9$kK!N'$N0lIt$r2~@5$9$kK!N'(B ($BJ?@.(B17$BG/K!N'Bh(B43$B9f(B)
       (holiday-range
	(holiday-fixed 4 29 "$B><OB$NF|(B") '(1 1 2007))
       (holiday-range
	(holiday-fixed 5 4 "$B$_$I$j$NF|(B") '(1 1 2007)))))
    (filter-visible-calendar-holidays
     '(;; $B9DB@;RL@?N?F2&$N7k:'$N57$N9T$o$l$kF|$r5YF|$H$9$kK!N'(B ($B><OB(B34$BG/K!N'Bh(B16$B9f(B)
       ((4 10 1959) "$BL@?N?F2&$N7k:'$N57(B")
       ;; $B><OBE79D$NBgAS$NNi$N9T$o$l$kF|$r5YF|$H$9$kK!N'(B ($BJ?@.85G/K!N'Bh(B4$B9f(B)
       ((2 24 1989) "$B><OBE79D$NBgAS$NNi(B")
       ;; $BB(0LNi@5EB$N57$N9T$o$l$kF|$r5YF|$H$9$kK!N'(B ($BJ?@.(B2$BG/K!N'Bh(B24$B9f(B)
       ((11 12 1990) "$BB(0LNi@5EB$N57(B")
       ;; $B9DB@;RFA?N?F2&$N7k:'$N57$N9T$o$l$kF|$r5YF|$H$9$kK!N'(B ($BJ?@.(B5$BG/K!N'Bh(B32$B9f(B)
       ((6 9 1993) "$BFA?N?F2&$N7k:'$N57(B"))))
  "*Japanese holidays.
See the documentation for `calendar-holidays' for details."
  :type 'sexp
  :group 'holidays)

(defcustom holiday-substitute-name "$B?6BX5YF|(B"
  "*Name of substitute holiday."
  :type 'string
  :group 'holidays)

(defcustom holiday-national-name "$B9qL1$N5YF|(B"
  "*Name of national holiday."
  :type 'string
  :group 'holidays)

(eval-and-compile
  (defun holiday-make-sortable (date)
    (+ (* (nth 2 date) 10000) (* (nth 0 date) 100) (nth 1 date))))

(defun holiday-range (holidays &optional from to)
  (let ((from (and from (holiday-make-sortable from)))
	(to   (and to   (holiday-make-sortable to))))
    (delq nil
	  (mapcar
	   (lambda (holiday)
	     (let ((date (holiday-make-sortable (car holiday))))
	       (when (and (or (null from) (<= from date))
			  (or (null to) (< date to)))
		 holiday)))
	   holidays))))

(defun holiday-find-date (date holidays)
  (let ((sortable-date (holiday-make-sortable date))
	matches)
    (dolist (holiday holidays)
      (when (= sortable-date (holiday-make-sortable (car holiday)))
	(setq matches (cons holiday matches))))
    matches))

(defun holiday-add-days (date days)
  (calendar-gregorian-from-absolute
   (+ (calendar-absolute-from-gregorian date) days)))

(defun holiday-subtract-date (from other)
  (- (calendar-absolute-from-gregorian from)
     (calendar-absolute-from-gregorian other)))

(defun holiday-substitute (holidays)
  (let (substitutes substitute)
    (dolist (holiday holidays)
      (let ((date (car holiday)))
	(when (and (>= (holiday-make-sortable date)
		       (eval-when-compile
			 (holiday-make-sortable '(4 12 1973))))
		   (= (calendar-day-of-week date) 0))
	  (setq substitutes
		(cons
		 (list (holiday-add-days date 1)
		       (format "%s (%s)"
			       holiday-substitute-name
			       (cadr holiday)))
		 substitutes)))))
    (when (setq substitutes
		(filter-visible-calendar-holidays substitutes))
      (setq substitutes (sort substitutes
			      (lambda (l r)
				(< (holiday-make-sortable (car l))
				   (holiday-make-sortable (car r))))))
      (while (setq substitute (car substitutes))
	(setq substitutes (cdr substitutes))
	(if (holiday-find-date (car substitute) holidays)
	    (let* ((date (car substitute))
		   (sortable-date (holiday-make-sortable date)))
	      (when (>= sortable-date
			(eval-when-compile
			  (holiday-make-sortable '(1 1 2007))))
		(setq substitutes
		      (cons
		       (list (holiday-add-days date 1) (cadr substitute))
		       substitutes))))
	  (setq holidays (cons substitute holidays)))))
    (filter-visible-calendar-holidays holidays)))

(defun holiday-national (holidays)
  (when holidays
    (setq holidays (sort holidays
			 (lambda (l r)
			   (< (holiday-make-sortable (car l))
			      (holiday-make-sortable (car r))))))
    (let* ((rest holidays)
	   (curr (pop rest))
	   prev nationals)
      (while (setq prev curr
		   curr (pop rest))
	(when (= (holiday-subtract-date (car curr) (car prev)) 2)
	  (let* ((date (holiday-add-days (car prev) 1))
		 (sotable-date (holiday-make-sortable date)))
	    (when (cond
		   ((>= sotable-date
			(eval-when-compile
			  (holiday-make-sortable '(1 1 2007))))
		    (catch 'found
		      (dolist (holiday (holiday-find-date date holidays))
			(unless (string-match
				 (regexp-quote holiday-substitute-name)
				 (cadr holiday))
			  (throw 'found nil)))
		      t))
		   ((>= sotable-date
			(eval-when-compile
			  (holiday-make-sortable '(12 27 1985))))
		    (not (or (= (calendar-day-of-week date) 0)
			     (holiday-find-date date holidays)))))
	      (setq nationals (cons (list date holiday-national-name)
				    nationals))))))
      (setq holidays (nconc holidays
			    (filter-visible-calendar-holidays nationals)))))
  holidays)

(defvar calendar-weekend '(0)
  "*List of days of week to be marked as holiday.")

(defvar calendar-weekend-marker nil)

(defun calendar-mark-weekend ()
  (let ((m displayed-month)
	(y displayed-year))
    (increment-calendar-month m y -1)
    (calendar-for-loop
     i from 1 to 3 do
     (let ((sunday (- 1 (calendar-day-of-week (list m 1 y))))
	   (last (calendar-last-day-of-month m y)))
       (while (<= sunday last)
	 (mapcar (lambda (x)
		   (let ((d (+ sunday x)))
		     (and (<= 1 d)
			  (<= d last)
			  (mark-visible-calendar-date
			   (list m d y)
			   calendar-weekend-marker))))
		 calendar-weekend)
	 (setq sunday (+ sunday 7))))
     (increment-calendar-month m y 1))))


(provide 'japanese-holidays)

;;; japanese-holidays.el ends here
