---
author: 'Hal Snyder'
date: 'March 23, 2018'
title: "Is KaTeX ready for Prime Time? You be the judge."
categories: ['latex']
---

[CoCalc](https://cocalc.com) now offers an option to render LaTeX using [KaTeX](https://khan.github.io/KaTeX/) rather than [MathJax](https://www.mathjax.org/). At the moment, KaTeX is an experimental feature which is turned off by default. To enable it, open Account / Preferences, and under Other Settings, check the box next to "KaTeX: render using KaTeX when possible, instead of MathJax".

<div style="text-align: center;">
<img src="{{ '/img/katex/katex-option.png' | prepend: site.baseurl }}" width="80%" >
<br>
<em>enabling KaTeX in Account Preferences</em>
</div>


KaTeX is often [_**over 100 times faster**_](https://www.intmath.com/cg5/katex-mathjax-comparison.php) than MathJax, but it doesn't handle all expressions covered by MathJax (or LaTeX). In these cases, CoCalc with KaTeX enabled will still fall back to MathJax. The selection happens for individual expressions, so one expression in a markdown file or a notebook cell might be rendered with KaTeX, while another would be rendered with MathJax.

Choosing KaTeX only impacts how *you* see math when interacting with CoCalc; it has no impact on collaborators or students working with you, or on the content of documents you create.

For more about what KaTeX doesn't handle, see for example this discussion of [limitations in the array environment](https://github.com/Khan/KaTeX/issues/269).
Also, KaTeX doesn't support \mbox, but \text is fine.

To see whether a formula is displayed with KaTeX or MathJax, right-click on the rendered formula. If MathJax was used, you will get a dialog pop-up starting with "Show Math As".

<div style="text-align: center;">
<img src="{{ '/img/katex/mathjax-rt-click.png' | prepend: site.baseurl }}" width="50%" >
<br>
<em>right-click showing MathJax dialog</em>
</div>


If KaTeX was used, you will get a generic dialog pop-up, details depending on your browser, not about math.

Note: KaTeX rendering is not enabled in Sage worksheets at this time.

Why not give KaTeX a try? We'd love to know your experiences with it. Let us know by emailing help@sagemath.com.  Based on your feedback and further testing, we intend to make KaTeX the default soon!
