---
published: true
title: Programming paradigms
layout: post
tags: []
categories: [paradigms]
---
I recently watched [this video](https://www.youtube.com/watch?v=QM1iUe6IofM) by Brian Will, which argues against object-orientated programming. There was a lot to think about in there, but the thing that struck me the most was his articulation of the differences between the [programming paradigms](https://en.wikipedia.org/wiki/Programming_paradigm) *procedural*, *object-orientated*, *imperative*, and *functional*. Here I reword what I think is his account. I should note that while there is no official account of these paradigms and how they relate to one another, this is the most lucid and helpful one I have come across to date.

Initially, one might be tempted to see all these paradigms as alternatives to one another, but this would be a mistake. Really they lie on two different axes, with procedural vs object-orientated on the one axis, and imperative vs functional on the other. Below is a table with an example for each combination:

|   | Procedural | Object-orientated |
| - |--------- | ----------------- |
| **Imperative** | C | Java |
| **Functional** | Haskell | Clojure |

In every language you have datatypes and procedures: datatypes store state, and procedures operate on these datatypes in some way. Structs, variables, and objects are examples of datatypes, and functions and methods are examples of procedures.

The difference between procedural and object-orientated is about how datatypes relate to procedures. In a procedural language the two are separate from one another and procedures operate from outside datatypes. In an object-orientated language the two are bundled together into what we call objects (datatypes) and methods (procedures), so that methods run from inside objects. With this bundling of procedures and datatypes things like information hiding become possible, since the methods can now access privately held state stored in the datatypes that's not visible from outside.

The difference between imperative and functional is about how and when procedures can mutate state. With imperative languages any procedures can freely mutate state they can see, whereas in purely functional language no state is mutated. This is more of a spectrum than a binary difference, since different languages can put different restrictions on the ability to mutate state. An imperative language could restrict mutation through freezing variables (as in Ruby) or finalizing variables (as in Java), or by hiding variables. From the other side, a functional language might allow you to mutate state but only in specific cases. From this perspective we say that *statement* are operations which mutate state, and *expressions* are operations which don't.
