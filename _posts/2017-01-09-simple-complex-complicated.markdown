---
published: true
title: "Simple, complex, and complicated"
layout: post
tags: []
categories: [zen]
---
The third and fourth lines of the [Zen of Python](https://www.python.org/dev/peps/pep-0020/) are:

> Simple is better than complex.
>
> Complex is better than complicated.

The similarity of the words involved has sparked lots of conversation on the internet about how best to interpret them, with very little agreement. I recently came across a representative example of this while listening to the [From Python Import Podcast](http://frompythonimportpodcast.com) podcast [episode 2](http://frompythonimportpodcast.com/?p=34), in which they gave three different interpretations without much consensus by the end.

I think a lot of people get confused by the two aphorisms because they assume that they pick out three points on a single spectrum, having simple and complicated on either end with complex being some sort of midpoint between the two. As I see it the complexity of a piece of code refers to *how many parts there are*, while the complicatedness refers to *how difficult it is to understand*. Confusingly, simple can be used in either sense: simple can mean uncomplex or uncomplicated. So, the point of the two aphorisms is that smaller code is good, but not if it makes your code difficult to understand.

Consider the [boolean trap](https://ariya.io/2011/08/hall-of-api-shame-boolean-trap), in which a function has an unnamed boolean parameter that modifies that function's behaviour. As discussed in the first link, you might come across a `repaint` function which is called as follows:

```java
widget.repaint(false)
```

And you'd be forgiven for not knowing what that's supposed to do. Now there are a [number of ways](http://stackoverflow.com/questions/6107221/alternatives-to-passing-a-flag-into-a-method) to deal with boolean traps, varying based on the language you're using, but what's important for our purposes here is that every solution makes your code more readable by adding more bits. In other words, every solution makes your code *more complex* but *less complicated*.
