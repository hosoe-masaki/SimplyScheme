## Part V Abstraction

### Chapter 17 Lists
```Scheme
(define (order flavor)
  (if (member? flavor
               '(vanilla ginger strawberry lychee raspberry mocha))
      '(coming right up!)
      (se '(sorry we have no) flavor)))
```

* The difference between a sentence and a list is that the elements of a sentence must be words, whereas the elements of a list can be anything at all: words, #t, procedures, or other lists.

* Another way to think about the difference between sentences and lists is that the definition of "list" is self-referential, because a list can include lists as elements.

* The definition of "sentence" is not self-referential, because the elements of a sentence must be words.

#### Selectors and Constructors
* The function to select the first element of a list is called car. The function to select the portion of a list containing all but the first element is called cdr. These are analogous to first and butfirst for words and sentences.

* It's called null? and it returns #t for the empty list, #f for anything else. This is the list equivalent of empty? for words and sentences.

* The function list takes any number of arguments and returns a list with those arguments as its elements.

* The other constructor, cons, is used when you already have a list and you want to add one new element. Cons takes two arguments, an element and a list (in that order), and returns a new list whose car is the first argument and whose cdr is the second.

#### Programming with Lists
```Scheme
(define (praise flavors)
  (if (null? flavors)
      '()
      (cons (se (car flavors) '(is delicious))
            (praise (cdr flavors)))))
```

* You can use list only when you know exactly how many elements will be in your complete list.

```Scheme
(define (translate wd)
  (lookup wd '((window fenetre) (book livre) (computer ordinateur)
               (house maison) (closed ferme) (pate pate) (liver foie) (faith foi) (weekend (fin de semaine))
               ((practical joke) attrape) (pal copain))))
(define (lookup wd dictionary)
  (cond ((null? dictionary) '(parlez-vous anglais?))
        ((equal? wd (car (car dictionary)))
         (car (cdr (car dictionary))))
        (else (lookup wd (cdr dictionary)))))
```

#### The Truth about Sentences
* The fact is, sentences are lists. You could take car of a sentence, for example, and it'd work fine.

* Sentences are an abstract data type represented by lists.

```Scheme
(define (first sent)                    ;; just for sentences
  (car sent))
(define (last sent)
  (if (null? (cdr sent))
      (car sent)
      (last (cdr sent))))
(define (butfirst sent)
  (cdr sent))
(define (butlast sent)
  (if (null? (cdr sent))
      '()
      (cons (car sent) (butlast (cdr sent)))))
```

#### Higher-Order Functions
* The official list versions of every, keep, and accumulate are called map, filter, and reduce.

* Map takes two arguments, a function and a list, and returns a list containing the result of applying the function to each element of the list.
* Filter also takes a function and a list as arguments; it returns a list containing only those elements of the argument list for which the function returns a true value.
* Reduce is just like accumulate except that it works only on lists, not on words.

#### Other Primitives for Lists
* The list? predicate returns #t if its argument is a list, #f otherwise.
* The predicate equal?, which we¡Çve discussed earlier as applied to words and sentences, also works for structured lists.
* Scheme does have a member primitive without the question mark that's like member? except for two differences: Its second argument must be a list (but can be a structured list); and instead of returning #t it returns the portion of the argument list starting with the element equal to the first argument.

* The list equivalent of item is called list-ref (short for "reference"); it's different in that it counts items from zero instead of from one and takes its arguments in the other order:
* The list equivalent of count is called length, and it's exactly the same except that it doesn't work on words.

#### Association Lists
* A list of names and corresponding values is called an association list, or an *a-list*.
* The Scheme primitive assoc looks up a name in an a-list:

```Scheme
(define dictionary
  '((window fenetre) (book livre) (computer ordinateur)
    (house maison) (closed ferme) (pate pate) (liver foie)
    (faith foi) (weekend (fin de semaine))
    ((practical joke) attrape) (pal copain)))
(define (translate wd)
  (let ((record (assoc wd dictionary)))
    (if record
        (cadr record)
        '(parlez-vous anglais?))))
```

#### Functions That Take Variable Numbers of Arguments
```Scheme
(define (increasing? number . rest-of-numbers)
  (cond ((null? rest-of-numbers) #t)
        ((> (car rest-of-numbers) number)
         (apply increasing? rest-of-numbers))
        (else #f)))
```

* It takes two arguments, a procedure and a list. Apply invokes the given procedure with the elements of the given list as its arguments, and returns whatever value the procedure returns.

* We use apply in increasing? because we don't know how many arguments we'll need in its recursive invocation.

* A parameter that follows a dot and therefore represents a variable number of arguments is called a rest parameter.

* The number of formal parameters before the dot determines the minimum number of arguments that must be used when your procedure is invoked. There can be only one formal parameter after the dot.

#### Recursion on Arbitrary Structured Lists
```Scheme
(define (appearances-in-book wd book)
  (reduce + (map (lambda (chapter) (appearances-in-chapter wd chapter))
                 book)))
(define (appearances-in-chapter wd chapter)
  (reduce + (map (lambda (section) (appearances-in-section wd section))
                 chapter)))
(define (appearances-in-section wd section)
  (reduce + (map (lambda (paragraph)
                   (appearances-in-paragraph wd paragraph))
                 section)))
(define (appearances-in-paragraph wd paragraph)
  (reduce + (map (lambda (sent) (appearances-in-sentence wd sent))
                 paragraph)))
(define (appearances-in-sentence given-word sent)
  (length (filter (lambda (sent-word) (equal? sent-word given-word))
                  sent)))
```

```Scheme
(define (appearances-in-sentence wd sent)
  (reduce + (map (lambda (wd2) (appearances-in-word wd wd2))
                 sent)))
(define (appearances-in-word wd wd2)
  (if (equal? wd wd2) 1 0))
```

```Scheme
(define (deep-appearances wd structure)
  (if (word? structure)
      (if (equal? structure wd) 1 0)
      (reduce +
              (map (lambda (sublist) (deep-appearances wd sublist))
                   structure))))
```

```Scheme
(define (deep-appearances wd structure)
  (cond ((equal? wd structure) 1)               ; base case: desired word
        ((word? structure) 0)                   ; base case: other word
        ((null? structure) 0)                   ; base case: empty list
        (else (+ (deep-appearances wd (car structure))
                 (deep-appearances wd (cdr structure))))))
```

```Scheme
(define (deep-pigl structure)
  (cond ((word? structure) (pigl structure))
        ((null? structure) '())
        (else (cons (deep-pigl (car structure))
                    (deep-pigl (cdr structure))))))
```

#### Pitfalls
