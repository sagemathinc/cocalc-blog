---
author: 'Hal Snyder'
date: 'June 8, 2018'
title: "Dash with CoCalc"
categories: ['cocalc','python']
---

Create interactive data visualizations for collaborators in your CoCalc projects using Dash.

[Dash](https://plot.ly/products/dash/) is an open-source framework to create web applications with Python.
With CoCalc's [HTTPWebserver](https://github.com/sagemathinc/cocalc/wiki/HTTPWebserver) capability, you can run a Dash application from inside a CoCalc project.

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

Start by installing and updating Python3 packages in your project from a .term file:

    pip3 install --user dash
    pip3 install --user dash_core_components
    pip3 install --user dash_html_components
    pip3 install --user --upgrade plotly

Copy the first example python file, "Hello Dash", from the tutorial Python excerpt `app.py` into a .py file in your project. The code is short enough that you can use copy and
paste.

Insert the following three code snippets just above the test for `__name__ == '__main__'`.

Set the HTTP port number for your Dash web app. You can probably use the default port number of 8050, but you will
need to specify the port number in the prefix regardless.
Our example uses 9990.

    port = 9990

Get your project ID from the environment variable `COCALC_PROJECT_ID`. That is the specially-formatted
hex code you see in the browser URL when
logged into your project, and displayed the
Project Settings tab under Project Control.

    import os
    cocalc_project_id = os.environ['COCALC_PROJECT_ID']

Configure `requests_pathname_prefix` as indicated
in the [HTTPWebserver](https://github.com/sagemathinc/cocalc/wiki/HTTPWebserver) wiki page:

    pfx = "/{}/server/{}/".format(cocalc_project_id, port)
    app.config.requests_pathname_prefix = pfx

In the final line, display the URL for your server
and override default port number and
host in the call to `app.run_server()`:

    if __name__ == '__main__':
        print("browse to https://cocalc.com{}".format(pfx))
        app.run_server(debug=True, port=port, host='0.0.0.0')

Back in your .term session, run the program. For example,
if the file you just edited is `app.py`, do this:

    python3 app.py

Copy the URL that is displayed by the program.
It will look like this, but the project id will be different:

    https://cocalc.com/d4cc78a0-6b95-11e8-8f10-3f7d9b915277/server/9990/

Open a new browser tab and paste in the URL. You will see the "Hello Dash" demo.

Note: Because of the way CoCalc security works, only collaborators on the given project can access the webserver. Our proxy server will reject all other requests.

More examples are available in the [Dash User Guide](https://dash.plot.ly/) and [Introducing Dash](https://medium.com/@plotlygraphs/introducing-dash-5ecf7191b503).

