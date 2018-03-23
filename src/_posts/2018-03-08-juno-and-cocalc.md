---
author: 'Alex Staravoitau'
date: 'March 8, 2018'
title: 'Juno and CoCalc: Bringing Jupyter Notebooks to the iPad'
categories: jupyter
---
<div style="text-align: center;">
<img src="{{ '/img/juno-cc/devices.png' | prepend: site.baseurl }}" >
</div>

*About the author:
Alex Staravoitau is a software engineer and machine learning enthusiast, the creator and main contributor of [Juno](https://juno.sh), which is a Jupyter Notebook client for iOS.*

## Juno
At Juno, we all have been huge fans of Jupyter for awhile, and most importantly of the flexibility it offers: we strongly believe that the fact that you only need a screen and network connection to get access to pretty much unlimited computational resources has enormous potential. Naturally, we thought that Jupyter could use a proper client iOS application with a native interface, that would let you connect to a remote backend and work with Jupyter on your iPad. Now, after months of making and beta testing our app, Juno has made it to [the AppStore](https://itunes.apple.com/us/app/juno-jupyter-notebook-client/id1315744137?mt=8)!

<div style="text-align: center;">
<img src="{{ '/img/juno-cc/juno-g8.png' | prepend: site.baseurl }}" width="60%" >
<br>
<em>screen capture of Juno running on iPad</em>
</div>


[Juno](https://juno.sh) is a Jupyter Notebook client for iOS, which allows you to connect to an arbitrary remote Jupyter Notebook server, and do pretty much everything you do in desktop Jupyter on your iPad. It supports hardware keyboards and code completion driven by your server's kernel. It has a beautiful touch-friendly interface that feels much more natural than trying to access Jupyter through your iPad's Safari browser.

## CoCalc
However, it still felt like Juno was lacking a seamless out-of-the-box experience for users not familiar with Jupyter, or who didn't want to go through the hassle of configuring their own server. That is where [CoCalc](https://cocalc.com) came into play. It seemed like a perfect use case for Juno, acting as a computational backend that Juno users could connect to by simply logging in with their CoCalc account.

<div style="text-align: center;">
<img src="{{ '/img/juno-cc/juno-3.png' | prepend: site.baseurl }}" width="60%" >
<br>
<em>Juno displaying project list in CoCalc</em>
</div>

CoCalc was our top choice, since none of the alternatives offered the extensive collection of [executables](https://cocalc.com/doc/software-executables.html) and [libraries](https://cocalc.com/doc/software-python.html) that CoCalc supports, and, more importantly for us, an API to integrate with. [The CoCalc API](https://cocalc.com/doc/api.html) was the key factor that essentially allowed us to build a native CoCalc client, and deliver truly seamless experience for working in CoCalc on your iPad. Although projects management is fairly basic right now, you can create and navigate (and launch, of course!) your existing CoCalc projects with ease. Needless to say, we were lucky to have CoCalc as a launch partner, and will keep evolving its integration in Juno as their API matures.

## Try it!
Juno is available as a [free download](https://itunes.apple.com/app/juno-jupyter-notebook-client/id1315744137) with an optional purchase of Juno Pro in case you want to access an arbitrary Jupyter Notebook server or use your CoCalc account. We tried to make free version of Juno fun as well: you can run introductory notebooks on Python, NumPy, Matplotlib and SciPy out of the box, and we plan to keep adding more notebooks to play with.

We would like to take this opportunity to thank the CoCalc team for sharing our idea of seamless Jupyter experience, and for providing prompt support during integration. Also, we would like to thank all beta testers who helped testing Juno and shared their feedback. Thank you once again, and we hope you will enjoy all the new things planned for Juno in the coming year!

<p align="center">
  <a href="https://itunes.apple.com/app/juno-jupyter-notebook-client/id1315744137"><img src="{{ '/img/juno-cc/dl-appstore.png' | prepend: site.baseurl }}" width="20%"/></a>
</p>




