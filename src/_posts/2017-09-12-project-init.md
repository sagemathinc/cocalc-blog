---
author: 'Harald Schilly'
date: 'September 12, 2017'
title: 'Project Initialization Scripts'
categories: cocalc
---

Under the hood, CoCalc provides you with a very flexible and versatile Linux environment.
Due to the [upgrade to Kubernetes](https://github.com/sagemathinc/cocalc/wiki/KubernetesMigration),
our (unofficial) support for using crontab files for periodic tasks was removed.
Instead, there is a new and more flexible mechanism to use regular Bash, Python, or SageMath files to accomplish even more.

# Project Initialization

When a CoCalc project starts up,
an instance of [Supervisor](http://supervisord.org/) is started and responsible for running:

* an instance of **"local hub"**. It is used for managing the project, communication with the outside world, monitoring, etc.
* **sshd**: the endpoint for remote SSH access
* **initialization file**: it sit inside your project and is only started if it exists.
  It is located in your home directory and named `project_init.sh`.
  As the name suggests, it is run via the Bash interpreter.

## Initialization file management

Supervisor is configured to run this initialization file like background processes.
This means it checks the exit value of the process and restarts it if this code is not `0` or `2`.
Therefore, a script that runs without an error is **not** restarted.

On the other hand, if the process is terminated, interrupted or crashes – therefore the exit code is e.g. `1` – the process is restarted.
This adds some robustness to long running background jobs.

# Example 1: record start time

A very simple example is to record the project's start time.
Go to your home directory and create a file `project_init.sh` with that content:

{% highlight sh %}
date > project-start
{% endhighlight %}

This is a very simple bash script, which pipes the output of the `date` command into the file `project-start`.

In order to see its effect, the file needs to be saved and the project restarted.
Give it a few seconds to come back online and run the script.
After that (maybe click the refresh button in the file listing) you should see this file and its content might look like:

{% highlight sh %}
Mon Sep 12 11:14:20 UTC 2017
{% endhighlight %}

# Other languages besides Bash?

You can run any language via bash's `exec`!
For example, `project_init.sh` containing

{% highlight sh %}
exec python3 project_init.py
{% endhighlight %}

will run a Python 3 initialization file named `project_init.py`.


# Example 2: a periodic task in Python

Here we write a small Python script,
which runs an infinite loop (*make sure to use `time.sleep`!*) and evaluates a function every 5 minutes.
This examples uses the library [schedule](https://schedule.readthedocs.io/en/stable/).
Feel free to choose any other solution.

1. `project_init.sh`: contains `exec python3 project_init.py`
2. The content of `project_init.py` is:

{% highlight python %}
import schedule
import time
from random import random
from datetime import datetime

i = 0

def task():
    with open('task_output.log', 'a') as fout:
        ts = str(datetime.utcnow())
        fout.write("Task {}: {} value = {}\n".format(i, ts, random()))
        i += 1

schedule.every(5).minutes.do(task)

while True:
    schedule.run_pending()
    time.sleep(1)
{% endhighlight %}

Indeed, after restarting the project the output of `ps auf` shows this "daemon" task as a child of supervisor:

{% highlight sh %}
PID TTY      STAT   TIME COMMAND
  5 ?        Ss     0:01 /usr/bin/python /usr/bin/supervisord -c /cocalc/supervisor/supervisord.conf
 15 ?        Sl     0:01  \_ node /cocalc/src/smc-project/local_hub.js ....
 18 ?        S      0:00  \_ python3 /home/user/project_init.py
...
{% endhighlight %}


and the output file `task_output.log` contains:

{% highlight sh %}
Task 0: 2017-09-12 12:02:22.636091 value = 0.12071154405652385
Task 1: 2017-09-12 12:07:22.761420 value = 0.6513792691945387
Task 2: 2017-09-12 12:12:22.891285 value = 0.5965113338132986
...
{% endhighlight %}

# Example 3: Periodic task in SageMath

`run.sage` is similar to the Python script above.

1. `project_init.sh`: `exec sage run.sage`
2. This results in Sage running a small task every two minutes and appends outputs to `sage_output.log`:

{% highlight python %}
import time
from random import random
from datetime import datetime

i = 0
def task():
    global i
    with open('sage_output.log', 'a') as fout:
        ts = str(datetime.utcnow())
        fout.write("Sage Task {}: {} value = {}\n".format(i, ts, random()))
        i += 1

while True:
    task()
    time.sleep(2 * 60)
{% endhighlight %}

# Debugging

To figure out why a script doesn't work as it should, there are two ways to debug it:

1. Run it directly in a terminal (create a `*.term` file) and run `bash project_init.sh` or `python3 project_init.py`.
2. Check the logfile of Supervisor by running this in a terminal: `cat /tmp/.cocalc/supervisord.log`.
   Among its logging there are likely entries hinting for exit states (e.g. `INFO exited: project_init_sh (exit status 0; expected)`) or they show `stdout`/`stderr` output of the failed commands.
3. A common pitfall is to assume `~/.bashrc` is run.
   Since this is a non-interactive session, you need to explicitly source any additional environment information.