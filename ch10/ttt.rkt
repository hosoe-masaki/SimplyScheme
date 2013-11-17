;;; ttt.rkt
;;; Tic-Tac-Toe program

(define (ttt position me)
  (ttt-shoose (find-triples position) me))

; finds all the letters in all eight winning combinations
(define (find-triples position)                 ;; final version
  (every (lambda (comb) (substitute-triple comb position))
         '(123 456 789 147 258 369 159 357)))

; finds all three letters corresponding to three squares
(define (substitute-triple combination position)        ;; final version
  (accumulate word
              (every (lambda (square)
                       (substitute-letter square position))
                     combination)))

; finds the letter in a single square
(define (substitute-letter square position)     ;; final version
  (if (equal? '_ (item square position))
      square
      (item square position)))

(define (ttt-shoose triples me)
  (cond ((i-can-win? triples me))
        ((opponent-can-win? triples me))
        ((i-can-fork? triples me))
        ((i-can-advance? triples me))
        (else (best-free-square triples))))

(define (i-can-win? triples me)                 ;; final version
  (choose-win
   (keep (lambda (triple) (my-pair? triple me))
         triples)))

(define (my-pair? triple me)
  (and (= (appearances me triple) 2)
       (= (appearances (opponent me) triple) 0)))

(define (opponent letter)
  (if (equal? letter 'x) 'o 'x))

(define (choose-win winning-triples)
  (if (empty? winning-triples)
      #f
      (keep number? (first winning-triples))))

(define (opponent-can-win? triples me)
  (i-can-win? triples (opponent me)))

(define (i-can-fork? triples me)
  (first-if-any (pivots triples me)))

(define (first-if-any sent)
  (if (empty? sent)
      #f
      (first sent)))

(define (pivots triples me)
  (repeated-numbers (keep (lambda (triple) (my-single? triple me))
                          triples)))

(define (my-single? triple me)
  (and (= (appearances me triple) 1)
       (= (appearances (opponent me) triple) 0)))

(define (repeated-numbers sent)
  (every first
         (keep (lambda (wd) (>= (count wd) 2))
               (sort-digits (accumulate word sent)))))

(define (sort-digits number-word)
  (every (lambda (digit) (extract-digit digit number-word))
         '(1 2 3 4 5 6 7 8 9)))

(define (extract-digit desired-digit wd)
  (keep (lambda (wd-digit) (equal? wd-digit desired-digit)) wd))

(define (i-can-advance? triples me)
  (best-move (keep (lambda (triple) (my-single? triple me)) triples)
             triples
             me))

(define (best-move my-triples all-triples me)
  (if (empty? my-triples)
      #f
      (best-square (first my-triples) all-triples me)))

(define (best-square my-triple triples me)
  (best-square-helper (pivots triples (opponent me))
                      (keep number? my-triple)))

(define (best-square-helper opponent-pivots pair)
  (if (member? (first pair) opponent-pivots)
      (first pair)
      (last pair)))

(define (best-free-square triples)
  (first-choice (accumulate word triples)
                '(5 1 3 7 9 2 4 6 8)))

(define (first-choice possibilities preferences)
  (first (keep (lambda (square) (member? square possibilities))
               preferences)))

; from Exercise 10.1
(define (already-won? position me)
  (not (empty? (keep (lambda (triple) (my-triple? triple me)) (find-triples position)))))

(define (my-triple? triple me)
  (= (appearances me triple) 3))

; from Exercise 10.2
(define (tie-game? position)
  (empty? (keep (lambda (triple) (my-any? triple 'o)) (find-triples position))))

(define (my-any? triple me)
  (or (my-single? triple me)
      (my-pair? triple me)
      (my-triple? triple me)))

