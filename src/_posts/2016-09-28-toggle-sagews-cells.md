---
title:  "Toggle SageWS Cells"
date:   2016-09-08 10:35:00
author: williamstein
---

After getting too tired of people saying things like

> I'm getting crazy with cells becoming hidden in a way I'm not in full control.

I just rewrote how cell input/output hiding works.  Now there is a
little toggle triangle in the very left column next to the input cell
divider, and also next to the output.  That's how you toggle
visibility of input and output.

Also, `%md` and `%html` no longer "magically" hide the input,
and double clicking on the output doesn't do anything anymore.
It's simple, straightforward, and you are in control.

Additionally, a second level of line numbering helps to orient inside a cell and across the whole document.

<img src="{{ '/img/smc-sagews-cell-toggle-2.png' | prepend: site.baseurl }}" style="width:75%" >

