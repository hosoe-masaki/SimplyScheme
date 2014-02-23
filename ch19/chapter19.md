### Chapter 19 Implementing Higher-Order Functions

#### Generalizing Patterns
```Scheme
(define pi 3.141592654)
(define (square-area r) (* r r))
(define (circle-area r) (* pi r r))
(define (sphere-area r) (* 4 pi r r))
(define (hexagon-area r) (* (sqrt 3) 1.5 r r))
```

```Scheme
(define (area shape r) (* shape r r))
(define square 1)
(define circle pi)
(define sphere (* 4 pi))
(define hexagon (* (sqrt 3) 1.5))
```

#### The Every Pattern Revisited
```Scheme
(define (every fn sent)
  (if (empty? sent)
      '()
      (se (fn (first sent))
          (every fn (bf sent)))))
```

#### The Difference between Map and Every
```Scheme
(define (map fn lst)
  (if (null? lst)
      '()
      (cons (fn (car lst))
            (map fn (cdr lst)))))
```

#### Filter
```Scheme
(define (filter pred lst)
  (cond ((null? lst) '())
        ((pred (car lst))
         (cons (car lst) (filter pred (cdr lst))))
        (else (filter pred (cdr lst)))))
```

#### Accumulate and Reduce
```Scheme
(define (addup nums)
  (if (empty? nums)
      0
      (+ (first nums) (addup (bf nums)))))

(define (scrunch-words sent)
  (if (empty? sent)
      ""
      (word (first sent) (scrunch-words (bf sent)))))
```

```Scheme
(define (accumulate combiner stuff)             ;; first version
  (if (empty? (bf stuff))
      (first stuff)
      (combiner (first stuff)
                (accumulate combiner (bf stuff)))))
```

```Scheme
(define (accumulate combiner stuff)
  (cond ((not (empty? stuff)) (real-accumulate combiner stuff))
        ((member combiner (list + * word se append))
         (combiner))
        (else (error
               "Can't accumulate empty input with that combiner"))))

(define (real-accumulate combiner stuff)
  (if (empty? (bf stuff))
      (first stuff)
      (combiner (first stuff) (real-accumulate combiner (bf stuff)))))
```

#### Robustness
```Scheme
(define (accumulate combiner stuff)             ;; non-robust version
  (if (not (empty? stuff))
      (real-accumulate combiner stuff)
      (combiner)))
```

* A program that behaves politely when given incorrect input is called *robust*.

```Scheme
(define (even? num)                             ;; silly example
  (cond ((not (number? num)) (error "Not a number."))
        ((not (integer? num)) (error "Not an integer."))
        ((< num 0) (error "Argument must be positive."))
        (else (= (remainder num 2) 0))))
```

#### Higher-Order Functions for Structured Lists
```Scheme
(define (deep-pigl structure)
  (cond ((word? structure) (pigl structure))
        ((null? structure) '())
        (else (cons (deep-pigl (car structure))
                    (deep-pigl (cdr structure))))))
```

```Scheme
(define (deep-map f structure)
  (cond ((word? structure) (f structure))
        ((null? structure) '())
        (else (cons (deep-map f (car structure))
                    (deep-map f (cdr structure))))))
```

#### The Zero-Trip Do Loop

#### Pitfalls
