(define fact
  (lambda (n)
    (if (> n 1)
	(* n (fact (- n 1)))
	1)))



(define ping 
	(actor (sender num)
		(if
			(> num 0) (send sender (self) (- num 1))  
			(stop)
		)
	)
)

(define pong 
	(actor (sender num)
		(if
			(> num 0) (send sender (self) (- num 1))  
			(stop)
		)
	)
) 
