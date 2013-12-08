### Chapter 13 How Recursion Works

####  Little People and Recursion

#### Tracing
```Scheme
(define (double wd) (word wd wd))
```

```Scheme
(define (downup wd)
  (if (= (count wd) 1)
      (se wd)
      (se wd (downup (bl wd)) wd)))
```

```Scheme
(define (fib n)
  (if (<= n 2)
      1
      (+ (fib (- n 1))
         (fib (- n 2)))))
```

#### Pitfalls
