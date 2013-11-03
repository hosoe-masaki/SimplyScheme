## Part III Functions as Data
```Scheme
(define (make-conjugator prefix ending)
  (lambda (verb) (sentence prefix (word verb ending))))
```

### Chapter 8 Higher-Order Functions
```Scheme
(define (two-firsts send)
  (se (first (first sent))
      (first (last sent))))

(define (three-firsts send)
  (se (first (first send))
      (first (first (bf sent)))
      (first (last sent))))
```

#### Every
```Scheme
(define (first-letters send)
  (every first seng))
```

```Scheme
(define (plural noun)
  (if (equal? (last noun) 'y)
      (word (bl noun) 'ies)
      (word noun 's)))
```

```Scheme
(define (double letter) (word letter letter))
```

```Scheme
(define (sent-of-first-two wd)
  (se (first wd) (first (bf wd))))
```

* A function that takes another function as one of its arguments, as every does, is called a *higher-order function*.

#### A Pause for Relflection

#### Keep

#### Accumulate

#### Combining Higher-Order Functions
```Scheme
(define (add-numbers sent)
  (accumulate + (keep number? sent)))
```

```Scheme
(define (always-one arg)
  1)
(define (count sent)
  (accumulate + (every always-one sent)))
```

```Scheme
(define (acronym phrase)
  (accmulate word (every first (keep real-word? phrase))))
```

#### Choosing the Right Tool
* Every transforms each element of a word or sentence individually. The result sentence usually contains as many elements as the argument.

* Keep selects certain elements of a word or sentence and discards the others. The elements of the result are elements of the argument, without transformation, but the result maybe smaller than the original.

* Accumulate transforms the entire word or sentence into a single result by combining all of the elements in some way.

|function|purpose|first argument is a ...|
|every|transform|one-argument *transforming* function|
|keep|select|one-argument *predicate* function|
|accumulate|combine|two-argument *combining* function|

#### First-Class Functions and First-Class Sentences

#### Repeated
* The procedure repeated takes two arguments, a procedure and a number, and returns a new procedure. The returned procedure is one that invokes the original procedure repeatedly.

```Scheme
(define (item n sent)
  (first ((repeated bf (- n 1)) sent)))
```

#### Pitfalls
```Scheme
(define (any-numbers? sent)
  (not (empty? (keep number? sent))))
```

```Scheme
(define (spell-digit digit)
  (item (+ 1 digit)
        '(zero one two three four five six seven eight nine)))
```

* Remember that every expects its first argument to be a function of just one argument.

```Scheme
(define (beatle-number n)
  (if (or (< n 1) (> n 4))
      '()
      (item n '(john paul george ringo))))
```

* if every's argument procedure returns an empty *word*, it will appear in the result.
