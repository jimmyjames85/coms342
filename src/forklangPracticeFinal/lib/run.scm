(define pi "Pi is 3.14159")

(define fact
  (lambda (n)
    (if (> n 1)
	(* n (fact (- n 1)))
	1)))

(define fork2Fact  
  (lambda (refToPairVal)    
    (fork
	  (fact (car (list (car (deref refToPairVal)) (set! refToPairVal (cdr (deref refToPairVal))) )))
	  (fact (car (list (car (deref refToPairVal)) (set! refToPairVal (cdr (deref refToPairVal))) )))
	  (fact (car (list (car (deref refToPairVal)) (set! refToPairVal (cdr (deref refToPairVal))) )))
	  (fact (car (list (car (deref refToPairVal)) (set! refToPairVal (cdr (deref refToPairVal))) )))
	  (fact (car (list (car (deref refToPairVal)) (set! refToPairVal (cdr (deref refToPairVal))) )))
	  )))

(define fork2FactWithLock
  (lambda (refToPairVal)    
    (fork
	  (fact (car (cdr (list (lock refToPairVal) (car (deref refToPairVal)) (set! refToPairVal (cdr (deref refToPairVal))) (unlock refToPairVal)  ))))
	  (fact (car (cdr (list (lock refToPairVal) (car (deref refToPairVal)) (set! refToPairVal (cdr (deref refToPairVal))) (unlock refToPairVal)  ))))
	  (fact (car (cdr (list (lock refToPairVal) (car (deref refToPairVal)) (set! refToPairVal (cdr (deref refToPairVal))) (unlock refToPairVal)  ))))
	  (fact (car (cdr (list (lock refToPairVal) (car (deref refToPairVal)) (set! refToPairVal (cdr (deref refToPairVal))) (unlock refToPairVal)  ))))
	  (fact (car (cdr (list (lock refToPairVal) (car (deref refToPairVal)) (set! refToPairVal (cdr (deref refToPairVal))) (unlock refToPairVal)  ))))
	  )))


(define runFork2Fact  
  (lambda ()
    (let ((vals (ref (list 10 6 2 4 8)))) 
      (list 
       (fork2Fact vals)
       (deref vals)))))

(define p1 runFork2Fact)




(define p2
  (lambda ()
    (let ((x (ref 0)))
      (car (cdr (list
       (fork
	(list (lock x) (set! x (+ 1 (deref x))) (unlock x))
	(list (lock x) (set! x (+ 1 (deref x))) (unlock x))
       )
       (deref x)))))))




(define p3
  (lambda ()
    (let ((x (ref 0)))
      (car (cdr (list
       (fork
	(list (set! x (+ (fact 8) (deref x))) )
	(list (set! x (+ (fact 10) (deref x))) )
       )
       (deref x)))))))



(let ((x (ref 0))) (let ((y (lock x))) (set! x (+ 1 (deref x)))))
none


(let ((x (ref 2)) (y (ref 1))) 
	(fork (set! x (+ 1 (deref x))) (set! y (+ 1 (deref x))) ))
data race



(let ((x (ref 2)))
		(let ((y x)) 
			(fork (set! x (+ 1 (deref y))) (deref y)) ))
data race



(let ((x (ref 0))(y (ref 0))) 
		(fork (lock x) (lock y)) )

none



(let ((x (ref 2)) (y (ref 1))) 
  (fork 
   (let ((z (lock x))) (set! x (+ 1 (deref x))) )
   (let ((z (lock y))) (set! y (+ 1 (deref x))) )))

datarace

