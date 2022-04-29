---
author: 'Hal Snyder'
date: 'September 8, 2017'
title: 'Using SSH with CoCalc'
categories: cocalc
---

CoCalc support for SSH is significantly improved with
the [CoCalc upgrade to Kubernetes](https://github.com/sagemathinc/cocalc/wiki/KubernetesMigration).
This article reviews new features and
gives examples using SSH with CoCalc.

# New SSH Features

TL;DR: SSH to CoCalc projects has been completely rewritten.  For example, you can now paste a single ssh key in account settings, and it will automatically be available in all of your projects!

## User Interface for Managing Public Keys

User interfaces are now available for managing your SSH keys.
Using these forms, you can add and remove keys, as well as viewing
which keys are configured and when they have
been used last.
There are separate UI dialogues for keys configured
at account and project scope, as described below.

To connect from a remote computer to the SSH server on a project, you must have owner or collaborator status
on that project.  It is NOT required that the project
have network access enabled; network access is only
required if you want to ssh *from* a project to somewhere else.

*NOTE: Manual editing of the authorized\_keys file is
no longer supported. Use the procedures below to
add public keys.*

### Configure a single key for all projects for a given account

It is now possible to set a public key for your CoCalc account that works
with all projects where your account is owner or collaborator.
Click on your account name or the gear icon next to it, and choose the
`SSH Keys` tab.
There is a form at right for entering keys, as shown here:
<div style="text-align: center;">
<img src="{{ '/img/cc-ssh/beforeaddacctkey.png' | prepend: site.baseurl }}" >
</div>

To add a key, enter a descriptive title and paste the .pub
file for the public key file into the form and click `Add SSH Key`.
Extraneous spaces and newlines in the key
that is pasted in will be automatically removed.

The title, MD5 fingerprint, and last-used timestamp will be displayed for each key that is added, as shown here:

<div style="text-align: center;">
<img src="{{ '/img/cc-ssh/acctkey1min.png' | prepend: site.baseurl }}" >
</div>

Multiple keys can be added in this way.

If you want to remove an account key, return to the SSH Keys tab and click the Delete button
to the right of the key you want to delete.

To use an account key, you will need the ssh user and hostname
for a project you want to access.
Open project settings (wrench icon) and look in the
`SSH Keys` section at lower left for the information
under 'Use the following username@host:'.
You will see that the username is the same as
the destination project id _without hyphens_,
and the host is **always** <span style="not-active">ssh.cocalc.com</span>.
(This is a major improvement over before when the host
depended on the project.)

<div style="text-align: center;">
<img src="{{ '/img/cc-ssh/usernameathost.png' | prepend: site.baseurl }}" >
</div>

See below for detailed examples of using SSH keys.

### Configure a public key for a single project

There is also a form to add and remove keys for
a single project.
To add a key for use with a single project, open project
Settings (wrench icon) and scroll down to the
`SSH Keys` section at lower left.
Click 'Add an SSH Key' to open the dialogue shown
below.

<div style="text-align: center;">
<img src="{{ '/img/cc-ssh/addingprojkey.png' | prepend: site.baseurl }}" >
</div>

## SSH agent forwarding

If you're familiar with ssh-agent forwarding, this feature
is now supported by CoCalc.
You will need to have ssh-agent configured on your local
system and have public keys distributed to
all target hosts for agent forwarding to work.

See [Steve Friedl's Tech Tips guide](https://developer.github.com/v3/guides/using-ssh-agent-forwarding/) for more info about SSH agent forwarding.

## SSH access between CoCalc projects

When the client and server for an SSH connection are both
CoCalc projects, you can use a hostname of `ssh` rather than
<span style="not-active">ssh.cocalc.com</span>.
Using the shorter hostname gives a much faster connection,
because it is optimized within the CoCalc cloud.


# Examples using SSH with CoCalc

## Remote login

Suppose you have a private key in the default location (file `~/.ssh/id_ed25519` on Linux or macOS) and your project id without the hyphens is `829e7b5693d611e7ae8ee70cea5e8cd7`.
Then you would login from your terminal with

    ssh 829e7b5693d611e7ae8ee70cea5e8cd7@ssh.cocalc.com

If you are comfortable with a unix-style command line
terminal on your computer, logging in with SSH lets
you manipulate files and processes in your CoCalc projects
from such a terminal.
For example, you might prefer your local terminal
because of the way scrolling or copy and
paste work with it.


## Remote login with ssh-agent and client host configuration

We recommend setting a non-trivial passphrase
when creating SSH keys for CoCalc.
You can then use ssh-agent on your local computer
so that you only need to enter your passphrase
once in a login session.

In addition, keeping user and host configuration
in a config file can simplify logins if you are using
several projects.
Suppose you have

- project P1 with id `c0890246-93dc-11e7-8738-6acae7a6ca2d`,
- project P2 with id `c218c8da-93dc-11e7-8062-6acae7a6ca2d`, and
- public key for your CoCalc account at ~/.ssh/ccdev_ed25529.pub on your home computer.

You can then configure the following in
~/.ssh/config on your computer:
<pre>
    Host P1
        IdentitiesOnly yes
        AddKeysToAgent yes
        Hostname ssh.cocalc.com
        User c089024693dc11e787386acae7a6ca2d
        IdentityFile ~/.ssh/ccdev_ed25529

    Host P2
        IdentitiesOnly yes
        AddKeysToAgent yes
        Hostname ssh.cocalc.com
        User c218c8da93dc11e780626acae7a6ca2d
        IdentityFile ~/.ssh/ccdev_ed25529
</pre>

Users of macOS may want to add [UseKeychain yes](https://developer.apple.com/library/content/technotes/tn2449/_index.html) to each host specification.

With the setup above, you can log into your projects with
`ssh P1` or `ssh P2`. In addition, you can log into
P2 from your SSH session on P1 with the following. Note
the short version of the destination hostname, which
gives much faster logins and file transfers between projects.

    ssh c218c8da93dc11e780626acae7a6ca2d@ssh

## Remote copy

Using the command-line terminal on your computer,
you can copy between your computer and CoCalc
projects. For example, if project P1 is configured
as above, you could do


    scp hello.txt P1:Docs/

to copy hello.txt from the current directory
on your computer to folder `Docs` in P1.

## Copy between projects

Again with P1 configured as above and ssh agent enabled,
suppose you have the following on P1 and want to copy
the Docs folder to P2:

    Docs/
      mydoc.tex
      images/
        plot1.png
        plot2.png

Then from your home computer, you could log into P1 and
do the following:


    # ssh session on P1
    ~$ scp -r Docs c218c8da93dc11e780626acae7a6ca2d@ssh:


## Hosting a git repository on CoCalc

With SSH, you can do remote development with CoCalc as the host
for your remote git repository.
You then have the full range of CoCalc tools available
whenever you're logged into the project.

Suppose you have project P1 configured in `~/.ssh/config` as
above, and you have a repository in your home directory
of that project with one file:

    sample_repo
      hello.txt

Then on your local computer, you can do

    git clone P1:sample_repo
    cd sample_repo
    git checkout -b testbranch
    ... edit hello.txt, git add, git commit ...
    git push origin testbranch

## Use ssh-aware tools for editing & developing software

Many programming editors and IDEs allow you to manipulate
files over SSH. Here's an example with `vim`.

With project `P1` configured as above, suppose you have
file `sample.py` in the home directory. You can edit this
file on your local computer with the command

    vim scp://P1/sample.py

## Mount any folder in a project remotely via sshfs

If you have the utility `sshfs` installed on your local computer,
you can make any folder in a CoCalc project appear as a folder
on your computer. This approach lets you use all the file
manipulation tools of your local computer on the contents
of the attached CoCalc folder as long as you are connected
to CoCalc.

Suppose project `P1` is configured as above and you have
folder `Docs` in the home directory of that project. Then
you can do the following on your local computer and the
project folder will be available locally in `~/P1Docs`:

    sshfs P1:Docs ~/P1Docs
    cd ~/P1Docs
    .. work with files ...
    cd
    umount P1Docs

If you have the Files view of project `P1` open to `Docs` while you
are working with `sshfs`, you may need to click the refresh
icon at right to see changes to contents of the folder.


## Unsupported SSH features

The following SSH features are not available in CoCalc at this time

- X11 Forwarding
- SSH tunneling


# Conclusion

Enhanced SSH support in the latest release of CoCalc
brings simplified public key management and
more ways to combine CoCalc computing power with resources on users' local systems.

There is a brief section on using SSH with CoCalc at our wiki page, [AllAboutProjects](https://github.com/sagemathinc/cocalc/wiki/AllAboutProjects#ssh-connect).



