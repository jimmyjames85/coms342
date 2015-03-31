(define reload
  (lambda ((b="342"))
    (list b (require "src/forklang/lib/ptest.scm"))))

/*
Write a function multiply that takes two numbers up and low and computes the 
multiplication of (up)*(up-1)*..*(low). For concurrent computation of the 
factorial of n, fork two threads where one computes (n)*(n-1)*(n-2)*..*(k) 
and the other thread computes (k-1)*(k-2)*..*(1), where k is n divided by 2. 
Finally result of two threads of the fork expression are multiplied together 
to produce the final result.
*/


(define multiply 
  (lambda (up low (dummy = ""))
    (if (< up low) (multiply low up)
	(if (= up low) low
	    (* up (multiply (- up 1) low))))))



(define even?
  (lambda (n (dummy =""))
    (if (= n 1) #f
	(if (= n (- 0 1)) #f
	    (if (= n 0) #t
		(if (> n 0) (even? (- n 2))
		    (even? (- 2 n))))))))

(define factorial 
    (lambda (n (dummy = ""))
	(let 
	    ((lst (fork  
		   (multiply (/ (if (even? n) n (- n 1) ) 2) 1)
		   (multiply n (+ (/ (if (even? n) n (- n 1) ) 2) 1))
		   )))
	  (* (car lst) (cdr lst)))))


