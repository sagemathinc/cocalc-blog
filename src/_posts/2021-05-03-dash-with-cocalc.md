---
author: 'Hal Snyder'
date: 'May 3, 2021'
title: "Dash with CoCalc (2021 version)"
categories: ['cocalc','python']
---

Create interactive data visualizations for collaborators in your CoCalc projects using [Dash](https://plot.ly/products/dash/).

Dash is an open-source framework to create web applications with Python.
With CoCalc's [Run A Webserver](https://doc.cocalc.com/howto/webserver.html) capability, you can run a Dash application from inside a CoCalc project.

<div style="text-align: center;">
<img
    src="{{ '/img/dash/dash-demo.png' | prepend: site.baseurl }}"
    style="width:80%" >
<br>
<em>Dash application running in a CoCalc project</em>
</div>


We'll step through a working program based on the first example in the [Dash Tutorial](https://dash.plot.ly/getting-started),
with a few additions for configuring the HTTP server.
Code for the [completed CoCalc example](https://cocalc.com/share/db982efa-e439-4e2d-933b-7c7011c6b21a/DASH/dash-demo.py?viewer=share) is viewable on the share server.

The following packages used by the demo program are already installed in the CoCalc Python 3 environment:

* dash
* dash_core_components
* dash_html_components
* plotly

The sample program at the [Dash Tutorial](https://dash.plot.ly/getting-started) is short enough that you can copy it into your clipboard and paste into a file in a project of your own. In the following, we assume your file is called `app.py`.

Comment out or delete the call to the constructor that begins `app = dash.Dash...` In its place insert the following three code snippets:

1. Set the HTTP port number for your Dash web app. You can probably use the default port number of 8050, but you will need to specify the port number in the prefix regardless. Our example uses 9990.

       port = 9990

2. Get your project ID from the environment variable `COCALC_PROJECT_ID`. That is the specially-formatted hex code you see in the browser URL when logged into your project, and displayed the Project Settings tab under Project Control.

       import os
       cocalc_project_id = os.environ['COCALC_PROJECT_ID']

3. Configure `requests_pathname_prefix` as indicated in the CoCalc online guide's [Run A Webserver](https://doc.cocalc.com/howto/webserver.html) page and set requests_pathname_prefix in the Dash constructor: 

       pfx = "/{}/server/{}/".format(cocalc_project_id, port)
       app = dash.Dash(requests_pathname_prefix = pfx)
       app.config.requests_pathname_prefix = pfx

In the final line, display the URL for your server
and override default port number and
host in the call to `app.run_server()`:

    if __name__ == '__main__':
        print("browse to https://cocalc.com{}".format(pfx))
        app.run_server(debug=True, port=port, host='0.0.0.0')

You will start the program from a Linux terminal session. You could [open a separate .term file](https://doc.cocalc.com/terminal.html). Or you can split your editor window and open one of the frames into a terminal. See the online guide about the [Frame Editor](https://doc.cocalc.com/frame-editor.html) for more information.

If the file you just edited is `app.py`, do this in your terminal:

    python app.py

Copy the URL that is displayed by the program.
Open a new browser tab and paste in the URL. You will see the "Hello Dash" demo.

Note: Because of the way CoCalc security works, only collaborators on the given project can access the web server. Our proxy server will reject all other requests.

More examples are available in the [Dash User Guide](https://dash.plot.ly/) and [Introducing Dash](https://medium.com/@plotlygraphs/introducing-dash-5ecf7191b503).

