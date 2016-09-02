---
title:  "Tip #1: Restart Project"
date:   2016-09-02 12:59:00
categories: tipps
---

Today's little usage tip is about resource usage and project restarts.
Each time you open up Sage Worksheets or Jupyter Notebooks,
the state of it needs to be stored in memory.
**This can become quite costly if you open many of them after another!**
They also continue to run in the background when you close the tab.

For example, you're grading a lot of homework from your students,
or you're torn apart working with many files at once.

**The solution is to** either explicitly stop each running instance with the stop button (available for both types of documents) after you're finished with it,
or **restart the entire project**.

Restarting the project is like rebooting your computer.
Everything is cleaned up and you end up with a blank state.
Go to the project settings, and then click "restart project" in "project control".

If there were still Jupyter Notebooks open, they might give you little error messages about being cut off abruptly.
Well, don't worry, just close and re-open them.

Pro-tip: In these project settings, on the left hand side,
you can see the current memory usage and the quota.
At the latest when it does grow above the quota,
things might no longer work as well as they should.