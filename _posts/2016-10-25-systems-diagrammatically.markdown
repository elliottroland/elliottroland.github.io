---
published: true
title: Systems diagrammatically
layout: post
tags: [wip]
categories: [formalisms]
---
When I studied [category theory](https://en.wikipedia.org/wiki/Category_theory) I was struck by how expressive such simple diagrams can be if used correctly. After reading [Lewis and Fowler on microservices](http://www.martinfowler.com/articles/microservices.html) I was inspired to develop a somewhat formal "diagrammatic language" for systems. First we outline some distinctions, and then we explained the formalism.

A **system** is any collection of things working together as a functional whole. Intuitively, a **component** is any one of these things that form part of the system. More formally, a component is a *unit within a system* that is *independently changeable*. The two parts of the definition of a component give us two axes by which different components can be distinguished from one another: their mode of operation and their mode of independence.

On the first axis we have **functions** and **channels**. For any component we can consider its operation in terms of a request-response cycle, broadly construed. Either the response or the request can be null, of course, which cases correspond to pure requests and void responses respectively. Functions, then, are components *which use other components as part of their operation*. Channels, by contrast, are components which don't.

On the second axis we have **algorithmic independence** and **operational independence**. Algorithmic independence means that we can change the component *without having to change how the component is used*. Operational independence means we can apply changes to the component *without having to touch other components*. As it stands, operational independence entails algorithmic independence, but we'll stipulate that when we talk about the independence of a component we're interested in its highest level of independence. In this sense then, an algorithmically independent component is not operationally independent and vice versa.
