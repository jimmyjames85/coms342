(define ev (event (a b)))
(when ev do (+ a b))
(announce ev ( 2 3))

(define ev (event (a b)))
(when ev do (+ a b))
(announce ev ( 2 3))
(when ev do (* a b))
(announce ev (2 3))

(let ((z (event(a b)))) (announce z ( 1 2)) )
$unit (no registered observer)


(let ((z (event(a b)))) (when z do (+ a b)) )
$unit (no announcement)

(let ((ev (event(a b)))) (let ((dummy1 (when ev do (+ a b)))) (announce ev (1 2))))
$3

(let ((ev (event(a b)))) (let ((dummy (announce ev (1 2)))) (when ev do (+ a b))))
$unit
//announce before registration 

(let ((ev (event(a b)))) (let ((dummy1 (when ev do (+ a b)))(dummy2 (when ev do (* a b)))) (announce ev (3 2))))
$6
//value of the announce expression is the value of the last observer


(let ((ev (event(a b)))(dummy (when ev do (+ a b)))) (announce ev (1 2)) )
$ dynamic error: no binding for ev.


