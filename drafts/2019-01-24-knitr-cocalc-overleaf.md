---
author: "Harald Schilly and Hal Snyder"
date: "January 24, 2019"
title: "Knitr Support: CoCalc vs. Overleaf
categories: ["cocalc","r","latex"]
---

## Introduction

[Knitr](https://yihui.name/knitr/) is a package
for dynamic report generation in the [R language](https://www.r-project.org/).

Both [CoCalc](https://cocalc.com) and [Overleaf](https://www.overleaf.com/) offer online environments for document creation with the [LaTeX document preparation system](https://www.latex-project.org/).

In this article we offer an up-to-date comparison of `knitr` features in CoCalc and Overleaf, showing that CoCalc is ahead in most categories.

## Comparison Table

| Feature                         | CoCalc                                                            | Overleaf                                               |
| ------------------------------- | ----------------------------------------------------------------  | ------------------------------------------------------ |
| Number of R packages installed¹ | 2,932                                                             | 304                                                    |
| R.version.string¹               | 3.4.4 (2018-03-15)                                                | 3.2.3 (2015-12-10)                                     |
| packageVersion("knitr")¹        | 1.21                                                              | 1.16                                                   |
| support                         | .Rnw, .Rtex, (also .Rmd)                                          | .Rtex (only Rweave syntax)                             |
| forward inverse search          | yes                                                               | no                                                     |
| timeout                         | knitr 6 min, latex 4 min                                          | [30s (anon), 1 min (free), 4 min (pro)](https://de.overleaf.com/learn/how-to/Why_do_I_keep_getting_the_compile_timeout_error_message%3F) |
| R syntax highlighting           | full syntax highlighting                                          | all R code is red                                      |
| R error display                 | separate concise error pane                                       | only in PDF                                            |
| autocompletion for tex commands | ++                                                                | +++                                                    |
| data files                      | yes                                                               | yes                                                    |
| temporary file storage          | yes (project files and /tmp)                                      | yes                                                    |
| persistent storage of cache²    | yes (in project files)                                            | no, just ephemeral                                     |
| update old Rnw documents        | yes ([run R in terminal](https://yihui.name/knitr/demo/sweave/))  | no                                                     |
| multiple source files           | no, [only indirectly](https://doc.cocalc.com/latex.html#how-to-deal-with-large-documents-across-multiple-source-files) | yes, specify main document   |
| install your own R packages     | yes            | no |
| run arbitrary R code (e.g. Jupyter Notebooks)³ | yes | no |

¹ as of 2019-01-23

² This means that any `cache=TRUE` blocks are stored once and – subject to caching rules – are still available in future sessions, even days later! Overleaf's ephemeral store makes caching ineffective.

³ Therefore, you can run code for preparing and generating data and visualizations in the same environment as you're creating the LaTeX document.

---

hsy: another thought: if R is really pinned to a specific version when you start the project in overleaf, we can argue that in cocalc you can choose this (fixed software stack, and by default it updates regularly)

---

### Notes on the table

1. **number of packages** - @hsy: How was this obtained?

   > hsy:
   >
   > ```
   > ip <- installed.packages()
   > dim(ip)[[1]]
   > ```

1. **`R.version.string`** - @hsy: How did you get June, 2017 for Overleaf R version?

   > hsy: I tested it back then, and it was still in the file. Reran it, and it was the same as far as I saw.
   > but it doesn't matter, right now it says: `R version 3.4.1 (2017-06-30)`

1. **`packageVersion("knitr")`** - Again, the version provided by CoCalc is more recent.

1. **file extension:** CoCalc supports usual syntax for .Rnw and .Rmd. Overleaf files have extension .Rtex, but appear to use Sweave syntax rather than usual .Rtex syntax. [to be verified]

1. **forward and inverse search:** CoCalc lets you find matching locations in source and pdf output. For details, see the CoCalc User Manual section on [Forward & Inverse Search](https://doc.cocalc.com/latex.html#forward-inverse-search). Overleaf shows arrow buttons in the gutter between source and pdf for "Go to code location in PDF" and "Go to PDF location in code", but they did not appear to do anything in a multi-page document I tested.

1. **timeout:** @hsy: what is this?

   > I added a link in the table. e.g. try to run `Sys.sleep(60)`. Even 30s causes a timeout for me in my free account.

1. **R syntax highlighting:** CoCalc highlights separate syntactic elements differently. Overleaf shows all R code in red.

   > we should also check **inline** syntax highlighting. I suspect that's another point where cocalc is ok.

1. **R error display:** CoCalc's default screen layout (add screenshot) includes a pane for a concise view of R and LaTeX compilation errors. Overleaf replaces the output frame with copious and error.

1. **autocompletion for tex commands:** available in Overleaf, unsupported in CoCalc.

### Screen captures of sample text

(images here)

## Summary

CoCalc has a more up-to-date and extensive environment for workig with R and LaTeX. Overleaf has autocompletion for tex commands.

---

# raw @hsy text below here

they have 304 packages installed, while we have 2932. Our version of R is also almost year younger (but we are behind their releases, I'm aware of that). They're at June 2017, while our R is from March 2018

Their filename ends with "Rtex" (and their doc page says that's the ending to use), but they don't support Rtex syntax (the one where all commands are in comments). Instead, it's that older rweave syntax with <<>>=. Something is mixed up. (or well, maybe we mix it up, but I doubt that).... syntax highlighting is currently also a joke, because it's only all red.

<table>
<tr><td><img src=images/2019-01-21-syntax-rnw-cocalc.png></td>
<td><img src=images/2019-01-21-rtex-syntax-overleaf.png></td>
</tr></table>

summary:

- syntax highlighting
- Rtex vs. rnw files (mixup, partial support, I'm confused)
- forward inverse search (yes, vs. nothing)
- showing R errors (overleaf just in pdf). ... and I just discovered, that in cocalc the line isn't parsed out of the error output. Maybe not implemented.hmm..
- more modern R, ~10x as many packages, longer timeout (I don't know any numbers)

what overleaf has much better than cocalc is autocompletion for tex commands, and spellcheck (where right-click on a red underlined word gives you a list, etc.)
