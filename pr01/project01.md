### Project: Scoring Bridge Hands

#### Card-val
```Scheme
; > (card-val 'cq)
; 2
; 
; > (card-val 's7)
; 0
; 
; > (card-val 'ha)
; 4

(define (card-val card)
  (cond ((equal? (butfirst card) 'a) 4)
        ((equal? (butfirst card) 'k) 3)
        ((equal? (butfirst card) 'q) 2)
        ((equal? (butfirst card) 'j) 1)
        (else 0)))
```

#### High-card-points
```Scheme
; > (high-card-points '(sa s10 hq ck c4))
; 9
; 
; > (high-card-points '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
; 13

(define (high-card-points hand)
  (accumulate + (every card-val hand)))
```

#### Count-suit
```Scheme
; > (count-suit 's '(sa s10 hq ck c4))
; 2
; 
; > (count-suit 'c '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
; 2
; 
; > (count-suit 'd '(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2))
; 5

(define (count-suit suit hand)
  (count (keep (lambda (card) (equal? (first card) suit)) hand)))
```

#### Suit-counts
```Scheme
; > (suit-counts '(sa s10 hq ck c4))
; (2 1 2 0)
; 
; > (suit-counts '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
; (5 3 2 3)
; 
; > (suit-counts '(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2))
; (5 1 2 5)

(define (suit-counts hand)
  (every (lambda (suit) (count-suit suit hand)) '(s h c d)))
```

#### Suit-dist-points
```Scheme
; > (suit-dist-points 2)
; 1
; 
; > (suit-dist-points 7)
; 0
; 
; > (suit-dist-points 0)
; 3

(define (suit-dist-points number-of-cards)
  (cond ((equal? number-of-cards 2) 1)
        ((equal? number-of-cards 1) 2)
        ((equal? number-of-cards 0) 3)
        (else 0)))
```

#### Hand-dist-points
```Scheme
; > (hand-dist-points '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
; 1
; 
; > (hand-dist-points '(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2))
; 3

(define (hand-dist-points hand)
  (accumulate + (every suit-dist-points (suit-counts hand))))
```

#### Bridge-val
```Scheme
; > (bridge-val '(sa s10 s7 s6 s2 hq hj h9 ck c4 dk d9 d3))
; 14
; 
; > (bridge-val '(h3 d7 sk s3 c10 dq d8 s9 s4 d10 c7 d4 s2))
; 8

(define (bridge-val hand)
  (+ (high-card-points hand) (hand-dist-points hand)))
```
