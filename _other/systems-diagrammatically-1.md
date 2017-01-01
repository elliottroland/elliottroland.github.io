---
published: true
title: Systems diagrammatically
layout: wip
tags: []
categories: [formalisms]
---
When I studied [category theory](https://en.wikipedia.org/wiki/Category_theory) I was struck by how expressive such simple diagrams could be if used correctly. After reading [Lewis and Fowler on microservices](http://www.martinfowler.com/articles/microservices.html) I was inspired to develop a somewhat formal "diagrammatic language" for systems. First we outline some distinctions, and then we give the diagrammatic formalism.

A **system** is any collection of things working together as a functional whole. Intuitively, a **component** is any one of these things that form part of the system. More formally, a component is a *unit within a system* that is *independently changeable*. The two parts of the definition of a component give us two axes by which different components can be distinguished from one another: their mode of operation and their mode of independence.

On the first axis we have **functions** and **channels**. For any component we can consider its operation in terms of a request-response cycle, broadly construed. Either the response or the request can be null, of course, which cases correspond to pure requests and void responses respectively. Functions, then, are components *which use other components as part of their operation*. Channels, by contrast, are components which don't.

On the second axis we have **algorithmic independence** and **operational independence**. Algorithmic independence means that we can change the component *without having to change how the component is used*. Operational independence means we can apply changes to the component *without having to touch other components*. As it stands, operational independence entails algorithmic independence, but we'll stipulate that when we talk about the independence of a component we're interested in its highest level of independence. In this sense then, an algorithmically independent component is not operationally independent and vice versa.

As they stand these distinctions apply very generally. We could use them to talk about methods in single thread, threads running in a single process, process running on single host, hosts running in a cluster, and any cross-cut of these. What it means to change in each case will also differ. Following the definitions from Lewis and Fowler, if we're at the level where changes are applied through deployments, then **services** are the operationally independent components and **libraries** are the algorithmically independent components.

How do depict all of this? Let's start with functions and channels. The natural way to depict a component is as a box, with arrows coming in and going out of it representing the flow of information. We'll reserve boxes for functions, since these most closely resemble our intuitive notion of a component (as will be become clearer as we proceed). Since operations are broadly considered as request-response cycles there's no sense in drawing both arrows when one suffices for clarity, so we'll typically represent the request as an arrow from requester to function. Thus, the arrows coming *out* of a function will represent the calls it uses as part of its operation. In general, we'll read diagrams from left to right, and try as best we can to keep callers on the left.

We'll depict channels as single edges. Because channels never use other components in the course of their operation, the direction of the arrows is technically unimportant. Nevertheless, we can sometimes use out-going arrows to indicate something akin to read-only usage. Consider the following examples:

![System diagram examples]({{ site.url }}/images/2016-10-25-system-diagram-examples-1.png){:width="100%"}

On the top-left we have what is perhaps the most familiar. Some component *A* calls *B* and *C*, and *B* in turn calls *D* and *E*, and *D* in turn calls some channel perhaps to update some state. Technically the diagram is incomplete, since we have functions (boxes) that aren't calling other components.

On the top-right we have *A* calling a channel, and then *B* reading from that channel. Perhaps *A* is updating state which is later being read by *B*.

On the bottom-left we have a series of function calls, with *B*'s processing also taking into account what it reads from the channel.

And finally, on the bottom-right we have something very similar to what's happening on the top-right except that this time *A* (that which writes to the state) and *C* (that which reads from it) are connected by an intermediate function call.
