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



(define factorial 
    (lambda (n (dummy = ""))
	(let (
	      (lst (fork  (multiply (/ n 2) 1) (multiply n (+ (/ n 2) 1)) )  ))
	  (* (car lst) (car (cdr lst))))))



