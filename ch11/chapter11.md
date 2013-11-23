## Part IV Recursion
```Scheme
(define (game low high)
  (let ((guess (average low high)))
    (cond ((too-low? guess) (game (+ guess 1) high))
          ((too-high? guess) (game low (- guess 1)))
          (else '(I win!)))))
```

### Chapter 11 Introduction to Recursion
* Inthe next few chapters we're going to talk about *recursion:* solving a big problem by reducing it to a similar, smaller subproblem.

* The explanation in this chapter is based on the *combining method.*

#### A Separate Procedure for Each Length

* We'll write a version of downup that works only for one-letter words:
```Scheme
(define (downup1 wd)
  (se wd))
```

* New let's see if we can do two-letter words:
```Scheme
(define (downup2 wd)
  (se wd (first wd) wd))
```

```Scheme
(define (downup3 wd)
  (se wd
      (bl wd)
      (first wd)
      (bl wd)
      wd))
```

#### Use What You Have to Get What You Need
```Scheme
(define (downup3 wd)
  (se wd (downup2 (bl wd)) wd))
(define (downup4 wd)
  (se wd (downup3 (bl wd)) wd))
```

```Scheme
(define (downup59 wd)
  (se wd (downup58 (bl wd)) wd))
```

```Scheme
(define (downup2 wd)
  (se wd (downup1 (bl wd)) wd))
```

#### Notice That They're All the Same
* This is a lot of repetitive, duplicated, and redundant typing. Since these procedures are all basically the same, what we'd like to do is combine them into a single procedure:
```Scheme
(define (downup wd)
  (se wd (downup (bl wd)) wd))
```

#### Notice That They're Almost All the Same
* So if we collapse all the numbered downups into a single procedure, we have to treat one-letter words as a special case:
```Scheme
(define (downup wd)
  (if (= (count wd) 1)
      (se wd)
      (se wd (downup (bl wd)) wd)))
```

#### Base Cases and Recursive Calls
* Downup illustrates the structure of every recursive procedure. There is a choice among expressions to evaluate: At least one is a *recursive* case, in which the procedure (e.g., downup) itself is invoked with a smaller argument; at least one is a *base* case, that is , one that can be solved without calling the procedure recursively.

* A recursive procedure doesn't work unless every possible argument can eventually be reduced to some base case.

* We've just said that there has to be a base case. It's also important that each recursive call has to get us somehow closer to the base case.

#### Pig Latin
```Scheme
(define (pigl0 wd)
  (word wd 'ay))
```

```Scheme
(define (pigl1 wd)
  (word (bf wd) (first wd) 'ay))
```

```Scheme
(define (pigl1 wd)
  (word (word (bf wd) (first wd))
        'ay))
```

```Scheme
(define (pigl1 wd)
  (pigl0 (word (bf wd) (first wd))))
```

```Scheme
(define (pigl2 wd)
  (pigl1 (word (bf wd) (first wd))))
```

```Scheme
(define (pigl3 wd)
  (pigl2 (word (bf wd) (first wd))))
```

```Scheme
(define (pigl wd)
  (if (member? (first wd) 'aeiou)
      (word wd 'ay)
      (pigl (word (bf wd) (first wd)))))
```

* 全部子音の単語はあるのか?

#### Problems for You to Try
```Scheme
(define (explode wd)
  (if (= (count wd) 1)
      (se wd)
      (se (first wd) (explode (bf wd)))))
```

```Scheme
(define (letter-pairs wd)
  (if (<= (count wd) 2)
      (se wd)
      (se (word (first wd) (first (bf wd))) (letter-pairs (bf wd)))))
```

#### Our Solutions
```Scheme
(define (explode0 wd)
  '())

(define (explode1 wd)
  (se wd))

(define (explode2 wd)
  (se (first wd) (last wd)))

(define (explode3 wd)
  (se (first wd) (first (bf wd)) (last wd)))
```

```Scheme
(define (explode3 wd)
  (se (first wd) (explode2 (bf wd))))

(define (explode4 wd)
  (se (first wd) (explode3 (bf wd))))

(define (explode2 wd)
  (se (first wd) (explode1 (bf wd))))

(define (explode1 wd)
  (se (first wd) (explode0 (bf wd))))
```

``Scheme
(define (explode wd)
  (if (empty? wd)
      '()
      (se (first wd) (explode (bf wd)))))
```

```Scheme
(define (letter-pairs0 wd)
  '())

(define (letter-pairs1 wd)
  '())

(define (letter-pairs2 wd)
  (se wd))

(define (letter-pairs3 wd)
  (se (bl wd) (bf wd)))

(define (letter-pairs4 wd)
  (se (bl (bl wd))
      (bl (bf wd))
      (bf (bf wd))))
```

```Scheme
(define (letter-pairs4 wd)
  (se (bl (bl wd))
      (letter-pairs3 (bf wd))))

(define (letter-pairs5 wd)              ;; wrong
  (se (bl (bl wd))
      (letter-pairs4 (bf wd))))
```

```Scheme
(define (first-two wd)
  (word (first wd) (first (bf wd))))

(define (letter-pairs4 wd)
  (se (first-two wd) (letter-pairs3 (bf wd))))

(define (letter-pairs5 wd)
  (se (first-two wd) (letter-pairs4 (bf wd))))

(define (letter-pairs wd)
  (if (<= (count wd) 1)
      '()
      (se (first-two wd)
          (letter-pairs (bf wd)))))

(define (letter-pairs2 wd)
  (se (first-two wd)
      (letter-pairs1 (bf wd))))

(define (letter-pairs3 wd)
  (se (first-two wd)
      (letter-pairs2 (bf wd))))
```

#### Pitfalls
* Every recursive procedure must include two parts: one or more recursive cases, in which the recursion reduces the size of the problem, and one or more base cases, in which the result is computable without recursion.

* Don't be too eager to write the recursive procesure.
