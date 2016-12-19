---
title:  "using SMC with python & data science MOOC"
date:   2016-12-16 20:56:37
categories: python mooc datascience
author: halsnyder
---
Here are a couple tips based on my experience using SMC to complete the Coursera course, [Introduction to Data Science in Python](https://www.coursera.org/learn/python-data-analysis). This course is the first installment of a new 5-part [Applied Data Science with Python Specialization](https://www.coursera.org/specializations/data-science-python) from the University of Michigan.

Examples and study assignments for the course are offered as Python3 Jupyter notebooks, i.e. `.ipynb` files. Students may use Coursera-hosted jupyter notebooks or any other platform that allows them to run the code. Homework is submitted by uploading a .ipynb file for each programming assignment.

The following might be helpful for students taking the course and using SMC:

### 1. Set Jupyter kernel.

After uploading a course .ipynb file, change the kernel from `Python3` to `Anaconda (Python3)` as shown below. This will prevent errors such as _AttributeError: 'Index' object has no attribute 'str'_ due to different versions of pandas.

<img src="{{ '/img/change-kernel.png' | prepend: site.baseurl }}" style="width:75%" >

### 2. Convert Jupyter notebooks to Sage worksheets.

If you would rather code in a Sage worksheet than a Jupyter notebook, use the SMC script `smc-ipynb2sagews` to convert the files. Open a terminal file, for example mooc.term, and enter the following commands

    $ cp Assignment\ 2.ipynb assgn2.ipynb
    $ smc-ipynb2sagews assgn2.ipynb
    /usr/local/bin/smc-ipynb2sagews: Creating SageMathCloud worksheet 'assgn2.sagews'
    $ open assgn2.sagews


The first cell in the generated worksheet can be simplified as shown below. Built-in mode `%python3` automatically uses the Anaconda3 back end with the worksheet.

<img src="{{ '/img/new-auto.png' | prepend: site.baseurl }}" style="width:75%" >

Note that there is no script to convert Sage worksheets back to Jupyter notebooks. I copied code manually into a jupyter notebook to submit homework. I did not mind this final step because of the small number of cells involved (10 or so per assignment) and because it gave me a chance to review code.

### Results

I was able review in-lecture examples and do all homework with Sage worksheets. In one instance, the final assignment for the class, my solution worked on SMC, but the Coursera hosted notebook consistently exhibited a Jupyter kernel crash; the automatic grader accepted the assignment. (And the way the class was graded, it was necessary to get this problem right to pass the course.)

One feature of SMC that can save time and stress is **Time Travel**, which lets you view past versions of a file and restore to a previous version. I don't use it often, but am glad to have it when a particular approach to a problem isn't working out, or a better way of doing things becomes clear.

Study sessions were enjoyable and efficient. I look forward to doing the rest of this MOOC series with SMC.

_Note 1: .py files are also available with the course as an alternative, but I did not use them._

_Note 2: A new session of the first course in the series starts on Dec 19, 2016._
