### Chapter 6 True and False

```Scheme
(define (greet name)
  (if (equal? (first name) 'professor)
      (se '(i hope i am not bothering you) 'professor (last name))
      (se '(good to see you) (first name))))
```

* If takes three arguments. The first has to be either true or false. The second and third arguments are expressions; one or the other of them is evaluated depending on the first argument. The value of the entire if expression is the value of either the second or the third argument.

* Scheme includes a special data type called *Booleans* to represent true or false values. There are just two of them: #t for "true" and #f for "false."

* the first argument to if has to be true or false.

#### Predicates
* A function that returns either #t or #f is called a *predicate*.

* equal? works on any kind of Scheme data, while = is defind only for numbers.

```Scheme
(define (vowel? letter)
  (member? letter 'aeiou))
(define (positive? number)
  (> number 0))
```

#### Using Predicates
```Scheme
(define (abs num)
  (if (< num 0)
      (- num)
      num))
```

```Scheme
(define (buzz num)
  (if (or (divisible? num 7) (member? 7 num))
      'buzz
      num))

(define (divisible? big little)
  (= (remainder  big little) 0))
```

* It's quite common that the easiest way to solve some problem is to write a *helper procedure* to do part of the work.

```Scheme
; Version 1
(define (plural wd)
  (word wd 's))

; Version 2
(define (plural wd)
  (if (equal? (last wd) 'y)
      (word (bl wd) 'ies)
      (word wd 's)))
```

#### If Is a Special Form
```Scheme
(if (= 3 3)
    'sure
    (factorial 1000))
```

* The rule is that if always evaluates its first argument. If the value of that argument is true, then if evaluates its second argument and returns its value. If the value of the first argument is false, then if evaluates its third argument and returns that value.

#### So Are And and Or
* And and or are also special forms. They evaluate their arguments in order from left to right and stop as soon as they can. For or, this means returning true as soon as any of the arguments is true. And returns false as soon as any argument is false.
```Scheme
(define (divisible? big small)
  (= (remainder big small) 0))

(define (num-divisible-by-4? x)
  (and (number? x) (divisible? x 4)))
```

#### Everything That Isn't False Is True
* #t isn't the only true value. In fact, *every* value is considered true except for #f. This allows us to have *semipredicates* that give slightly more information than just true or false.
```Scheme
(define (integer-quotient big little)
  (if (divisible? big little)
      (/ big little)
      #f))
```

* And and or are also semipredicates. or returns a true result as soon as it evaluates a true argument. The particular true value that or returns is the value of that first true argument. And returns a true value only if all of its arguments are true. In that case, it returns the value of the last argument.

```Scheme
(define (integer-quotient big little) ;; alternate version
  (and (divisible? big little)
       (/ big little)))
```

#### Decisions, Decisions, Decisions
```Scheme
(define (roman-value letter)
  (if (equal? letter 'i)
      1
      (if (equal? letter 'v)
          5
          (if (equal? letter 'x)
              10
              (if (equal? letter 'l)
                  50
                  (if (equal? letter 'c)
                      100
                      (if (equal? letter 'd)
                          500
                          (if (equal? letter 'm)
                              1000
                              'huh?))))))))
```
* Scheme provides a shorthand notation for situations like this in which you have to choose from among several possibilities: the special form cond.
```Scheme
(define (roman-value letter)
  (cond ((equal? letter 'i) 1)
        ((equal? letter 'v) 5)
        ((equal? letter 'x) 10)
        ((equal? letter 'l) 50)
        ((equal? letter 'c) 100)
        ((equal? letter 'd) 500)
        ((equal? letter 'm) 1000)
        (else 'huh?)))
```

* The tricky thing about cond is that it doesn't use parentheses in quite the same way as the rest of Scheme. Ordinarily, parentheses mean procedure invocation. In cond, *most* of the parentheses still mean that, but *some* of them are used to group pairs of tests and results.

* Cond takes any number of arguments, each of which is *two expressions* inside a pair of parentheses. Each argument is called a *cond clause*. The outermost parentheses on that line enclose two expressions. The first of the two expressions (the *condition*) is taken as true or false, just like the first argument to if. The second expression of each pair (the *consequent*) is a candidate for the return value of the entire cond invocation.

* Cond examines its arguments from left to right. Remember that since cond is a special form, its arguments are not evaluated ahead of time. For each argument, cond evaluates the first of the two expressions within the argument. If that value turn out to be true, then cond evaluates the second expression in the same argument, and returns that value without examining any further arguments. But if the value is false, then cond dos *not* evaluate the second expression; instead, it goes on to the next argument.

* By convention, the last argument always stats with the word else instead of an expression. You think of this as representing a true value, but else doesn't mean true in any other context; you're only allowed to use it as the condition of the last clause of a cond.

```Scheme
(define (truefalse value)
  (cond (value 'true)
        (else 'false)))
```

#### If Is Composable
```Scheme
(define (greet name)
  (if (equal? (first name) 'professor)
      (se '(pleased to meet you)
          'professor
          (last name)
          '(-- how are you?))
      (se '(pleased to meet you)
          (first name)
          '(-- how are you?))))

(define (greet name)
  (se '(pleased to meet you)
      (if (equal? (first name) 'professor)
          (se 'professor (last name))
          (first name))
      '(-- how are you?)))
```

* But in Scheme, the value returned by *every* function can be used as part of a larger expression.

#### Pitfalls
