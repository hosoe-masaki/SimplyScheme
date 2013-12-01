### Chaper 12 The Leap of Faith

#### From the Combining Method to the Leap of Faith

#### Example: Reverse
```Scheme
(define (reverse wd)            ;; unfinished
  (word (last wd)
        (reverse (bl wd))))
```

#### The Leap of Faith
* The leap of faith method is the assumption that the procedure we're in the middle of writing already works. That is, if we're thinking about writing a reverse procedure that can compute (reverse 'paul), we assume that (reverse 'aul) will work.

#### The Base Case
```Scheme
(define (reverse wd)
  (if (= (count wd) 1)
      wd
      (word (last wd)
            (reverse (bl wd)))))
```

#### Example: Factorial
```Scheme
(define (factorial n)           ;; first version
  (* n factorial (- n 1))))
```

```Scheme
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
```

#### Likely Guesses for Smaller Subproblems
* To make the leap of faith method work, we have to find a smaller, similar subproblem whose solution will help solve the given problem.

#### Example: Downup
```Scheme
(define (downup wd)             ;; no base case
  (se wd (downup (bl wd)) wd))
```

#### Example: Evens
```Scheme
(define (losing-evens sent)     ;; no base case
  (se (losing-evens (bl sent))
      (last sent)))
```

```Scheme
(define (losing-evens sent)
  (if (empty? sent)
      '()
      (se (losing-evens (bl sent))
          (last sent))))
```

```Scheme
(define (evens sent)            ;; better version
  (cond ((empty? sent) '())
        ((odd? (count sent))
         (evens (bl sent)))
        (else (se (evens (bl sent))
                  (last sent)))))
```

```Scheme
(define (evens sent)
  (if (<= (count sent) 1)
      '()
      (se (first (bf sent))
          (evens (bf (bf sent))))))
```

#### Simplifying Base Cases
* In general, we recommend using the smallest possible base case argument, because that usually leads to the simplest procedures.

```Scheme
(define (reverse wd)
  (if (= (count wd) 1)
      wd
      (word (last wd)
            (reverse (bl wd)))))
```

```Scheme
(define (reverse wd)
  (if (empty? wd)
      ""
      (word (last word)
            (reverse (bl word)))))
```

```Scheme
(define (downup wd)
  (if (= (count wd) 1)
      (se wd)
      (se wd (downup (bl wd)) wd)))
```

```Scheme
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
```

```Scheme
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))
```

```Scheme
(define (letter-pairs wd)
  (if (<= (count wd) 1)
      '()
      (se (first-two wd)
          (letter-pairs (bf wd)))))

(define (first-two wd)
  (word (first wd) (first (bf wd))))
```

* the base case must handle anything that's too small to fit the needs of the recursive case.

#### Pitfalls
* The value returned inthe base case of your procedure must be in the range of the function you are representing.
