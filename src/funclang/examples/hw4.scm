// Name: 
// Procedures for Homework 4 
// Put this file in directory examples of your Funclang interpreter
// You can then load this file by typing the following on the command-line
// (require "build/funclang/examples/hw4.scm")

(fset 'eval-sexp   "\C-x\C-e")
(global-set-key (kbd "C-<return>") 'eval-sexp )
(defun match-paren (arg)
            "Go to the matching paren if on a paren; otherwise do nothing."
            (interactive "p")
            (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
                  ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
		  ))

(global-set-key (kbd "C-;") 'match-paren)
(load-file "~/.emacs.d/scheme/xscheme.el")
'(run-scheme)

;hw4 #3

(define pi 3.14159265)
(define fourByThree (/ 4.0 3.0))
(define volume
  (lambda (radius) 
  (* fourByThree pi radius radius radius)))

;hw4 #4

(define board
  (lambda (b)
    (lambda (r)
      (lambda (d)
	(list (list r b b r) (list b r r b) (list d r r d) (list r d d r))))))

(define boardz 
  (lambda (b d)
    (((board b) 0) d)))

(define board10
  (lambda (d)
    (boardz 1 d)))

(define board012
  (lambda ()
    (board10 2)))



;hw4 #5

(define sum
  (lambda (lst)
    (if (null? lst) 0
	(+ (car lst) (sum (cdr lst))))))

(define rev 
  (lambda (lst)
    (if (null? lst) lst
	(append (rev (cdr lst)) (list (car lst))))))

;helper method 

(define append
  (lambda (lst1 lst2 )
    (if (null? lst1 ) lst2
	(if (null? lst2 ) lst1
	    (cons (car lst1 ) (append (cdr lst1 ) lst2 ))))))

(define frequency
  (lambda (lst elem)
    (if (null? lst) 0
	(if (number? (car lst)) (if (= elem (car lst)) (+ 1 (frequency (cdr lst) elem))
				    (frequency (cdr lst) elem))
	    (frequency (cdr lst) elem)))))


"Loaded procedures for Homework 4"
