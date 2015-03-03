/* Question 1.a ) Write your solution to question 1a here. 


program ->
exp ->
callexp ->
'(' exp exp* ')' ->
'(' callexp exp* ')' ->
'(' '(' exp exp* ')' exp* ')' ->
'(' '(' lambdaexp exp* ')' exp* ')' ->
'(' '(' '(' Lambda '(' Identifier* ')' exp ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' Identifier* ')' exp ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' Identifier ')' exp ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' Letter ')' exp ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' exp ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' lambdaexp ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' Lambda '(' Identifier* ')' exp ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' Identifier* ')' exp ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' Identifier ')' exp ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' Letter ')' exp ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' exp ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' multexp ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' exp (exp)+ ')' ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' varexp (exp)+ ')' ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' Identifier (exp)+ ')' ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' Letter (exp)+ ')' ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' (exp)+ ')' ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' exp ')' ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' varexp ')' ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' Identifier ')' ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' Letter ')' ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' exp* ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' exp ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' numexp ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' Number | Number dot Number ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' Number ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' Digit+ ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' Digit ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' '3' ')' exp* ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' '3' ')' exp ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' '3' ')' numexp ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' '3' ')' Number | Number Dot Number ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' '3' ')' Number ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' '3' ')' Digit+ ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' '3' ')' Digit ')' ->
'(' '(' '(' 'lambda' '(' 'x' ')' '(' 'lambda' '(' 'y' ')' '(' '*' 'x' 'y' ')' ')' ')' '3' ')' '4' ')' ->







*/

/* Question 1.b ) Write your solution to question 1b here. 

free variables: op lst2
bound variables:  lst

*/


/* Question 2 ) Write your solution to question 2 here. */
(define py  (lambda (c) (lambda (b) (lambda (a)	(- (+ (* a a) (* b b)) (* c c))))))

/* Question 3 ) Write your solution to question 3 here. */
(define merge
  (lambda (lst1 lst2 check)
    (if (null? lst1) lst2
	(if (null? lst2) lst1
	    (if (check (car lst1) (car lst2)) 
		(cons (list (car lst1) (car lst2)) (merge (cdr lst1) (cdr lst2) check))
		(cons (car lst1) (cons (car lst2) (merge (cdr lst1) (cdr lst2) check))))))))

/* Question 4 ) Implement this question by modifying source files in funclang directory. */
