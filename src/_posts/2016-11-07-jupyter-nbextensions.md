---
title:  "Install Jupyter's nbextensions configurator"
date:   2016-11-07 09:59:00
categories: [jupyter]
author: haraldschilly
---

You can install it in your own project. For that, you need internet access enabled or somehow upload the code into your project. Then, install it like this in a terminal (create a new file `terminal.term`)

     pip install --user --no-deps jupyter_nbextensions_configurator
     jupyter nbextensions_configurator enable --user

and restart the Jupyter server in SMC

    smc-jupyter restart

Then, in order to see the configurator, you have to open an ipynb file. Click on the the "About" button in the top right click on the link there to open the version of jupyter without the synchronization. There, either go to the main page or the one dedicated for the nbextensions. The URL looks like this:

    https://cloud.sagemath.com/<your_project_id>/port/jupyter/nbextensions