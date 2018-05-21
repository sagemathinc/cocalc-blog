---
author: 'Harald Schilly and Hal Snyder'
date: 'May 21, 2018'
title: "Embedding CoCalc in Your Application"
categories: ['cocalc']
---
Add scientific computing to
any online training platform
by embedding CoCalc.

Embedding CoCalc into an online learning platform or [learning management system](https://en.wikipedia.org/wiki/Learning_management_system) (LMS) adds:

- programming environments for today's scientific programming languages
- thousands of [installed software packages and libraries](https://cocalc.com/doc/software.html), updated regularly
- interactive computing using Jupyter notebooks and Sage worksheets
- real time collaboration
- [mathematical typesetting](http://blog.cocalc.com/latex/2017/02/06/smc-for-latex.html) with LaTeX
- scalable computing resources - allocate among students as needed
- [distribute, collect, and grade](https://tutorial.cocalc.com) class assignments

<div style="text-align: center;">
<img
    src="{{ '/img/embed/cc-in-iframe-3.png' | prepend: site.baseurl }}"
    style="width:80%"
>
</div>


For readers unfamiliar with the platform, the next two sections introduce two key features of CoCalc, notebooks and markdown.

## Jupyter Notebooks

These interactive documents mix executable code cells with cells for Markdown text (see below).

A notebook contains headers and sections, text with explanations, and code with plots.
Creating an assignment can be as simple as leaving selected code cells empty.

Multiple notebooks per topic are supported.
Splitting a topic keeps the
scope of a learning session manageable and reduces the
confusion that can arise from large numbers of variables.

CoCalc users can choose from a growing list of tutorial notebooks and texts in the [CoCalc library](http://blog.cocalc.com/cocalc/2018/03/06/cocalc-library.html), which allows files to be copied directly into a CoCalc project.

## Markdown

Markdown is a simple way of formatting text. It is easy to learn
and converts readily into other online formats such as HTML.
There are several descriptions online, including the
[one-page summary at CommonMark](http://commonmark.org/help/),
which also includes a link to a brief tutorial.

Markdown is used in Jupyter notebooks and CoCalc worksheets for
explanatory text, which can include mathematical expressions
typeset in LaTeX.
A typical notebook is an executable narrative
consisting of alternating markdown and code cells.

## CoCalc Pricing

CoCalc pricing is based on upgrade packages that include network access, disk space, memory, etc. You can apply upgrades to any project on which you are an owner or collaborator. Upgrades are available
under two types of plan:

* Personal subscriptions. Can be purchased by the month or the year.
A subscriber can distribute upgrades to all projects he or she is a collaborator on.
* Course packages. Available for 1 week, 4 months (a semester),
or a full year. These do not auto-renew.

https://cocalc.com/policies/pricing.html

## The API

The basic setup is to get an API key from your account page, and then issue calls to CoCalc. You can create accounts and projects, and coordinate everything using your own system and database.
The CoCalc website has an [API reference](https://cocalc.com/doc/api.html) which documents each call and provides examples. The CoCalc team will work with customers to resolve any issues that arise.

[Minerva Schools at KGI](https://www.minerva.kgi.edu/) are [using the CoCalc API](http://blog.cocalc.com/jupyter/api/2018/03/01/minerva-and-cocalc.html) to enable their students to work in Jupyter notebooks embedded inside an iframe on their website.

## IFrame URLs

You may want to remove the upper menu bars when embedding a CoCalc file in your application. In that case, there is a special syntax for the URL to the file.
The word "files" appears within the URL and "?session=&fullscreen" is appended to the URL.

Here's an example:

https://cocalc.com/projects/cd3c25e4-5fbd-439b-9604-6011584af918/files/EMBED/batman-python.ipynb?session=&fullscreen

To prevent exiting fullscreen mode, append "=kiosk".

https://cocalc.com/projects/cd3c25e4-5fbd-439b-9604-6011584af918/files/EMBED/batman-python.ipynb?session=&fullscreen=kiosk

## Conclusion

If you already have an online learning platform and want to include the scientific computing features that CoCalc has to offer, you can use the pointers above to get started.
To learn more, contact CoCalc support via
<a href="mailto:help@cocalc.com?subject=embed CoCalc">email</a>
or visit [the CoCalc help page online](https://cocalc.com/help?session=).

