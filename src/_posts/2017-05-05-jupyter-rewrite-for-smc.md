---
author: 'Hal Snyder'
date: 'May 5, 2017'
title: 'New SMC Jupyter Client Released'
categories: jupyter
---
Today SageMath, Inc. is pleased to announce the release of a completely new Jupyter notebook implementation, optimized for SageMathCloud, our cloud-based, collaborative environment.

This new implementation was motivated by the need for better collaboration and browser/server synchronization. Rewriting also offered an opportunity to integrate previously-unavailable features of SMC into Jupyter notebooks. However, throughout this process we minimized interface discrepancies between old and new versions so that switching is as seamless as possible.

Here's an overview of the most significant enhancements in today's release:

## Collaboration

### Simultaneous Editors

Simultaneous editing by multiple people is now fully supported, including multiple cursors and document-wide, user-specific undo and redo.

<div style="text-align: center;">
<img src="{{ '/img/j2/two-users.png' | prepend: site.baseurl }}" style="width:95%" >
<br>
<i>User One and User Two editing a notebook at the same time.</i>
</div>

### Chat

Each notebook now has a chat sidebar. As always, chat supports markdown, $\LaTeX$, and video chat.

<div style="text-align: center;">
<img src="{{ '/img/j2/chat-with-md-latex.png' | prepend: site.baseurl }}" style="width:95%" >
<br>
<i>Text chat with markdown shown in panel to right of notebook body.</i>
</div>

## Server-side enhancements

### TimeTravel
Jupyter includes TimeTravel just like our other editors. It shows detailed history of all changes to a notebook, and the author of each change.

<div style="text-align: center;">
<img src="{{ '/img/j2/timetravelj2.png' | prepend: site.baseurl }}" style="width:95%" >
<br>
<i>Time Travel view of previous notebook as seen by User Two<br>showing revision 93 (of 95) created by User One.</i>
</div>

### Output

- Sophisticated handling of large output: throttling, windowing, back-end buffering.
- Background capture of execution output, even if no user has the notebook open in their browser.

<div style="text-align: center;">
<img src="{{ '/img/j2/big-1.png' | prepend: site.baseurl }}" style="width:95%" />
</div>

<div style="text-align: center;">
<img src="{{ '/img/j2/big-2.png' | prepend: site.baseurl }}" style="width:95%" />
</div>

## User interface

- Cleaner, more modern look with buttons and menus that better reflect state.
- Better mobile web support.
- Uniform font sizing.
- Code folding.
- Vim, Emacs, and Sublime keybindings, and color schemes (in account settings).
- Export notebook file to LaTeX using "File > Download as... > LaTeX (.tex)...".

<div style="text-align: center;">
<img src="{{ '/img/j2/p-p-i.png' | prepend: site.baseurl }}" style="width:95%" >
<br>
<i>Sample notebook about to be exported.</i>
</div>

<br>

<div style="text-align: center;">
<img src="{{ '/img/j2/p-p-m.png' | prepend: site.baseurl }}" style="width:52%" >
<img src="{{ '/img/j2/p-p-e.png' | prepend: site.baseurl }}" style="width:38%" >
<br>
<i>Exporting notebook to Latex and opening the .tex file in SMC.</i>
</div>

<br>

<div style="text-align: center;">
<img src="{{ '/img/j2/p-p-t.png' | prepend: site.baseurl }}" style="width:95%" >
<br>
<i>Converted ipynb file opened in LaTeX editor.</i>
</div>

- A purely client-side notebook viewer for easily sharing your work publicly.
- Raw file edit mode: synchronized editing of underlying JSON ipynb file. See resulting changes to the rendered notebook in real time.

<div style="text-align: center;">
<img src="{{ '/img/j2/raw.png' | prepend: site.baseurl }}" style="width:85%" />
</div>


- Object view of notebook, potentially useful for debugging or developing advanced applications.
- Jupyter notebooks are now supported in Firefox. Previously, opening them was disabled in Firefox on SMC due to browser issues that resulted in file truncation.

## Conclusion

Try the new Jupyter client right now at <https://cloud.sagemath.com>. To start a new Jupyter notebook, log into SMC, create a project if you haven't already, select that project, and follow instructions [here](https://github.com/sagemathinc/smc/wiki/sagejupyter#ipython-nb). Different programming languages are available by selecting different back ends, known as Jupyter kernels. The new notebook supports the same collection of kernels and programming environments as the old version.

Users who need the older Jupyter client can open the project Settings tab, scroll to bottom right, and click on "Plain Jupyter Server".

<em>Note: Some functionality of classical extensions and widgets are not yet supported (if you need something, let us know).</em>

\###