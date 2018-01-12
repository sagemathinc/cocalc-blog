---
title: "How do I start a Jupyter kernel in a SageMath Worksheet?"
date:   2016-08-14 19:30:00
categories: [smc]
---

For a quick reminder, sample code is available for opening an Anaconda3 session. In the Sage worksheet toolbar, select **Modes > Jupyter bridge**.

Use the `jupyter` command to launch any installed Jupyter kernel  from a Sage worksheet

{% highlight python %}
py3 = jupyter("python3")
{% endhighlight %}

After that, any cell that begins with `%py3` will send statements to the Python3 kernel that you just started. If you want to draw graphics, there is no need to call `%matplotlib inline`.

{% highlight python %}
%py3
print(42)

import numpy as np; import pylab as plt
x = np.linspace(0, 3*np.pi, 500)
plt.plot(x, np.sin(x**2))
plt.show()
{% endhighlight %}

You can set the default mode to be your Jupyter kernel for all cells in the worksheet: after putting the following in a cell, click the "restart" button, and you have an anaconda worksheet.

{% highlight python %}
%auto
anaconda3 = jupyter('anaconda3')
%default_mode anaconda3
{% endhighlight %}


Each call to jupyter() launches its own Jupyter kernel, so you can have more than one instance of the same kernel type in the same worksheet session.

{% highlight python %}
p1 = jupyter('python3')
p2 = jupyter('python3')
p1('a = 5')
p2('a = 10')
p1('print(a)')   # prints 5
p2('print(a)')   # prints 10
{% endhighlight %}

