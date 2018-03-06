---
author: 'Harald Schilly'
date: 'January 12, 2018'
title: 'The focus of CoCalc'
categories: ['cocalc']
---

Last year we widened our focus and <a href="http://blog.sagemath.com/cocalc/2017/05/20/smc-is-now-cocalc.html">renamed the project from "SageMathCloud" to "CoCalc"</a>.
You can work with SageMath, Python, R and several other languages. The focus is:

<p style="text-align: center"><strong><span style="font-size: 120%;">Collaborative Calculation in the Cloud</span></strong></p>

This means we designed our service with collaboration in mind. Changes to an interactive document are synchronized with all collaborators of the project.
They are invited by you and can be your colleagues, friends or in some cases, your students.

## Python, SageMath, Octave, Julia or R?

CoCalc speaks many of the best open-source languages and brings along a large set
of associated libraries. This means you no longer have to **setup your own software environment** and continue to worry about updating and maintaining it.

Have a look at the list of currently installed libraries for
<strong><a href="https://www.cocalc.com/doc/software-python.html" target="_blank">Python</a></strong>,
<a href="https://www.cocalc.com/doc/software-r.html" target="_blank"><strong>R Statistical Software</strong></a>,
<strong><a href="https://www.cocalc.com/doc/software-julia.html" target="_blank">Julia</a></strong>,
and a selected list of <strong><a href="https://www.cocalc.com/doc/software-executables.html" target="_blank">available executables</a></strong>.

## Native Jupyter Notebooks

CoCalc offers its own unique integration of Jupyter Notebooks.
You can start by uploading your files or creating a new file with ease.
There are many kernels available and a large collections of libraries are regularly updated.
All cells and the state of the kernel are **synchronized in real-time** with your collaborators.
Share ideas in a **side-by-side chat** and review changes via **time-travel history**.
Once you're done, you can download your worksheet as a **standard `*.ipynb` file** or
publish the notebook online via CoCalc's own share server.

<p style="text-align: center">
<img src="{{ '/img/focus/cocalc-jupyter-kernels.png' | prepend: site.baseurl }}" style="width:45%">
</p>

## LaTeX Editor, Sage Worksheets, chat, teaching courses, and much more

All previously available applications are still fully supported.
In fact, we spent endless hours in debugging a lot of issues, improving the overall performance, and invested heavily in the overall system stability.
We switched to a fully containerized system using [Docker](https://www.docker.com/) and [Kubernetes](https://kubernetes.io/) helps us to take care of operational details.

Below is an assorted collection of screenshots to show you an overview.
You can edit LaTeX documents in a side-by-side editor, do mathematics in Sage Worksheets,
access a wide range of software in the underlying Linux terminal,
and even teach a course using our advanced course management feature.

<table>
<tr>
    <td><img src="{{ '/img/focus/01-worksheet.png' | prepend: site.baseurl }}"></td>
    <td><img src="{{ '/img/focus/02-courses.png' | prepend: site.baseurl }}"></td>
</tr>
<tr>
    <td><img src="{{ '/img/focus/03-latex.png' | prepend: site.baseurl }}"></td>
    <td><img src="{{ '/img/focus/05-sky_is_the_limit.png' | prepend: site.baseurl }}"></td>
</tr>
</table>

## Publishing documents

And finally, after you have finished your work and you want to share it with the world,
CoCalc offers you the ability to [publish selected documents online](https://cocalc.com/share/).

