## Part II Composition of Functions
```Scheme
(define (third-person verb)
  (sentence 'she (add-s verb))
```

### Chapter 3 Expressions
* The interaction between you and Scheme is called the "read-eval-print loop." Scheme reads what you type, *evaluates* it, and prints the answer, and then dows the same thing over again.
* Each question you type is called an *expression*.

*atom*(or *atomic expression*)
```Scheme
26
```

*compound expression
```Scheme
(+ 14 7)
```

* We sometimes call the expressions within a compound expression its *subexpressions*.

* Compound expressions tell Scheme to "do" a procedure
* You can *call* a procedure; you can *invoke* a procedure; or you can *apply* a procedure to some numbers or other values.

* In Scheme, everything is done by calling procedures, just as we've been doing here.

```Scheme
(+ (+ 2 3) (+ 4 5))
```

#### Little People
```Scheme
(- (+ 5 8) (+ 2 4))
```

* In fact, the *order of evaluation* of the argument subexpressions is not specified in Scheme; different implementations may do it in different orders.

* If an expression is atomic, Scheme just knows the value.

* Scheme ignores everything to the right of a semicolon, so semicolons can be used to indicate comments, as above.

#### Result Replacement

#### Plumbing Diagrams

#### Pitfalls
```Scheme
(square (cos 3))

(+ (* 2 (/ 14 7) 3)
   (/ (* (- (* 3 5) 3) (+ 1 1))
      (- (* 4 3) (* 3 2)))
   (- 15 18))
                                          
```
* Everything inside a pair of quotation mars is treated as one single *string*.