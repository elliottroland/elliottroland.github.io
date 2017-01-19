---
published: true
title: "Monads: A New Type"
layout: post
tags: []
categories: [monads]
---
When you start learning Haskell ([for great good](http://learnyouahaskell.com/)) one of the most confusing things to get your head around are the [monads](https://en.wikipedia.org/wiki/Monad_(functional_programming)). In this post and the next I'm going to attempt to give some kind of introduction to them. This seems appropriate because monads are effectively what you get when you take what we did [in a previous post]({{ site.url }}/paradigms/2017/01/01/variables-without-state.html) and add types. In this post we'll talk about types and in the following two posts we'll get more precise about the monad functions.

Very roughly, Haskell is what you get when you take [the lambda calculus](https://en.wikipedia.org/wiki/Lambda_calculus), add a powerful type (and type inference) system, and sprinkle some syntatic sugar on it. The result is a very impressive strongly- and statically-typed [procedural functional language]({{ site.url }}/paradigms/2017/01/01/programming-paradigms.html). Now, given that pure functions don't change state one naturally wonders how a language built around them could be useful in any meaningful way. In Haskel this is achieved [through Monads of various kinds](https://www.youtube.com/watch?v=06x8Wf2r2Mc), which allow us to cleanly separate *pure* functions from *impure* functions based on their types.

For someone only familiar with object-orientated programming it might sound a bit strange to talk about types in a procedural language. After all, types are encoded in object classes, and procedural languages by definition do not have either of these. The thing to realise, however, is that object classes are just *one way* of imposing types, and that there are other ways open to functional languages. In Haskell every bundle of data is associated with a type, which is just a sort of label on that bundle. The way to talk about types in Haskell is by using `::`, so that something like `name :: String` is read as "the variable `name` is of type `String`."

In Java there is a *fundamental* difference between the types of objects and the types of methods. We talk about classes for objects and signatures for methods, and there's no real way to translate between the two. This is a consequence of making a language object-orientated, which imposes such a distinction up front. In procedural languages no such constraint exists, and in Haskell function types and data types are expressed in the same typing system. Imagine we define a function `sayHello` which takes in a String representing a name and returns a String with the message "Hello $name!" This function, then, would have the type `sayHello :: String -> String` which is read as "the function `sayHello` takes in a `String` and returns a `String`."

Because functions and data are on the same playing field, functions can just as easily return *other functions* as they can other data. This results in a core design decision in Haskell that all functions are [curried](https://en.wikipedia.org/wiki/Currying). Imagine we extended the `sayHello` function to take in a name and a surname, then its type could be written as either of the following:


```haskell
sayHello :: String -> String -> String
sayHello :: String -> (String -> String)
```

In Haskell function types always bracket from the right, so that you don't have to put them in. The `sayHello` function now takes in a `String` (name) and returns a function that takes in a `String` (surname) and returns a `String` (message). In Haskell, function *application* knows about all of this, so that all of the following are equivalent:

```haskell
sayHello "Roland" "Elliott"

(sayHello "Roland") "Elliott"

sayHelloToRoland = sayHello "Roland"
sayHelloToRoland "Elliott"
```

The third example there just unpacks the second by assigning the intermediate value to a variable and then using it.

You could think of the `->` operator as a constructor *of types*: it takes a data type and any other type, and then returns a function type made up of those two. In Haskell there are a number of ways to create types, but here what interests us is this idea of creating new types *out of other types*. In particular we're interested in the notion of a *type class*.

The word "class" might bring to mind the classes we're familiar with in object-orientated languages, and there is some degree of commonality between them (on account of which they're both called *classes*): just as object classes allow us to stamp out objects that can be used in certain ways, so too type classes allow us to stamp out types that can be used in certain ways. Nevertheless, that's where the similarities end. A type class encodes how its type instances can be used in specific functions. Now, of course, if we're going to write these function signatures in a type class, we'll need to be able to reference it, and this is achieved by using a variable quantified over the type instance. This all sounds a bit technical, but in practice it's quite straightforward:

```haskell
class Animal a where
  sayHello :: a -> String
  numberOfLegs :: a -> Int

  sayHelloTwice :: a -> String
  sayHelloTwice animal = (sayHello animal) ++ " " ++ (sayHello animal)
```

This defines the type class `Animal`, and the variable `a` in these definitions represents a particular type which falls under the `Animal` type class. This definition says that any animal type can be used in the functions listed, and that if `sayHello` is defined then `sayHelloTwice` has a default definition in terms of it (although, it can happily be overridden). If we wanted to create instances of this class, we would need to specify *at least* the three functions that don't have default definitions. If we already had defined types `Human` and `Dog` and wanted to make these instances of `Animal`, then we'd do the following:

```haskell
instance Animal Dog where
  sayHello human = "Woof!"
  numberOfLegs human = 4

instance Animal Human where
  sayHello human = "Hi, my name is " ++ (nameOf human)
  numberOfLegs human = 2
  sayHelloTwice human = (sayHello human) ++ ". Oh, hello again!"
```

In this case, the dog says hello twice by barking twice, while the human remembers they've met you and only introduces themselves once. This is all very simple, but it gets the point across. Type classes are [one of the fundamental constructs of Haskell](https://youtu.be/KnV9L5xiHt0?t=15m30s), and will play a key role in the coming posts. If you're interested in reading more about them, be sure to check out the [Learn You a Haskell For Great Good chapter on them](http://learnyouahaskell.com/types-and-typeclasses).
