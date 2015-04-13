10.1.1
/*lambda Average*/
(lambda (a b : (num num -> num)) (/ (+ a b) 2))

/*lambda Max (in list form) */
(lambda (a b : (num num -> List<num>)) (if (> a b) (list : num a b ) (list : num b a) ))

/* callexp of Max (in list form) */
((lambda (a b : (num num -> List<num>)) (if (> a b) (list : num a b ) (list : num b a) )) 2 (+ 30 4))


10.1.2

/*ill-typed lambadexp */
(lambda (a : (num -> bool)) (if (< a 0) a 0 ))

/*ill-typed callexp */
((lambda (a : (num -> bool)) (> a 0)) "hello world")


10.2.1
(let (( x : num 243) (y : num 342) (z : bool #f)) (if z x y))

(let (( x : String "Hello") ( y : String " World") (z : String " !!!")) (list : String x y z))

(let (( pi : num 3.14159) (r : num 20) ) (* pi r r))

10.2.2
(let (( x : String "We ") ( y : String "are in ComS ") (z : num 342)) (list : String x y z))

(let (( pi : num 3.14159) (r : String 20) ) (* pi r r))


10.3.1
(letrec ((fact : (num -> num) (lambda (r : (num -> num)) (if (= r 0) 1 (* r (fact (- r 1)))) ))) (fact 3))

(letrec ((sum : (List<num> -> num) (lambda (lst : (List<num> -> num)) (if (null? (cdr lst)) (car lst) (+ (car lst) (sum (cdr lst))))))) (sum (list : num 3 4 2))) 

(letrec ((min : (List<num> -> num) (lambda (lst : (List<num> -> num)) (if (null? (cdr lst)) (car lst) (if (< (car lst) (min (cdr lst))) (car lst) (min (cdr lst))))))) (min (list : num 3 4 2))) 

10.3.2
(letrec ((max : (List<num> -> num) (lambda (lst : (List<num> -> num)) (if (null? (cdr lst)) (car lst) (if (> (car lst) (max (cdr lst))) (car lst) (max (cdr lst))))))) (max (list : String "3" "4" "2"))) 

(letrec ((num2Str : (num -> String) (lambda (n : (List<num> -> String)) n))) (num2Str 3)) 


10.4.1

(list : num (+ 300 40 2) (if (< 34 2) 123 342))

(list : List<num> (list : num 3 4 2) (cdr (list : num 3 2 4)))

(list : List<num>  (list : num 3 (car (cons 4 (list : num 2)))) (list : num 2))


10.4.2

(list : num 3 45 21 "bad string val")

(list : List<num> (list : num 3 4 2) (cons 3 (cdr (list : num 3 2 4))))


10.5.1

(ref : num (deref (car (list : Ref num (ref : num 3) (ref : num 4) (ref : num 2)))))

(let ((lst : List<Ref num> (list : Ref num (ref : num 3) (ref : num 4) (ref : num 2)))) (ref : Ref num (car lst)))

(let ((lst : List<Ref num> (list : Ref num (ref : num 3) (ref : num 4) (ref : num 2)))) (+ (deref (car lst)) (deref (car (cdr lst))) (deref (car (cdr (cdr lst))))))


10.5.2

(let ((lst : List<Ref String> (list : Ref String (ref : String "3") (ref : String "4") (ref : String "2")))) (+ (deref (car lst)) (deref (car (cdr lst))) (deref (car (cdr (cdr lst))))))

(ref : num (deref (car (list : Ref num (ref : num 3) (ref : num 4) (ref : num 2) (ref : String "endList")))))




