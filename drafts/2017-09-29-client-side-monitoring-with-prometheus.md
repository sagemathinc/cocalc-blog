---
author: 'Harald Schilly'
date: 'September 29, 2017'
title: 'Client-side Monitoring with Prometheus'
categories: cocalc
---

## tl;dr mini-abstract

We use the [prom-client](https://github.com/siimon/prom-client) JavaScript library
to gather front-end metrics from [cocalc.com](https://cocalc.com)
for reporting to [Prometheus](https://prometheus.io/) without a significant overhead.
Together with back-end monitoring this setup gives us a coherent picture of
what is going on.

## Introduction

CoCalc's front-end client is a complex, rich, and stateful single-page application.
A long-term wish of our team is to properly instrument it.
Obtaining an unbiased insight from the user's perspective is vital to quantify performance problems,
be alerted about errors, and to correlate this information with metrics about the back-end.
Also, monitoring it should allow us to not only track performance issues,
but also to measure and motivate development efforts addressing these.

## Many ideas

A single-page web-application is event driven.
These events might come from user input,
sent over wire through a websocket connection,
or stem from other sources.

A rather straightforward idea is to record timings of events,
categorize and tabulate them,
and then sending them back to the server.

This works well for infrequent frequent events or isolated events of high importance.
It does not work well for those of high frequency,
because of the growing overhead of transferring them
and in case they're sent, the growing need to post-process them on the back-end.

It also adds some stress to the back-end,
because the client initiates the data transfers causing many randomly distributed
events for the server to handle.


## Chosen Architecture

Motivated by Prometheus' model of recording events as changes of internal state,


## Implementation

To actually pull this off, we wanted to use the
[prom-client](https://github.com/siimon/prom-client) JavaScript library
for the client and the server.
Out of the box, it does not run on the client.
We use babel to translate its syntax to be backwards compatible,
and [carefully import](https://github.com/sagemathinc/cocalc/blob/master/src/smc-webapp/prom-client.coffee)
the relevant parts of the library.

This doesn't mean that all parts do work, but it is good enough to gather the data.
It would be interesting to know if there is work done towards splitting up prom-client
into a core version for web-browsers and a main version (using this core impelmentation) for node.js.

## Results

Below you can see some initial results from this front-end instrumentation.

<div style="text-align: center;">
<img src="{{ '/img/prom-client/webapp-ping-time-quantiles.png' | prepend: site.baseurl }}" >
</div>

<div style="text-align: center;">
<img src="{{ '/img/prom-client/startup-time-avg-browser.png' | prepend: site.baseurl }}" >
</div>



