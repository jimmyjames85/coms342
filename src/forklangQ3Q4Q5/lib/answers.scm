(define reload
  (lambda ()
    (require "src/forklang/lib/q3.scm")))

/* Recursive function that subtracts 1 every time from x until it reaches 0.
   I used this to increase the possibility of a data race occuring. This 
   always returns 0.*/

(define delay
  (lambda (x)
    (if (< x 1) 0
	(delay (- x 1)))))

/* Adds 3 to ptr value*/
(define threadAdd3
  (lambda (ptr)
    (set! ptr (+ (delay 342) (deref ptr) (delay 342) 3 (delay 342)))))

/* Adds 7 to ptr value*/
(define threadAdd7
  (lambda (ptr)
    (set! ptr (+ (delay 342) (deref ptr) (delay 342) 7 (delay 342)))))

/* Multiplies ptr value by two*/
(define threadDouble
  (lambda (ptr)
    (set! ptr (+ (delay 342) (deref ptr) (delay 342) (deref ptr) (delay 342) ))))

/* Multiplies ptr value by three*/
(define threadTriple
  (lambda (ptr)
    (set! ptr (+ (delay 342) (deref ptr) (delay 342) (deref ptr) (delay 342) (deref ptr) (delay 342)))))

/*Question 3a Program 1 (Data Race Occurs)*/
(define q3a1
  (lambda ()
    (let ((x (ref 1)))
      (let ((dummy
	     (fork
	      (threadAdd3 x)
	      (threadAdd7 x)
	      )))
	(deref x)))))

/*Question 3a Program 2 (Data Race Occurs)*/
(define q3a2
  (lambda ()
    (let ((x (ref 3)))
      (let ((dummy
	     (fork
	      (threadDouble x)
	      (threadTriple x)
	      )))
	(deref x)))))

/*Question 3b Program 1 (Lock/Unlock No Data Race)*/
(define q3b1
  (lambda ()
    (let ((x (ref 1)))
      (let ((dummy
	     (fork
	      (list (lock x) (threadAdd3 x) (unlock x))
	      (list (lock x) (threadAdd7 x) (unlock x))
	      )))
	(deref x)))))


/*Question 3b Program 2 (Lock/Unlock No Data Race)*/
(define q3b2
  (lambda ()
    (let ((x (ref 3)))
      (let ((dummy
	     (fork
	      (list (lock x) (threadDouble x) (unlock x))
	      (list (lock x) (threadTriple x) (unlock x))
	      )))
	(deref x)))))

/*Question 3c Program 1 (Sychronized No Data Race)*/
(define q3c1
  (lambda ()
    (let ((x (ref 1)))
      (let ((dummy
	     (fork
	      (synchronized x (threadAdd3 x))
	      (synchronized x (threadAdd7 x))
	      )))
	(deref x)))))


/*Question 3c Program 2 (Sychronized No Data Race)*/
(define q3c2
  (lambda ()
    (let ((x (ref 3)))
      (let ((dummy
	     (fork
	      (synchronized x (threadDouble x))
	      (synchronized x (threadTriple x))
	      )))
	(deref x)))))



(define threadLockAdd13
  (lambda (ptr)
    (let ((dummy (list (lock ptr) 
		       (set! ptr (+ (delay 342) (deref ptr) (delay 342) 13 (delay 342))))))
      (car (cdr dummy)))))

(define threadLockAdd13Unlock
  (lambda (ptr)
    (let ((dummy (list (lock ptr) 
		       (set! ptr (+ (delay 342) (deref ptr) (delay 342) 13 (delay 342)))
		       (unlock ptr))))
      (car (cdr dummy)))))


(define threadLockDouble
  (lambda (ptr)
    (let ((dummy (list (lock ptr) 
		       (set! ptr (+ (delay 342) (deref ptr) (delay 342) (deref ptr) (delay 342))))))
      (car (cdr dummy)))))

(define threadLockDoubleUnlock
  (lambda (ptr)
    (let ((dummy (list (lock ptr) 
		       (set! ptr (+ (delay 342) (deref ptr) (delay 342) (deref ptr) (delay 342)))
		       (unlock ptr))))
      (car (cdr dummy)))))

/*Question 5a Program 1 (Dead Lock)*/
(define q5a1
  (lambda ()
    (let ((x (ref 1))) 
      (let ((dummy 
	     (fork
	      (threadLockAdd13 x)
	      (threadLockAdd13 x))))
	(unlock x))
	)))

/*Question 5a Program 2 (Dead Lock)*/
(define q5a2
  (lambda ()
    (let ((x (ref 1))) 
      (let ((dummy 
	     (fork
	      (threadLockDouble x)
	      (threadLockDouble x))))
	(unlock x))
	)))


/*Question 5b Program 1 (No Dead Lock)*/
(define q5b1
  (lambda ()
    (let ((x (ref 1))) 
      (let ((dummy 
	     (fork
	      (threadLockAdd13Unlock x)
	      (threadLockAdd13Unlock x))))
	(deref x)))))


/*Question 5b Program 2 (No Dead Lock)*/
(define q5b2
  (lambda ()
    (let ((x (ref 1))) 
      (let ((dummy 
	     (fork
	      (threadLockDoubleUnlock x)
	      (threadLockDoubleUnlock x))))
	(deref x)))))
