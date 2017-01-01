---
published: true
title: Variables without state
layout: post
tags: []
categories: [paradigms]
---
[We've seen]({{ site.url }}/paradigms/2017/01/01/programming-paradigms.html) that the difference between imperative and functional programming languages lies in how freely functions can mutate state. Imperative languages have statements (which mutate state) and purely functional languages only have expressions (which don't mutate state). Someone more familiar with imperative than functional languages (which is most people these days) might raise an eyebrow at this: if you can't mutate state, does that mean that functional languages can't assign variables? And if so, then how could they possibly be as powerful as imperative languages?

At the heart of it a variable is a value we assign to a label so that we can reference it later in our current scope. Consider, for instance, the following Python function:

```python
def function():
  a = 5
  b = 6
  return a + b
```

In this snippet we assign two variables, `a` and `b`, which we reference in the last line when adding them together and returning the result. Now the question of *what* a variable is is different from *how* a particular language makes earlier variable assignments reference-able later in the current scope. Imperative languages like Python will no doubt do it using some kind of state mutation, but other options are available.

One such alternative, which is open to purely functional languages, is to interpret variable assignments as function arguments. We could rewrite the above Python code with anonymous functions to illustrate this:

```python
def function():
  return (lambda a, b:
    a + b
  )(5, 6)
```

In this example -- which is admittedly a bit contrived -- we've extracted out the logic that uses the variables into the body of the anonymous function, and then made the variables available to this logic through function arguments. I've tried to format it to make the `lambda` look like its own block. This is all well and good, but more often than not we need to perform some operations between assigning variables, and it's not entirely clear how we could achieve this. Fortunately, this can be achieved through the wonders of [currying](https://en.wikipedia.org/wiki/Currying). The above fuction would be curried as follows:

```python
def function():
  return (lambda a:
    (lambda b:
      a + b
    )(6)
  )(5)
```

Notice that now each line other than the return is given its own function. And we can do the same thing for lines that don't assign variables, so long as void functions return some kind of "empty" value (like `None` in Python). In this case, we would assign the value to a variable we never use or, if the language allows it, we would assign it to an "empty" variable. In Python the underscore serves this purpose. To illustrate all of this, assume we want to call a different function between assigning the two variables above. Say, for instance, we wanted something like this:

```python
def function():
  a = 5
  validate(a)
  b = 6
  return a + b
```

That `validate(a)` line can be written as `(lambda _: None)(validate(a))` so long as `a` is within our scope. So, then, the final function looks like this:

```python
def function():
  return (lambda a:
    (lambda _:
      (lambda b:
        a + b
      )(6)
    )( validate(a))
  )(5)
```

Of course, all of this looks a bit ugly in Python. But that's because Python wasn't designed to be a pure functional language. Haskell, by contrast, *was* so designed, and so has a fair amount of syntactic sugar to hide these complexities:

```haskell
function = do
  let a = 5
  validate a
  let b = 6
  return (a + b)
```
