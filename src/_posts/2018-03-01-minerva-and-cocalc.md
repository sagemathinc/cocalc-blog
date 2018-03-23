---
author: 'Hal Snyder'
date: 'March 1, 2018'
title: "Minerva's use of CoCalc Collaborative Jupyter Notebooks in their Active Learning Forum"
categories: ['jupyter', 'api']
---


[Minerva Schools at KGI](https://www.minerva.kgi.edu/) is an innovative university that makes extensive use of web technology to reinvent the classroom experience.  [CoCalc](https://cocalc.com) is collaborative web-based software that makes it possible to very easily use the full suite of modern open source technical software, including Jupyter notebooks, LaTeX, Sage, and R.  We launched CoCalc in 2013, originally under the name SageMathCloud.

Minerva approached us last year because they needed to embed collaborative Jupyter Notebooks in their platform to support teaching computer science and other data intensive courses.  Throughout much of 2017, we supported Minerva's integration of CoCalc with their *Active Learning Forum*, and today
they are one of our biggest customers.


In May 2017, Minerva was investigating approaches to allowing students to collaborate on Jupyter notebooks. Classes at Minerva take place as [distributed interactive video seminars](https://www.minerva.kgi.edu/academics/small-seminars/), rather than in a conventional lecture hall, and they make heavy use of multiple people editing documents simultaneously.   Real-time synchronization can be difficult and costly to implement. With CoCalc, realtime collaboration has always been available for all document types. In March 2017, we also launched a completely [new React front end for Jupyter notebooks](http://blog.sagemath.com/jupyter/2017/05/05/jupyter-rewrite-for-smc.html) that better supports collaboration.

Minerva has long used collaborative Google Docs to support their web-based classrooms, and had developed sophisticated
course management functionality.
Their requirements were different than that of our other customers, which are mostly courses in traditional universities.
Minerva manages authentication of users through their platform, distribution of content and grading.

Once we understood that Minerva definitely did not plan to use
the course management functionality we developed for CoCalc
and why, we decided to create an API that would allow Minerva to
use exactly what they wanted from CoCalc in their own way.
From June through August 2017, we developed from scratch an [HTTP API](https://cocalc.com/doc/api.html), making most
of CoCalc available to server-side clients.  Minerva then built out their platform to use our API.

The integration went live in late August, and has been used extensively since then.  There was some major painful initial friction.  For example, their unusual usage patterns at exactly the same time as a huge course at UCLA, resulted in gigantic
load spikes that overwhelmed our database.  We temporarily increased
the database size, studied what was wrong, then optimized our backend
to much more easily handle the load.

Keeping our infrastructure scalable and extensible are major ongoing challenges with CoCalc, due to the difficult computational nature of the problems CoCalc solves.  Right now, we often have over 1000 people simultaneously running Jupyter notebooks, editing LaTeX documents, running computationally intensive analysis of genomics data, and more.  It is quite challenging to maintain so many potentially long running sessions at a reasonable cost to users.  And the scaling challenges keep getting more interesting; for example, one challenge that Minerva hopes we can solve (cheaply!) is to support up to 500 people simultaneously viewing a single collaborative Jupyter notebook, while it is being actively edited by several dozen users.

Once discovered, it’s easy to use our API.  So far, the only other significant user of the HTTP API is in a completely different direction than Minerva. [Juno.sh](https://juno.sh/) is an innovative new iPad application for using Jupyter notebooks. Juno uses our API to show users a list of projects, connect to notebook servers, etc.

If you're interested in using our API to embed Jupyter notebooks or other interactive collaborative computational content into a web application you're developing, [don't hesitate to contact us!](mailto:help@sagemath.com)
