---
published: true
title: "Systems diagrammatically, part 2"
layout: post
tags: []
categories: [formalisms]
date: 2016-10-26 01:01:01 +00:00
---
In our [previous post]({{ site.url }}/formalisms/2016/10/25/systems-diagrammatically.html) we made a number of distinctions between the kinds of components one can find in a system, and we talked about how to depict functions and channels. In this post we'll briefly consider how algorithmic and operational independence are depicted.

<div class="mermaid">
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
</div>
