(define ev (event (a b)))
(define w1 (when ev do (+ 0 3) 3) )
(define w1 (when ev do (+ 2 0) 2) ) 
(define w1 (when ev do (+ 7 0) 7) )
(define w1 (when ev do (+ 1 0) 1) )
(define w1 (when ev do "alsoSeven" 7) )
(list (announce ev (21 2) Low) (unregister ev 3) "Loaded Succesfully")


