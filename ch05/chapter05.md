### Chapter 5 Words and Sentences

* Quote is a special form, since its argument isn't evaluated. Instead, it just returns the argument as is.

* When you see words inside quotation marks, you understand that you're supposed to think about the words themselves; you don't evaluate what they mean.

#### Selectors
* So far all we've done with words and sentences is quote them. Todo more interesting work, we need tools for two kind of operations: We have to be able to take them apart, and we have to be able to put them togegher. We'll start with the take-apart tools; the technical term for them is *selectors*.
* Notice that the first of a sentence is a word, while the first of a word is a letter.

* The butfirst and butlast aren't meant to describe ways to sled; they abbreviate "all but the first" and "all but the last."
```Scheme
(define (second thing)
  (first (butfirst thing)))
```
* There is, however, a primitive selector item that takes two arguments, a number *n* and a word or sentence, and return the *n*th element of the second argument.

* Don't forget that a sentence containing exactly one word is different from the word itself, and selectors operate on the two differently.
* The value of that last expression("()") is the *empty sentence*. You can tell it's a sentence because of the parentheses, and you can tell it's empty because there's nothing between them.

#### Constructors
* Functions for putting things together are called *constructors*.
* Word takes any number of words as arguments and joins them all together into one huongous word.

* Sentence is similar, but slightly different, since it can take both words and sentences as arguments.

#### First-Class Words and Sentences
* Technically, we say tht words and sentences should be *first-class data* in our language. This means that a sentence, for example, can be an argument to a procedure; it can be the value returned by a procedure; we can give it a name; and we can build aggregates whose elements are sentences.

#### Pitfalls
* We've been avoiding apostrophes in our words and sentences because they're abbreviations for the quote special form. You must also avoid periods, commas, semicolons, quotation marks, vertical bars, and of course, parentheses, since all of these have special meanings in Scheme.

* There's a difference between a wordk and a single-word sentence. For example, people often fall into the trap of thinking that the butfirst of a two-word sentence such as (sexy sadie) is the second word, but it's not. It's a one-word-long sentence.

