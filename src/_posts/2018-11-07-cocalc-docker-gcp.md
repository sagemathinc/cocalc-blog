---
author: "William Stein"
date: "November 7, 2018"
title: "Running Your own Free CoCalc Docker Server on Google Cloud Platform"
categories: ["cocalc"]
---

## Introduction

[CoCalc](https://cocalc.com) is a web application that lets you collaboratively
use a large amount of free open source
math and data related open source software. You can create
collaborative [Jupyter notebooks](http://jupyter.org/), edit LaTeX documents, use
Terminals, use [graphical Linux applications](http://blog.sagemath.com/cocalc/2018/11/05/x11.html), create chatrooms,
and much more. There's extensive support for [SageMath](http://www.sagemath.org/), [Octave](https://www.gnu.org/software/octave/) (a MATLAB clone),
and [R](https://www.r-project.org/).  See [the docs](https://doc.cocalc.com/).

[Cocalc-docker](https://github.com/sagemathinc/cocalc-docker)
is a completely free and open source self contained version of
CoCalc, which you can run on your own computer or cloud server.
This post is about how to freely play around with running
CoCalc-docker on Google Cloud Platform.

If you scroll down and see all the cool things CoCalc can do, but
don't want to bother running your own server, make an
account at [CoCalc](https://cocalc.com)  and use our hosted
service, which has filesystem snapshots, a vast amount of preinstalled software (much more than cocalc-docker), and
support.

## Sign up for Google Cloud Platform

<div style="text-align: center;">
<a href="https://cloud.google.com/free/" target="_blank"><img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.34.45 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
></a>
<br>
<em>Click above to learn about Google Cloud Platform's free trial</em>
</div>

## Create a Container Instance

### Where to run it?

Choose a location near you:

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.31.32 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Choose where to run the container close to you, for optimal speed!</em>
</div>

### Select to run a container directly (and configure your machine type)

Click the checkbox next to "Deploy a container image to this VM instance.", then
put `sagemathinc/cocalc` in the blank below "Container image". Also check
the boxes next to buffer stdin and allocate a tty.

You can also change the machine type, though the default will work.

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.32.19 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Container Image and Machine type</em>
</div>

### Increase Base Image Size to at least 20GB!

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.32.47 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
><a href='http://www.sagemath.org/'>http://www.sagemath.org/</a>
<br>
<em><b>CRITICAL:</b> increase the base image size to at least 20GB!  The default of 10GB will fail.</em>
</div>

### Allow the container to provide an HTTP/HTTPS web server

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.32.53 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Enable https and http access</em>
</div>

### Make the instance pre-emptible (optional)

If you are just playing around to test this out, open "Management, security, disks, networking, sole tenancy" and
scroll down and set "Preemptibility" to On. This will make things **way cheaper** (using less of your free trial credits). This is especially useful if
you wan to do a relatively quick but very CPU intensive parallel computation.

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.33.09 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em></em>
</div>

Here's how our cost estimate comes out so far, with preemptible on.  It would be about **four times as expensive** without preemptible on.

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 10.57.06 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Pretty cheap...</em>
</div>

Of course the drawback of preemptible is that the machine will be killed within 24 hours. That's fine for
testing things out though.

### Click Create at the bottom to start creating your VM

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.33.43 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>You'll see this line in your list of VM's when the instance is being created</em>
</div>

### Watch the Serial Port

Once the VM is created, click to open it, then click "Serial port 1 (console)" (or "Connect to serial console"), to
watch the log as the machine boots up.

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.37.34 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Watch the Serial Port</em>
</div>

It takes at least **10 minutes** to pull and decompress the `sagemathinc/cocalc` Docker image. If this fails, you
probably forgot to increase the size of the boot disk from 10GB to 20GB (or more), in which case you should delete everything
and start over.

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.44.21 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Wait at least 10 minutes until you see the above</em>
</div>

### Determine the IP address

Once your machine is running _and_ the `sagemathinc/cocalc` image has been pulled and decompressed,
find the external ip address of your machine, and open it in a new browser tab. In my case, I
open `https://35.227.184.91/`.

Do **NOT** choose the address that starts `10.`, since that is internal.

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.44.53 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Copy your IP address</em>
</div>

If this fails, you probably forgot to check the box next to "Allow HTTPS traffic".

### Security warning

Since the SSL cert in the Docker image is self-signed, you'll get a warning. Click through it by
clicking "ADVANCED".

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.45.00 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Click ADVANCED</em>
</div>

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.45.06 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Click Proceed...</em>
</div>

### Create a new account on your personal CoCalc server

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.45.16 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Click to create an account...</em>
</div>

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.45.37 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Create an account</em>
</div>

**WARNING:** Anybody who knows the IP address can make an account in the same way. There's no
secret token, and currenly no way to configure one with GCP Container Image. See [this issue](https://github.com/sagemathinc/cocalc-docker/issues/34).


### Connected?

Click the network icon in the upper right:

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.57.35 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Your ping time should be small</em>
</div>


### Make a test project

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.45.45 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Make a project</em>
</div>

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.46.10 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Open your project</em>
</div>

### Let's take our project for a spin

Click "+New" (or click the big "Create or Upload" button) to show the new file page:

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.46.26 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Start using it by creating a file</em>
</div>

Make whatever files you want and play around with them. I'll make a few below, just for fun, to
give you a sense of what is possible.

### The Octave Graphical Interface

Octave is a MATLAB clone, and you can run the graphical UI of Octave by clicking "X11 Desktop",
then typing `octave`, and clicking the tab on the right when it appears. I copied some [code to draw a 3d plot](http://octave.org/doc/v4.4.0/Three_002dDimensional-Plots.html):

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.50.16 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Using the Octave Graphical Interface</em>
</div>
[Graphical Linux applications](http://blog.sagemath.com/cocalc/2018/11/05/x11.html) should be pretty fast, since
the server is dedicated to you and should be very close to you.

In the image above, I split the X11 frame to show the graphics
on one side and the Octave UI on the other.

### A Jupyter Notebook

Next, let's create a Jupyter notebook:

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.50.44 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>In the +New page, click on "Jupyter notebook".</em>
</div>

Once the notebook appears, I set the kernel to Octave, and pasted the same code in:

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.51.27 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Drawing a Sombrero using Jupyter and Octave</em>
</div>

### A Sage Worksheet

Next, let's make a [SageMath](http://www.sagemath.org/) worksheet; of course CoCalc-docker comes with the latest version of Sage.

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.51.36 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Click the Sage worksheet button</em>
</div>

Let's draw an interactive 3d plot using Sage.

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.53.01 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Choose a plot from the drop down menu</em>
</div>

You should be able to rotate 3d plots around with your mouse:

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.53.18 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>I chose a 3D polytope</em>
</div>

You can find thousands of additional plotting examples in the [Sage reference manual](http://doc.sagemath.org/html/en/reference/index.html#graphics).

### Use LaTeX

Next, let's create a LaTeX document.

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.53.29 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>In +New, click LaTeX</em>
</div>

A new LaTeX editor will appear. Edit source on the left, see the preview (on save) on the right. Double click
the preview to go to the corresponding point in the source, etc.

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.53.55 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Edit a LaTeX document</em>
</div>

### Files
Click Files at the top and you'll see that we've made a lot of files:
<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.54.13 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Files in our Project</em>
</div>

### Full Emacs

For fun, let's
click on the tab for your X11 desktop (the file ending in .x11), then type
```
emacs *.tex &
```
to open that same LaTeX file in Emacs.  Then click the Emacs tab on the right.
<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 8.56.50 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Open our LaTeX file in classical Emacs in the X11 Desktop</em>
</div>

You can hit control+c twice in Emacs to build the LaTeX file from there, and have full [AUCTeX support](https://www.gnu.org/software/auctex/).

###  Microsoft Visual Studio Code

[Visual Studio Code](https://code.visualstudio.com/) is also included with cocalc-docker.  I tried using the
[LEAN proof assistant](https://leanprover.github.io/) in it and it works great.

In your X11 Desktop (file ending .x11 terminal), type `code a.lean &` and VS Code pops up.

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 10.39.32 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Using Microsoft Visual Studio Code's LEAN proof assistant mode</em>
</div>

When you edit the file, it'll offer to search the marketplace for a plugin to support LEAN.
It'll install it with a click, and then you have LEAN fully working.  Note that the LEAN
server itself is already preinstalled in CoCalc-docker,
and you can also just open a.lean directly from the Files
listing in CoCalc to use CoCalc's own LEAN editor (or you
could install one in Emacs).


### Draw some Doodles

CoCalc-docker also includes [Inkscape](https://inkscape.org/) and [Libreoffice](https://www.libreoffice.org/):

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 9.38.38 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Doodle in Inkscape and Libreoffice draw</em>
</div>


### Learn how to write Python3 Games

You can even [use pygame](https://www.pygame.org/wiki/GettingStarted) to write and play Python3 Games:

<div style="text-align: center;">
<img
    src="{{ '/img/cocalc-docker-gcp/Screenshot 2018-11-07 at 9.48.26 AM.png' | prepend: site.baseurl }}"
    style="width:90%"
>
<br>
<em>Play a Game</em>
</div>

NOTE: sound is currently not supported.


## Conclusion

Thanks for giving Cocalc-Docker a spin.   I hope you find
the wide range of collaborative web-based functionality
useful to supporting your teaching and research.  Please
let me (William Stein) know what you think in the comments below, or
by emailing [help@sagemath.com](mailto:help@sagemath.com).


