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

(define append
  (lambda (lst1 lst2 )
    (if (null? lst1 ) lst2
	(if (null? lst2 ) lst1
	    (cons (car lst1 ) (append (cdr lst1 ) lst2 ))))))

(define max
  (lambda (a b)
    (if (< a b) b
	a)))

(define min
  (lambda (a b)
    (if (> a b) b
	a)))


(define gcd 
  (lambda (a b)
    (if (> a b) (gcd (- a b) b)
	(if (< a b) (gcd (- b a) a)
	    a))))

(define gcds
  (lambda (lstA lstB)
    (if (null? lstA) (list )
	(cons (gcd (car lstA) (car lstB)) (gcds (cdr lstA) (cdr lstB)) ))))


(define flipBit (lambda (bit)
		  (* (- bit 1) (- bit 1)))) 

(define bitRow
  (lambda (n startBit)
    (if (< n 1) (list )
	(cons startBit (bitRow (- n 1) (* (- startBit 1) (- startBit 1)))))))

(define forEachCond
  (lambda (lst op condOp)
    (if (null? lst) (list )
	(if (condOp (car lst)) (cons (op (car lst)) (forEachCond (cdr lst) op condOp))
	    (forEachCond (cdr lst) op condOp)))))

(define forEach 
  (lambda (lst op)
    (forEachCond lst op (lambda (x) #t))))
	    
(define add2 (lambda (x) (+ x 2)))
(define list1 (list 3 4 2))
(forEach list1 add2)

(define board 
  (lambda (n)
    (if (< n 1) (list )
	(if (= n 1) (list (list 0))
	    (forEach (cons (forEach (car (board (- n 1))) flipBit) (board (- n 1))) 
		 (lambda (row)
		   (cons (flipBit (car row)) row)))))))





((((((lambda (u) (lambda (v) (lambda (w) (lambda (x) (lambda (y) (list w y v x u)))))) "h") "n")"l")"c")"u")

(define leaf
  (lambda (leafval) 
    (list leafval)))

(define interior
  (lambda (rootval leftTree rightTree)
    (list rootval leftTree rightTree)))

(define traverse 
  (lambda (tree op combine)
    (if (null? (cdr tree)) (op (car tree))
	(combine (op (car tree)) (traverse (car (cdr tree)) op combine)  (traverse (car (cdr (cdr tree))) op combine)))))


(traverse t2 add2 combine3)
(+ 3 4 6 7 5 8 9)

(define combine3 
  (lambda (a b c) 
    (+ a b c)))

(define t2 (interior 1 (interior 2 (leaf 4) (leaf 5)) (interior 3 (leaf 6) (leaf 7))))
(define add2 (lambda (a) (+ a 2)))


	(append (append (list (car tree)) (traverse (cdr tree))) (traverse (cdr (cdr tree)))))))


  )))

 (traverse (cdr (cdr tree)))))))



	   (append (traverse )
	   ())
    ))

(define t3 (interior "root" (leaf "leftUpperTerminal") (interior "rightNode" (leaf "leftTerminal") (leaf "rightTerminal"))))

(list? (list 3))

(append (list  3) (list "hi'"))


