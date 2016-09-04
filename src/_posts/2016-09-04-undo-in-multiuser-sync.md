---
title:  "Multi-user sync-aware full document undo/redo"
date:   2016-09-04 18:23:00
categories: dev
author: williamstein
---

Today -- motivated by a challenge from a [c9.io](http://c9.io) developer at a recent meetup in Seattle -- I finally implemented multi-user sync-aware full
document undo/redo, at least for code editors, sage worksheets, and Jupyter notebooks.   If you've ever edited a file, worksheet, or Jupyter notebook at the same time as somebody else, and you hit control+z (or click undo) right after *they* type something, you would have undid *their* last thing.  That's because the undo/redo would use the underlying Codemirror editor's undo/redo functionality.   I wrote a new implementation of undo/redo built on top of the realtime multiuser sync functionality.  Instead of undoing the last change (or
changes if you undo or redo multiple times) to the document, it undoes *only* the changes that you made during this session.

For Jupyter notebooks in SageMathCloud this has an interesting side
effect.  Vanilla Jupyter itself doesn't have any global undo --
instead they have a local undo in each cell, which you could only use
via the keyboard.   With this change, now Jupyter notebooks in SMC
have a global undo: make some changes in any cell(s), move cells
around, delete cells, etc., then click undo/redo or use the keyboard
to undo/redo, and the undo should undo everything you actually did
across all cells.
