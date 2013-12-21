### Chapter 14 Common Patterns in Recursive Procedures

#### The Every Pattern
```Scheme
(define (square-sent sent)
  (if (empty? sent)
      '()
      (se (square (first sent))
          (square-sent (bf sent)))))

(define (pigl-sent sent)
  (if (empty? sent)
      '()
      (se (pigl (first sent))
          (gigl-sent (bf sent)))))
```

* The patter here is pretty clear. Our recursive case will do something straightforward to the first of the sentence, such as squareing it or pigling it, and we'll combine that with the result of a recursive cal on the butfirst of the sentence.

```Scheme
(define (letter-pairs wd)
  (if (= (count wd) 1)
      '()
      (se (word (first wd) (first (bf wd)))
          (letter-pairs (bf wd)))))
```

```Scheme
(define (disjoint-pairs wd)
  (cond ((empty? wd) '())
        ((= (count wd) 1) (se wd))
        (else (se (word (first wd) (first (bf wd)))
                  (disjoint-pairs (bf (bf wd)))))))
```

#### The Keep Pattern
```Scheme
(define (keep-three-letter-words sent)
  (cond ((empty? sent) '())
        ((= (count (first sent)) 3)
         (se (first sent) (keep-three-letter-words (bf sent))))
        (else (keep-three-letter-words (bf sent)))))
```

```Scheme
(define (keep-vowels wd)
  (cond ((empty? wd) "")
        ((vowel? (first wd))
         (word (first wd) (keep-vowels (bf wd))))
        (else (keep-vowels (bf wd)))))
```

```Scheme
(define (doubles wd)
  (cond ((= (count wd) 1) "")
        ((equal? (first wd) (first (bf wd)))
         (word (first wd) (first (bf wd)) (doubles (bf (bf wd)))))
        (else (doubles (bf wd)))))
```

#### The Accumulate Pattern
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
(define (sent-max sent)
  (if (= (count sent) 1)
      (first sent)
      (max (first sent)
           (sent-max (bf sent)))))
```

#### Combining Patterns
```Scheme
(define (add-numbers sent)
  (cond ((empty? sent) 0)
        ((number? (first sent))
         (+ (first sent) (add-numbers (bf sent))))
        (else (add-number (bf sent)))))
```

```Scheme
(define (safe-pigl sent)
  (cond ((empty? sent) '())
        ((has-vowel? (first sent))
         (se (pigl (first sent)) (safe-pigl (bf sent))))
        (else (safe-pigl (bf sent)))))

(define (has-vowel? wd)
  (not (empty? (keep-vowels wd))))
```

```Scheme
(define (acronym sent)
  (cond ((empty? sent) "")
        ((real-word? (first sent))
         (word (first (first sent))
               (acronym (bf sent))))
        (else (acronym (bf sent)))))
```

#### Helper Procedures
```Scheme
(define (every-nth n sent)              ;; wrong!
  (cond ((empty? sent) '())
        ((= n 1)
         (se (first sent) (every-nth n (bf sent))))
        (else (every-nth (- n 1) (bf sent)))))
```

```Scheme
(define (every-nth n sent)
  (every-nth-helper n n sent))

(define (every-nth-helper interval remaining sent)
  (cond ((empty? sent) '())
        ((= remaining 1)
         (se (first sent)
             (every-nth-helper interval interval (bf sent))))
        (else (every-nth-helper interval (- remaining 1) (bf sent)))))
```

#### How to Use Recursive Patters
```Scheme
(define (first-number sent)
  (cond ((empty? sent) 'no-number)
        ((number? (first sent)) (first sent))
        (else (first-number (bf sent)))))
```

#### Problems That Don't Follow Patters
```Scheme
(define (sent-before? sent1 sent2)
  (cond ((empty? sent1) #t)
        ((empty? sent2) #f)
        ((before? (first sent1) (first sent2)) #t)
        ((before? (first sent2) (first sent1)) #f)
        (else (sent-before? (bf sent1) (bf sent2)))))
```

#### Pitfalls
