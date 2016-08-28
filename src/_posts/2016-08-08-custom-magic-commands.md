---
title: 'Creating Custom "Mode Commands" in Sage Worksheets'
date:   2016-08-08 9:30:00
categories: smc
---

## What is a Mode Command?

By default, running a cell in a Sage worksheet causes the input to be run as Sage commands, with output from Sage written to the output of the cell. Mode commands in a Sage worksheet cause the input to be run through some other process to create cell output. For example, 

* Typing `%md` at the start of a cell causes cell input to be rendered as markdown in the cell output.
* Typing `%r` causes cell input to be treated as statements in the R language, with corresponding output.
* Typing `%HTML` causes cell input to be treated as HTML, rendered as the output.

There are many built-in modes (e.g. Cython, GAP, Pari, R, Python, Markdown, HTML, etc...)

**Note:** If it is not the default mode of your `*.sagews` worksheet, a mode command must be the first line of a cell. In other words, make sure the command `%md`, `%r`, or `%HTML` is the first line of a cell.

Alternatively, you can make any mode the default for all cells in the worksheet using `%default_mode <some_mode>`. Then all cells will be using that chosen mode. If you choose this approach, you may still explicitly use `%sage` for cells you want processed by the Sage interpreter (or `%foo` to explicitly switch to any non-default mode).

There is [an entire section](sagews.md#mode-help) of the FAQ page [SageMathCloud Worksheet (and User Interface) Help](sagews) dedicated to questions about the built-in modes. It had 10 questions-and-answers in it as of July 28, 2016.

## Is there a list of all currently supported % modes in SageMathCloud?

You can view available built-in modes by selecting _Help > Mode commands_ in the Sage toolbar while cursor is in a sage cell. That will
insert the line `print('\n'.join(modes()))` into the current cell.

## What is a Custom Mode Command?

Custom mode commands are modes defined by the user. Like any mode
command, a custom mode command processes the input section of a cell and writes the output. As stated in the help for _modes_,

> Create your own mode command by defining a function that takes a string as input and outputs a string. *(Yes, it is that simple.)*

## Examples of Custom Mode Commands

Custom mode commands can be used to
- render or compile cell input into cell output
- send commands to other processes and show the results

Here are some examples:

#### Example 1: View CSV data as a table

Define the mode in a sage cell, as follows:

{% highlight python %}
import pandas as pd
from StringIO import StringIO
def csv_table(str):
    print(pd.read_csv(StringIO((str)),index_col = 0))
{% endhighlight %}

Input:

{% highlight csv %}
%csv_table
Sample,start,middle,end
A,2,5,51
B,6,8,11
C,7,22,41
{% endhighlight %}

Output:

{% highlight csv %}
        start  middle  end
Sample
A           2       5   51
B           6       8   11
C           7      22   41
{% endhighlight %}

---

NOTE: Sage's `show` command is also aware of Pandas tables,
so if you instead define

{% highlight python %}
def csv_table(str):
    show(pd.read_csv(StringIO((str)),index_col = 0))
{% endhighlight %}

then `%csv_table` will produce nice HTML output.


#### Example 2: View JSON converted to YAML

Define the mode:

{% highlight python %}
import json
import yaml
def j2y(str):
    print(yaml.safe_dump(json.loads(str)))
{% endhighlight %}

Input:

{% highlight python %}
%j2y
{
  "foo": "bar",
  "baz": [
    "xyzzy",
    "plugh"
  ]
}
{% endhighlight %}

Output:

{% highlight python %}
baz: [xyzzy, plugh]
foo: bar
{% endhighlight %}

#### Example 3: Convert Units of Measure

In this example, each input line is a
number with units, possibly followed by target units.
If target units are not specified, SI units are the target.
This example uses the Sage [Units of Measurement](http://doc.sagemath.org/html/en/reference/calculus/sage/symbolic/units.html) package.

Define the mode:

{% highlight python %}
def convert_units(str):
    for line in str.split('\n'):
        if 'units' in line:
            lval = eval(line)
            if isinstance(lval, tuple):
                print(lval[0].convert(lval[1]))
            else:
                print(lval.convert())
{% endhighlight %}

Input:

{% highlight python %}
%convert_units

# pounds to kilograms
175.0 * units.mass.pound

# miles to kilometers
3.0 * units.length.mile, units.length.kilometer

# an adult doing moderate exercise might burn 200 kcal per hour
# convert to watts
200.0 * units.energy.calorie * units.si_prefixes.kilo/units.time.hour, units.power.watt
{% endhighlight %}

Output:

{% highlight python %}
79.37866475*kilogram
4.828032*kilometer
232.6*watt
{% endhighlight %}

#### Example 4: Display Reverse Complement of Nucleotide Sequences

This example uses [Biopython](http://biopython.org/wiki/Documentation), which is already installed on SageMathCloud.

Define the mode:

{% highlight python %}
from Bio.Seq import Seq
def revcomp(str):
    s = Seq(str)
    print(s.reverse_complement())
{% endhighlight %}

Input:

{% highlight python %}
%revcomp
ATGC
GCTCCGACACTTT
{% endhighlight %}

Output:

{% highlight python %}
AAAGTGTCGGAGC
GCAT
{% endhighlight %}

#### Example 5: Run Multiple Shell Processes

Suppose you want several bash processes with different working directories or environment variables controlled from the same worksheet. You can use the built-in `jupyter` command to create several custom modes.

More information on "the sage-jupyter bridge" is available at [Sage Jupyter](sagejupyter). Code creating a mode for _anaconda3_ is available by selecting _Modes > Jupyter bridge_. You can view available Jupyter kernels by selecting _Help > Jupyter kernels_ in the Sage toolbar while cursor is in a sage cell. That will
insert the line `print(jupyter.available_kernels())` into the current cell.

Define the modes:

{% highlight python %}
sh1 = jupyter("bash")
sh2 = jupyter("bash")
{% endhighlight %}

Cell 1:

{% highlight python %}
%sh1
# show PID of current sh process
echo $BASHPID
-- output --
23723
{% endhighlight %}

Cell 2:

{% highlight python %}
%sh2
echo $BASHPID
-- output --
23727
{% endhighlight %}

Cell 3:

{% highlight python %}
%sh1
echo $BASHPID
-- output --
23723
{% endhighlight %}

#### Example 6: Connect to Remote Server and Run Shell Commands

In this example, any cell in the custom mode consists of shell
commands to be run on a remote server. The same session is used
for all cells in the given mode.

Notes:
- The SageMathCloud project must have Internet access. This is an upgrade, only available to users with a paid subscription. (See also "[Why Should I Purchase a Subscription?"](Why-should-I-purchase-a-subscription?).)
- Configure ssh public and private keys with empty passphrase.
- Set _host_ and _user_ for the remote connection.
- You may want to set _IdentityFile_ in your ~/.ssh/config file.

Define the mode:

{% highlight python %}
%sage
from pexpect import pxssh

from ansi2html import Ansi2HTMLConverter
conv = Ansi2HTMLConverter(inline=True, linkify=True)

s = pxssh.pxssh(echo = False)
host   = 'myhost.mydomain.org'
user   = 'joe'

if s.login(host, user):
    def sshexec(code):
        for line in code.split('\n'):
            s.sendline(line)
            s.prompt()
            h = s.before
            h = conv.convert(h, full = False)
            h = '<pre style="font-family:monospace;">'+h+'\n</pre>'
            salvus.html(h)
    print 'sshexec defined; logout with s.logout()'
else:
    print 'sshexec setup failed'
{% endhighlight %}

Input:

{% highlight python %}
%sshexec
ls
cd /tmp
{% endhighlight %}

Output:

{% highlight python %}
... ls listing, showing color-ls output if available ...
{% endhighlight %}

Input in second cell, showing that working directory is retained

{% highlight python %}
%sshexec
pwd
{% endhighlight %}

#### <a name="fricas-example"/> Example 7: Nicely typesetting output from the FriCAS computer algebra system

The following function takes whatever the cell input is, executes the code in `FriCAS`, performs some simple substitutions on the `FriCAS` output and then displays it using `Markdown`:

Define the mode:

{% highlight python %}
%sage
def fricas_tex(s):
    import re
    t = fricas.eval(s)
    t=re.compile(r'\r').sub('',t)
    # mathml overbar
    t=re.compile(r'&#x000AF;').sub('&#x203E;',t,count=0)
    # cleanup FriCAS LaTeX
    t=re.compile(r'\\leqno\(.*\)\n').sub('',t)
    t=re.compile(r'\\sb ').sub('_',t,count=0)
    t=re.compile(r'\\sp ').sub('^',t,count=0)
    md(t, hide=False)
{% endhighlight %}

With this mode, `FriCAS` can generate output that is (almost) compatible with `Markdown` format.

For example you can use this new mode in a cell with the following input:
{% highlight python %}
%fricas_tex
)set output algebra off
)set output mathml on
)set output tex on
sqrt(2)/2+1
{% endhighlight %}

Output: This will evaluate 'sqrt(2)/2+1' and display the result in both LaTeX format and MathML formats (in a MathML capable browser).

**Note:** The current version of Sage (6.6 and earlier) requires a [patch](https://github.com/billpage/sage/commit/237df92ef4e6b5117654f3a3ff71b4aa10b0aa36#diff-60c84efff9cc620d4d8bbd8110321ffd) to correct a bug in the fricas/axiom interface.
