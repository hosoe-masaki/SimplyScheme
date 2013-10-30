### Chapter 7 Variables
* A *variable* is a connection between a name and a value.

* In functional programming, what we mean by "bariable" is like a named constant in mathematics. Since a variable is the connection between a name and a value, a formal parameter in a procedure definition isn't a variable; it's just a name. But when we invoke the procedure with a particular argument, that name is associated with a value, and a variable is created. If we invoke the procedure again, a *new* variable is created, perhaps with a different value.

* Part of what we mean by functional programming is that once a variable exists, we aren't going to *change* the value of that variable.

#### How Little People Do Variables
* You can understand variables in terms of the little-people model. A variable, in this model, is the association in the little person's mind between a formal parameter (name) and the actual argument (value) she was given.

```Scheme
(define (square x) (* x x))

(define (hypotenuse x y)
  (sqrt (+ (square x) (square y))))
```

* Another important point about the way little people do variables is that they can't read eath others' minds. In particular, they don't know about the values of the local variables that belong to the little people who hired them.
```Scheme
(define (f x)
  (g 6))

(define (g y)
  (+ x y))
```

```Scheme
(define (f x)
  (g x 6))

(define (g x y)
  (+ x y))
```

#### Global and Local Variables
* Just as we've been using define to associate names with procedures globally, we can also use it for other kinds of data

* Once defined, a global variable can be used anywhere, just as a defined procedure can be used anywhere.
* When the name of a global variable appears in an expression, the corresponding value must be substituted, just as actual argument values are substituted for formal parameter.

* The association of a formal parameter (a name) with an actual argument (a value) is called *local variable*.

#### The Truth about Substitution

#### Let
```Scheme
(define (roots a b c)
  (se (/ (+ (- b) (sqrt (- (* b b) (* 4 a c))))
         (* 2 a))
      (/ (- (- b) (sqrt (- (* b b) (* 4 a c))))
         (* 2 a))))

(define (roots a b c)
  (roots1 a b c (sqrt (- (* b b) (* 4 a c)))))
(define (roots1 a b c discriminant)
  (se (/ (+ (- b) discriminant) (* 2 a))
      (/ (- (- b) discriminant) (* 2 a))))

(define (roots a b c)
  (let ((discriminant (sqrt (- (* b b) (* 4 a c)))))
    (se (/ (+ (- b) discriminant) (* 2 a))
        (/ (- (- b) discriminant) (* 2 a)))))
```

* Let is a special form that takes two arguments. The first is a sequence of name-value pairs enclosed in parentheses. The secnd argument, the *body* of the let, is the expression to evaluate.

```Scheme
(define (roots a b c)
  (let ((discriminant (sqrt (- (* b b) (* 4 a c))))
        (minus-b (- b))
        (two-a (* 2 a)))
    (se (/ (+ minus-b discriminant) two-a)
        (/ (- minus-b discriminant) two-a))))
```

* Like cond, let uses parentheses both with the usual meaning (invoking a procedure) and to group sub-arguments that belong together.

#### Pitfalls
* A definition is meant to be *permanent* in functional programming.

```Scheme
(let ((name1 (fn1 arg1))
      (name2 (fn2 arg2))
      (name3 (fn3 arg3)))
  body)
```
