---
author: 'Hal Snyder'
date: 'February 6, 2017'
title: 'SMC for Collaborative LaTeX Editing'
categories: latex
---
SageMathCloud (SMC) is the most powerful online $\LaTeX$ collaboration software available today.
SMC offers the full complement of features expected from online services today
for professionals and students, on a par with and exceeding other leading products, such as Overleaf and ShareLaTeX.
In addition, SMC offers a complete environment for teaching, research, and exploratory computing with the same rich feature set.

---

Here's an overview of key SMC features to back up the claims of the previous paragraph.


## Collaboration

SMC has full simultaneous real-time collaboration with no explicit limit
on the number of simultaneous users. Each user can customize the color
of their cursor.

If your network connection temporarily fails, you can continue editing as long as you want, and your changes will be merged into the live document when you reconnect. In contrast, ShareLaTeX starts flipping out, locking the editor, fully refreshing the browser, etc. Overleaf also instantly locks
editing.

If the user creates multiple cursors (like in Sublime Text) using
command or alt click, all cursors are visible to other users. This is not the case with ShareLaTeX and with
Overleaf. Overleaf doesn’t even show cursors of other users.

<div style="text-align: center;">
<img src="{{ '/img/twocursors.png' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Collaborator Hal using two cursors.</i>
</div>

In addition, as with Google docs, SMC has a chat on the side of each
document. Improving on Google docs, you can include mathematical
formulas and markdown in the side chat which are beautifully rendered,
and <i>edit</i> any past chat message.
Other collaborators are notified of messages via a bell in the upper
right, similar to Facebook. In comparison, Overleaf doesn’t have
document chat; ShareLaTeX has it, but does not allow editing past chats
or Markdown formatting.

<div style="text-align: center;">
<img src="{{ '/img/sidechat.png' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Editable chat beside file views.</i>
</div>

SMC has $\TeX$-aware spell checking.


## Viewing Document History and Backups

Every edit (at 2-second resolution) is recorded and stored forever in
our backend database. You can browse the history using the TimeTravel
view, which includes a diff mode that shows exactly what changed between
two points in time (and who made those changes).

<div style="text-align: center;">
<img src="{{ '/img/timetravel.png' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Edit history showing diff between two versions.</i>
</div>

In addition, we store several hundred read-only snapshots of the complete
filesystem state, which users can easily browse. This lets them recover
older versions of files that might not have been edited via the
graphical editor (e.g., vim or emacs via a terminal).

<div style="text-align: center;">
<img src="{{ '/img/backups.png' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Accessing backups of a file.</i>
</div>

<div style="text-align: center;">
<img src="{{ '/img/snapshots.png' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Recent snapshots of project shown under backups.</i>
</div>

You can use Git, Subversion, RSync, etc. on the command line to
explicitly track all files or synchronize with a remote server such as
GitHub.

## No Local Software Needed, Use Anywhere

Because SMC is a cloud service, there is no software to install locally, and projects are reachable from any device with an internet connection. Files can be exported online to .pdf and .docx format without the need for local installation of $\LaTeX$ software.

## Advanced Editing Features

### Build Environment

SMC fully supports processing even the most complicated imaginable $\LaTeX$
documents using custom build systems. We support several $\LaTeX$ engines --
pdflatex, latexmk, and xelatex -- with most packages preinstalled. Users
can easily request additional packages (by clicking the help button), or
install them themselves. The $\LaTeX$ build command is fully customizable,
and can involve running arbitrary Linux programs, since we offer a
full command line terminal environment. It is, for example, even
possible to use GNU `make` to orchestrate the full
compilation via a `Makefile`. This is overall far more
powerful than the build options with Overleaf and ShareLatex. You can
put anything you want in the command line in the image below:

<div style="text-align: center;">
<img src="{{ '/img/xelatex.png' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Customizing build command to use XeLaTeX.</i>
</div>

### Dynamic Content

Our $\LaTeX$ editing environment comes with SageTeX pre-installed,
which makes it easy to add the output of Python (and SageMath!)
computations to any $\LaTeX$ document. No competitors offer running
sophisticated mathematical software as part of the compilation process.
This is very useful to people creating randomized homework, too.

Besides SageTeX, SMC supports embedding R code via knitr into $\LaTeX$
documents. This technique is very popular for generating documents with
statistical and data science content.
Overleaf and ShareLaTeX have only limited R support.

<div style="text-align: center;">
<img src="{{ '/img/rmarkdown.png' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Compiling an R Markdown File in SMC.</i>
</div>

Our environment offers integrated Jupyter notebooks and Sage
worksheets, with chat and TimeTravel as well.
Jupyter notebooks are an excellent rich editor for creating certain types of
$\LaTeX$ documents. For example, many books and papers have been written
entirely in Jupyter notebooks, then published both to the web and
exported (via `nbconvert`) as $\LaTeX$ documents. The two images below
show use of $\LaTeX$ in Sage worksheets.
Cells can be started with `%latex` to typeset their contents using $\LaTeX$.

<div style="text-align: center;">
<img src="{{ '/img/sagewsastro.png' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Sage worksheet with $\LaTeX$ in markdown and symbolic expressions, with
units of measure.</i>
</div>

<br>

<div style="text-align: center;">
<img src="{{ '/img/sagewslatexr.jpg' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Sage worksheet with symbolic expression and calculation in R.</i>
</div>

We [provide a Docker image](https://github.com/sagemathinc/smc/blob/master/src/dev/docker/README.md)
so that users who need an
offline version of SMC in which to use $\LaTeX$ (e.g., on an flight) can
easily do so.

### Editor User Interface

SMC fully supports online preview, even for documents that are 150 or
more pages. It progressively refines the resolution of the preview
images and nearby pages. One of the SMC developers wrote the recent
Cambridge University Press book “Prime Numbers and the Riemann
Hypothesis” entirely using SMC.

Preview supports inverse search, which means that by
double-clicking on an area on a preview page, the cursor in the input
area jumps to the corresponding location. Similarly, you can jump from a
point in the text editor to the corresponding point in the preview.

<div style="text-align: center;">
<img src="{{ '/img/forward.png' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Forward search in $\LaTeX$ edit window.</i>
</div>
<br>
<br>
<div style="text-align: center;">
<img src="{{ '/img/inverse.png' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Inverse search in $\LaTeX$ edit window.</i>
</div>

We have a full-featured text editor for $\LaTeX$ documents. Like a coding
IDE, it has horizontal and vertical split view, which lets you look at
two points in the $\LaTeX$ document simultaneously. Also, we wrote a code
folding mode (see <https://github.com/codemirror/CodeMirror/pull/4498>),
so one can easily toggle display of sections, subsections, etc.
(Overleaf has no code folding, but ShareLaTeX does.) We support
Emacs, Vim, and Sublime keybindings, and many color schemes.

We have a side-by-side Markdown (and HTML) editor with realtime
preview, which fully supports $\LaTeX$ formulas.

<div style="text-align: center;">
<img src="{{ '/img/phugoid.png' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Jupyter notebook with Python kernel showing LaTeX.</i>
</div>

### User-friendly experience

Newcomers to $\LaTeX$ find the overall SMC environment helpful for learning how to
typeset formulas. E.g., they will see beautiful math output in Jupyter
notebooks or Sage worksheets, then click to see what $\LaTeX$ code
generated that output, and start using it in their documents. They learn
a few features at a time and include them in their workflow.

SMC has a clean, modern real-time user interface with tens of thousands
of passionate active users. We have been polishing the SMC user
experience based on feedback since April 2013. SMC has users around the
world who give our customer service high marks.

## Access and Security

<div style="text-align: center;">
<img src="{{ '/img/signup.png' | prepend: site.baseurl }}" style="width:75%" >
<br>
<i>Signing up and logging in.</i>
</div>

SMC is fully web-accessible, and we provide sign-in integration with
Google Apps, Twitter, Facebook, and GitHub.

SMC has an integrated course management system, which makes it easy
to fully use $\LaTeX$ with students in the context of teaching courses and
workshops. For example, you can create a document template (with
questions), push it to all students, let them work on it, then collect
it later, grade it, and return it. For more information on this feature
of SMC, see Mike Croucher's guide to the course management system at
<https://mikecroucher.github.io/SMC_tutorial/>.

$\LaTeX$ documents are stored in projects. Users may add a chosen list
of collaborators to a project. There is no limit to the number of
collaborators that may be added, and collaborators can be removed
at any time. By default, files are only visible and editable by
collaborators on a project. Users can make specific files and
directory publicly visible to make sharing easier.

### Secure storage and backup

Here’s our current storage and backup system:

-   The files in your project sit on a VM at Google, whose filesystem is
    snapshotted daily. All files at Google are encrypted at rest (see
    <https://cloud.google.com/security/encryption-at-rest/>).

-   The files are rsync’d to another server whenever your project is
    saved (so every 5 minutes when actively used).

-   The files on the second server are snapshotted using ZFS with
    snapshots saved for six months (but trimmed over time). You can
    expect to have regular snapshots for the past hours, the last few
    days and a few weeks and months before that.

-   Every few hours a Git-based archive is made of modified projects and
    saved in a Google cloud storage bucket, which is
    globally distributed.

-   At least once per week (and usually once per day), we rsync the new
    archives to an encrypted USB drive.

-   We periodically rsync that USB drive to another encrypted USB drive,
    which is stored offline in a locked office at a separate location.

## Computing Resources

As noted above, SMC gives you access to a full Linux environment, with dozens of
programming languages and thousands of libraries and packages pre-installed.
You are ready to go with computer algebra systems for theoretical mathematics,
scientific packages for physical sciences and bioinformatics, and statistical
and machine learning software for data science.

## Pricing and Cost Effectiveness

### Estimated costs

SMC allows for unlimited projects and collaborators, with 3GB of disk
space per project, on free accounts. You can start using SMC for
free right now by creating an account at
<https://cloud.sagemath.com>.

Our pricing is by project and is listed here:

<https://cloud.sagemath.com/policies/pricing.html>

One could in theory, have thousands of $\LaTeX$ documents in the same
project.

We charge for other upgrades, including extra disk space and more RAM.
The two most important upgrades are “outside network access” and
“members-only hosting”. Outside network access makes it possible to
connect to the Internet from within a project in order to push and pull
data to remote sites (e.g., GitHub). Projects are placed on two separate
pools of computers: the free machines and the members-only paid
computers. The computers are similar, but the free ones are rebooted
frequently (usually once every 24 hours) and are more crowded; the
members only machines are almost never rebooted.

<div class="tex2jax_ignore">
The best quantity discount is the “Large course plans”; the price to
provide members-only hosting and have outside network access for one
project is about $10/year. This is cheaper than the published prices
from our competitors.
{% comment %}
For example, ShareLaTeX’s cheapest student plan is
$80/year with a limit of 6 collaborators per project. Overleaf costs
$48/year for students.
{% endcomment %}
</div>

Unlike Overleaf and ShareLatex, we do not remove any of the
functionality of SMC when you use it for free. Having a free account
only limits disk space, network access, and how quickly and
robustly documents are compiled.

{% comment %}

For example, a professor who chose SMC
for his course just told us:

> “A significant part of our Spring 2017 course involves developing
> mathematical proofs and typesetting them in $\LaTeX$. $\LaTeX$ software is
> installed on most campus computers, and is also free to download and
> install on your own computer. However, many students in recent
> semesters have used various online $\LaTeX$ collaborative editing
> environments. These online services run on a ‘freemium’ model: basic
> limited usage is free, but premium paid accounts are also available.
> This semester I recommend SageMathCloud for online $\LaTeX$ editing and
> collaboration. Unlike the other online services, SageMathCloud does
> not limit the free accounts, besides hosting them on lower-prioritized
> server space (which should be perfect for our limited usage!).”

{% endcomment %}

In conclusion, we invite people to use our very powerful $\LaTeX$
environment and see how useful it is. Not just for for creating documents,
but also for computation, research and teaching.

\###
