---
published: true
title: Throughput and latency
layout: post
tags: []
categories: []
---
I often struggle to remain clear on the distinction between throughput and latency. The other day I stumbled upon an example that helped me a little in this area. Imagine you have a system which acts like a pipeline: you put jobs in on the one side, they get executed, and their results come out the other side in some way (presumably by changing the state of the word somehow). A *latency* of this system measures how long it takes for one of these jobs to complete. Other latencies might be how long it takes you to add a job to the system, how long it takes to update state once its figured out what to do, and so on. The key thing is that each of these is measured *in time units*. You decrease the latency of the system by making the various components faster. The *throughput* of this system, by contrast, is how many of these jobs can be done *in a fixed time period*. If each job goes through a number of steps between starting and completing, then the system's throughput could be increased by letting it work on different steps of multiple jobs simultaneously. That way, instead of waiting for the previous job to finish *all* steps before the next can start, it only has to wait until the *next* step is finished.
