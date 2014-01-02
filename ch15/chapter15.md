### Chapter 15 Advanced Recursion

#### Example: Sort
```Scheme
(define (sort sent)
  (if (empty? sent)
      '()
      (se (earliest-word sent)
          (sort (remove-once (earliest-word sent) sent)))))
```

```Scheme
(define (earliest-word sent)
  (earliest-helper (first sent) (bf sent)))

(define (earliest-helper so-far rest)
  (cond ((empty? rest) so-far)
        ((before? so-far (first rest))
         (earliest-helper so-far (bf rest)))
        (else (earliest-helper (first rest) (bf rest)))))
```

```Scheme
(define (remove-once wd sent)
  (cond ((empty? sent) '())
        ((equal? wd (first sent)) (bf sent))
        (else (se (first sent) (remove-once wd (bf sent))))))
```

#### Example: From-Binary
```Scheme
(define (from-binary bits)
  (if (empty? bits)
      0
      (+ (* (first bits) (expt 2 (count (bf bits))))
         (from-binary (bf bits)))))
```

```Scheme
(define (from-binary bits)
  (if (empty? bits)
      0
      (+ (* (from-binary (bl bits)) 2)
         (last bits))))
```

#### Example: Mergesort
```Scheme
(define (mergesort sent)
  (if (<= (count sent) 1)
      sent
      (merge (mergesort (one-half sent))
             (mergesort (other-half sent)))))
```

```Scheme
(define (merge left right)
  (cond ((empty? left) right)
        ((empty? right) left)
        ((before? (first left) (first right))
         (se (first left) (merge (bf left) right)))
        (else (se (first right) (merge left (bf right))))))
```

```Scheme
(define (one-half sent)
  (if (<= (count sent) 1)
      sent
      (se (first sent) (one-half (bf (bf sent))))))

(define (other-half sent)
  (if (<= (count sent) 1)
      '()
      (se (first (bf sent)) (other-half (bf (bf sent))))))
```

#### Example: Subsets
```Scheme
(define (prepend-every letter sent)
  (if (empty? sent)
      '()
      (se (word letter (first sent))
          (prepend-every letter (bf sent)))))
```

```Scheme
(define (subsets wd)
  (if (empty? wd)
      (se "")
      (let ((smaller (subsets (bf wd))))
        (se smaller
            (prepend-every (first wd) smaller)))))
```

#### Pitfalls
