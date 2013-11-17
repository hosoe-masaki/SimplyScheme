### Chapter 10 Example: Tic-Tac-Toe

#### A Warning

#### Technical Terms in Tic-Tac-Toe

#### Thinking about the Program Structure
```Scheme
(define (ttt position me)               ;; first version
  (cond ((i-can-win?)
         (choose-winning-move))
        ((opponent-can-win?)
         (block-opponent-win))
        ((i-can-win-next-time?)
         (prepare-win))
        (else (whatever))))
```

#### The First Step: Triples

#### Finding the Triples
```Scheme
(define (find-triples position)         ;; first version
  (every substitute-triple '(123 456 789 147 258 369 159 357)))
```

```Scheme
(define (substitute-triple combination)         ;; first version
  (every substitute-letter combination))
(define (substitute-triple combination)i        ;; second version
  (accumulate word (every substitute-letter combination)))
```

```Scheme
(define (substitute-letter square)              ;; first version
  (if (equal? '_ (item square position))
      square
      (item square position)))
```

#### Using Every with Two-Argument Procedures
```Scheme
(define (substitute-letter square position)     ;; final version
  (if (equal? '_ (item square position))
      square
      (item square position)))
```

```Scheme
(define (substitute-triple combination position)        ;; final version
  (accumulate word
              (every (lambda (square)
                       (substitute-letter square position))
                     combination)))
```

```Scheme
(define (find-triples position)                 ;; final version
  (every (lambda (comb) (substitute-triple comb position))
         '(123 456 789 147 258 369 159 357)))
```

```Scheme
(define (ttt position me)
  (ttt-choose (find-triples position) me))

(define (ttt-choose triples me)                 ;; first version
  (cond ((i-can-win? triples me)
         (choose-winning-move triples me))
        ((opponent-can-win? triples me)
         (block-opponent-win triples me))
        ...))
```

#### Can the Computer Win on This Move?
```Scheme
(define (my-pair? triple me)
  (and (= (appearances me triple) 2)
       (= (appearances (opponent me) triple) 0)))

(define (opponent letter)
  (if (equal? letter 'x) 'o 'x))
```

```Scheme
(define (i-can-win? triples me)                  ;; first version
  (not (empty?
        (keep (lambda (triple) (my-pair? triple me))
              triples))))
```

#### If So, in Which Square?
```Scheme
(define (choose-winning-move triples me)        ;; not really part of game
  (keep number? (first (keep (lambda (triple) (my-pair? triple me))
                             triples))))
```

```Scheme
(define (ttt-choose triples me)                 ;; second version
  (cond ((i-can-win? triples me))
        ((opponent-can-win? triples me))
        ..))
```

```Scheme
(define (i-can-win? triples me)                 ;; final version
  (choose-win
   (keep (lambda (triple) (my-pair? triple me))
         triples)))

(define (choose-win winning-triples)
  (if (empty? winning-triples)
      #f
      (keep number? (first winning-triples))))
```

#### Second Verse, Same as the First
```Scheme
(define (opponent-can-win? triples me)
  (i-can-win? triples (opponent me)))
```

#### Now the Strategy Gets Complicated
```Scheme
(define (i-can-fork? triples me)
  (first-if-any (pivots triples me)))

(define (first-if-any sent)
  (if (empty? sent)
      #f
      (first sent)))
```

#### Finding the Pivots
```Scheme
(define (pivots triple me)
  (repeated-numbers (keep (lambda (triple) (my-single? triple me))
                          triples)))

(define (my-single? triple me)
  (and (= (appearances me triple) 1)
       (= (appearances (opponent me) triple) 0)))
```

```Scheme
(define (repeated-numbers sent)
  (every first
         (keep (lambda (wd) (>= (count wd) 2))
               (sort-digits (accumulate word sent)))))
```

```Scheme
(define (extract-digit desired-digit wd)
  (keep (lambda (wd-digit) (equal? wd-digit desired-digit)) wd))
```

```Scheme
(define (sort-digits number-word)
  (every (lambda (digit) (extract-digit digit number-word))
         '(1 2 3 4 5 6 7 8 9)))
```

#### Taking the Offensive
```Scheme
(define (ttt-shoose triples me)
  (cond ((i-can-win? triples me))
        ((opponent-can-win? triples me))
        ((i-can-fork? triples me))
        ((i-can-advance? tripes me))
        (else (best-free-square triples))))
```

```Scheme
(define (opponent-can-fork? triples me)         ;; not really part of game
  (i-can-fork? triples (opponent me)))
```

```Scheme
(define (i-can-advance? triples me)
  (best-move (keep (lambda (triple) (my-single? triple me)) triples)
             triples
             me))

(define (best-move my-triples all-triples me)
  (if (empty? my-triples)
      #f
      (best-square (first my-triples) all-triples me)))
```

```Scheme
(define (best-square my-triple triples me)
  (best-square-helper (pivots triples (opponent me))
                      (keep number? my-triple)))

(define (best-square-helper opponent-pivots pair)
  (if (member? (first pair) opponent-pivots)
      (first pair)
      (last pair)))
```

#### Leftovers
```Scheme
(define (best-free-square triples)
  (first-choice (accumulate word triples)
                '(5 1 3 7 9 2 4 6 8)))

(define (first-choice possibilities preferences)
  (first (keep (lambda (square) (member? square possibilities))
               preferences)))
```