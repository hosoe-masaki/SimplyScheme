### Chapter 4 Defining Your Own Procedures

#### How to Define a Procedure
* A Scheme program consists of one or more *procedures*.
* A procedure is a description of the process by which a computer can work out some result that we want.

```Scheme
(define (square x)
  (* x x))
```

#### Special Forms

#### Functions and Procedures
```Scheme
(define (f x)
  (+ (* 3 x) 12))
(define (g x)
  (* 3 ( + x 4))
```

#### Argument Names versus Argument Values
* The name for the name of an argument is *formal parameter*.
* The technical term for the actual value of the argument is the *actual argument*.

```Scheme
(define (f a b)
  (+ (* 3 a) b))
```

#### Procedure as Generalization
```Scheme
(define (average a b)
  (/ (+ a b) 2))
```

#### Composability

#### The Substitution Model
```Scheme
(define (hypotenuse a b)
  (sqrt ( + (square a) (square b))))
```

* the substitution model tells us how *each compound procedure* is carried out, but doesn't change our picture of the way in which procedure invocations are *composed* into larger expressions.

#### Pitfalls
* Don't forget that a function can have only *one* return value.

```Scheme
(define (sum-of-squares x y)
  (+ (square x)
     (square y)))
```
* Another pitfall comes from thinking that a procedure call changes the value of a parameter.

* A very common pitfall in Scheme comes from choosing the name of a procedure as a parameter.
* It isn't a problem if the formal parameter is the name of a procedure tha you don't use inside the body.
* But special forms are an exception; you can never use the name of a special form as a parameter.

* A similar problem about name conflicts comes up if you try to use a keyword (the name of a special form, such as define) as some other kind of name-either a formal parameter or the name of a procedure you're defining.

* Formal parameters *must* be words.
