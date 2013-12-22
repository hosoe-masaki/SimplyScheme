### Project: Spelling Names of Huge Numbers
Write a procedure number-name that takes a positive integer argument and returns a sentence containing that number spelled out in words:

```Scheme
> (number-name 5513345)
(FIVE MILLION FIVE HUNDRED THIRTEEN THOUSAND THREE HUNDRED FORTY FIVE)

> (number-name (factorial 20))
(TWO QUINTILLION FOUR HUNDRED THIRTY TWO QUADRILLION NINE HUNDRED TWO
 TRILLION EIGHT BILLION ONE HUNDRED SEVENTY SIX MILLION SIX HUNDRED
 FORTY THOUSAND)
```

- Numbers in which some particular digit is zero
- Numbers like 1,000,529 in which an entire group of three digits is zero.
- Numbers in the teens.

```Scheme
'(thousand million billion trillion quadrillion quintillion
  sextillion septillion octillion nonillion decillion)
```

```Scheme
> (number-name 1428425)                      ;; intermediate version
(1 MILLION 428 THOUSAND 425)
```

Answer

```Scheme
(define (three-digits-group idx)
  (if (= idx 0)
      '()
      (item idx '(thousand million billion trillion quadrillion quintillion sextillion septillion octillion nonillion decillion))))

(define (one-to-nineteen idx)
  (if (= idx 0)
      '()
      (item idx '(one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen))))

(define (number-name w)
  (number-name-helper 0 w))

(define (number-name-helper digit w)
  (cond ((< w 1000) (se (three-digits-name w) (three-digits-group digit)))
        ((= (remainder w 1000) 0) (number-name-helper (+ digit 1) (quotient w 1000)))
        (else (se (number-name-helper (+ digit 1) (quotient w 1000)) (three-digits-name (remainder w 1000)) (three-digits-group digit)))))

(define (three-digits-name w)
  (cond ((> w 99) (se (one-to-nineteen (quotient w 100)) 'hundred (three-digits-name (remainder w 100))))
        ((> w 19) (se (item (- (quotient w 10) 1) '(twenty thirty fourty fifty sixty seventy eighty ninety)) (one-to-nineteen (remainder w 10))))
        (else (one-to-nineteen w))))
```
