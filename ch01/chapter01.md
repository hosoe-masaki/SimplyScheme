## Introduction: Functions
### Chapter 1 Showing Off Scheme

#### Talking to Scheme
```Scheme
6

(+ 4 7)
(- 23 5)
(+ 5 6 7 8)

(word 'comp 'uter)
```

#### Recovering from Typing Errors
```Scheme
(+ 2 a)
```

#### Exiting Scheme
```Scheme
(exit)
```

#### Example: Acronyms
```Scheme
(define (acronym phrase)
  (accumulate word (every first phrase)))

(define (acronym phrase)
  (accumulate word (every first (keep real-word? phrase))))
(define (real-word? wd)
  (not (member? wd '(a the an if of and for to with))))
```

#### Example: Pig Latin
```Scheme
(define (pigl wd)
  (if (member? (first wd) 'aeiou)
      (word wd 'ay)
      (pigl (word (butfirst wd) (first wd)))))

(every pigl '(the ballad of john and yoko))
```

#### Example: Ice Cream Choices
```Scheme
(define (choices menu)
  (if (null? menu)
      '(())
      (let ((smaller (choices (cdr menu))))
        (reduce append
                (map (lambda (item) (prepend-every item smaller))
                     (car menu))))))
(define (prepend-every item lst)
  (map (lambda (choice) (se item choice)) lst))
```

#### Example: Combinations from a Set
```Scheme
(define (combinations size set)
  (cond ((= size 0) '(()))
        ((empty? set) '())
        (else (append (prepend-every (first set)
                                     (combinations (- size 1)
                                                   (butfirst set)))
                      (combinations size (butfirst set))))))
```

#### Example: Factorial
```Scheme
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))
```
