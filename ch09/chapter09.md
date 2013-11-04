### Chapter 9 Lambda
```Scheme
(define (add-three number)
  (+ number 3))
(define (add-three-to-each sent)
  (every add-three sent))
```

* Lambda is the name of a special form that generates procedures. It takes some information about the function you want to create as arguments and it returns the procedure.

```Scheme
(define (add-three-to-each sent)
  (every (lambda (number) (+ number 3)) sent))
```

* As we said, lambda is a special form. This means, as you remember, that its arguments are not evaluated when you invoke it. The first argument is a sentence containing the formal parameters; the second argument is the body. What lambda returns is an unnamed procedure.

#### Procedures That Return Procedures
```Scheme
(define (make-adder num)
  (lambda (x) (+ x num)))
```

```Scheme
(define (same-arg-twice fn)
  (lambda (arg) (fn arg arg)))
```

```Scheme
(define (flip fn)
  (lambda (a b) (fn b a)))
```

#### The Truth about Define
* That's because the notation we've been using with define is an abbreviation that combines two activities: creating a procedure and giving a name to something.

* When we say
```Scheme
(define (square x) (* x x))
```
it's actually an abbreviation for 
```Scheme
(define square (lambda (x) (* x x)))
```

#### The Truth about Let
```Scheme
(define (roots a b c)
  (roots1 a b c (sqrt (- (* b b) (* 4 a c)))))
(define (roots1 a b c discriminant)
  (se (/ (+ (- b) discriminant) (* 2 a))
      (/ (- (- b) discriminant) (* 2 a))))
```
```Scheme
(define (roots a b c)
  (let ((discriminant (sqrt (- (* b b) (* 4 a c)))))
    (se (/ (+ (- b) discriminant) (* 2 a))
        (/ (- (- b) discriminant) (* 2 a)))))
```
```Scheme
(define (roots a b c)
  ((lambda (discriminant)
     (se (/ (+ (- b) discriminant) (* 2 a))
         (/ (- (- b) discriminant) (* 2 a))))
   (sqrt (- (* b b) (* 4 a c)))))
```
* Just as the notation to define a procedure with parentheses around its name is an abbreviation for a define and a lambda, the let notation is an abbreviation for a lambda and an invocation.

#### Name Conflicts

#### Named and Unnamed FUnctions
```Scheme
(define pi 3.141592654)
(define (circle-area radius)
  (* pi radius radius))
(define (circumference radius)
  (* 2 pi radius))
(define (sphere-surface-area radius)
  (* 4 pi radius radius))
(define (sphere-volume radius)
  (* (/ 4 3) pi radius radius radius))
```

* If we're going to use a procedure more than once, and if there's a meaningful name for it that will help clarify the program, then we define the procedure with define and give it a name.
```Scheme
(define (square x) (* x x))
```

* This idea of naming something and forgetting the details of its implementation is what we've been calling "abstraction."

* On the other hand, if we have an unimportant procedure that we're using only once, we might as well create it with lambda and without a name.

```Scheme
(define (backwards wd) (accumulate (lambda (a b) (word b a)) wd))
```

#### Pitfalls
```Scheme
(define (keep-h sent)
  (keep (lambda (wd) (member? 'h wd)) sent))
```

```Scheme
(define (keeper letter)
  (lambda (sent)
    (keep (lambda (wd) (member? letter wd)) sent)))
(define keep-h (keeper 'h))
```
