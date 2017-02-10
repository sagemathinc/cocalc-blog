---
author: 'William Stein (wstein@sagemath.com)'
date: 2017-02-09
title: "RethinkDB versus PostgreSQL: my personal experience"
---

## Introduction

Initially motivated by the [shutdown of the RethinkDB company](https://rethinkdb.com/blog/rethinkdb-shutdown/), and  the [licensing situation with RethinkDB](http://sagemath.blogspot.com/2016/10/rethinkdb-must-relicense-now-what-is.html) (a blocker for certain parts of my business), I worked very hard for two months to completely rewrite the realtime and database components of SageMathCloud (SMC) to use PostgreSQL instead of RethinkDB, initially motivated by [this discussion in Hacker news](https://news.ycombinator.com/item?id=12649712).   I battled with and used RethinkDB heavily since May 2015, and I've used PostgreSQL heavily as well, with production data, rewriting all the same queries in both systems, so I'm in a good position to compare them for my use case (the site SMC).

**This is my story.  It's a personal comparison, with NO BENCHMARKS or hard data you could reproduce.  It's what I would tell you if we were talking by the water cooler.**

Summary:

 - I'm very happy with the rewrite.
 - Everything is an order of magnitude more efficient using PostgreSQL than it was with RethinkDB.
 - It is much easier to do exploratory queries of our data using PostgreSQL than it was with RethinkDB.  PostgreSQL  is much more expressive than ReQL, has a massive number of built-in functions, so we are making [much better use of our data](https://github.com/sagemathinc/smc/blob/master/src/scripts/postgresql/cool-queries.md). With RethinkDB, often we just ended up greping through the latest database dump.
 - PostgreSQL is "statically typed", whereas RethinkDB had no type or schema enforcement at all; explicit clear typing improved the quality and robustness of our application.
 - We are saving \$800 month (!), due to reduced CPU and disk space requirements.
 - I had no clue  that [RethinkDB would be Apache licensed in February 2017](https://news.ycombinator.com/item?id=13579544).


## A Mathematician's Apology

This post is probably going to make some people involved with RethinkDB <a href="https://github.com/rethinkdb/rethinkdb/issues/6137" target="_blank">very angry at me</a>:

> "@williamstein for the best interest of rethinkdb community project, and especially if you respect the community and ex team members trying hard, please do not sway the community like this." and "@williamstein can you delete your previous post..."

Not listening to users is perhaps not the best approach to building quality software.  In [Slava's postmortem](http://www.defstartup.org/2017/01/18/why-rethinkdb-failed.html), he says:

> "People wanted RethinkDB to be fast on workloads they actually tried, rather than “real world” workloads we suggested. For example, they’d write quick scripts to measure how long it takes to insert ten thousand documents without ever reading them back. MongoDB mastered these workloads brilliantly, while we fought the losing battle of educating the market."  - Slava

With SageMath  we have had many very intense technical and other discussions with epic arguments back and forth.  The one thing we don't do is tell people not to even try to criticize our design choices: bring it on.
Obviously, the Linux kernel is similar, and
it is very successful.

I'm writing this blog post partly because I've [said many positive things](https://www.youtube.com/watch?v=WU6eSckPR7E) about RethinkDB.  Really, what I love
is the problems that RethinkDB solved, and where I believed
RethinkDB could be 2-3 years from now if
brilliant engineers like Daniel Mewes
continued to work fulltime on the project.  I don't care so much
that problems are solved using a particular **piece of software**.
For example, every component of SMC has been
rewritten multiple times -- *I've
thrown away tens of thousands of lines of code*.  I care about
solutions, not glorifying a particular piece of code for its own
sake.  Hence this post.

I can only hope that any devs who are
really, really serious about RethinkDB having a future would
listen to users, and hence will appreciate this post.  But I'm also prepared to be hated for not staying silent.

## Realtime web applications

There are many approaches to writing "realtime" web applications,
i.e., event driven applications involving simultaneous multiple
users, with the application updating quickly in response to
what users do.  After learning React.js and rewriting a lot of the frontend of SMC using React, I wanted to use a similar
reactive architecture on the backend, where each component of
the system listens for changes in state (the database), and
reacts to it.  In early 2015, I also wanted something like Facebook's
GraphQL, but there were no available implementation yet.

RethinkDB lets clients listen for changes in state to the database,
and react to them.  It was  advertised as "production
ready" in 2015, so I spent months rewriting SMC so it would use
RethinkDB as the backend database.  Before that, I was using
Cassandra, and only making very simple use of the database, with
all realtime functionality done at the application level in
memory (so not using the database); that architecture worked OK, but there was a huge range of functionality I wanted to implement
which was impossible to do with this approach, without introducing
a message queue.  Also, Cassandra was a bad
fit for my data, and talking with the Datastax
people on the phone
about their pricing really scared me.

I spent the summer of 2015 rebuilding SMC on React + RethinkDB, with the RethinkDB rewrite being many, many months of hard work  and debugging, basically from May 2015 to July 2016.  I hit critical bugs that would crash RethinkDB in some edge case,
which the RethinkDB devs would always fix.  I also encountered a lot
of painful scalability and performance issues, which I fixed by
tedious benchmarking, debugging, studying logs, and introducing client
side workarounds (e.g., idle timeouts on changefeeds).  In July 2016, using RethinkDB become pretty stable.

Jonathan Lee, a computer science student working with me on SMC in Summer 2015, advised me against using RethinkDB due to performance issues.  In particular, he pointed out [this 2015 blog post](https://www.amon.cx/blog/rethinkdb-reviewed-by-a-mongo-fan/), in which RethinkDB is consistently 5x-10x slower than MongoDB.   I ignored Jonathan's advice, because I believed
RethinkDB would catch up within a year or two.  I thought they
would obsess over benchmarks now that they were production ready.
I didn't realize it would take nearly a year for them to fix
the bugs in their automatic failover and stabilize the current
features.  I had a nagging feeling deep down that Jonathan was
right and I was making a big mistake, but I ignored it.

A RethinkDB employee told me he thought I was their biggest user in terms of how hard I was pushing RethinkDB.

Using RethinkDB up until July 2016 was painful.  I remember so many times
doubling and doubling again the cpu's in the RethinDB nodes, in order
to handle the load from (say) 10K changefeeds.   Maybe I just needed
to be "educated" and was using RethinkDB incorrectly. Everything
was a battle; even trying to do **backups** was really painful, and eventually we gave up on making proper full consistent
backups (instead, backing up only the really important
tables via complete JSON dumps).  We also had a lot of issues with disk usage.

Around July 2016, I finally got a setup using RethinkDB to be stable and working.  I finally learned to really
appreciate Docker and Kubernetes,  since they make it very
easy to tweak dials to scale things up and down.
Also Harald Schilly suggested using "RethinkDB proxy nodes",
[inspiring this section of the RethinkDB docs](https://www.rethinkdb.com/docs/sharding-and-replication/#running-a-proxy-node).  These are RethinkDB nodes that don't store any data
on disk, but do the hard work of processing and serving changefeeds:

> "The proxy node can do some query processing itself, reducing CPU load on database servers."

We ended up spinning up a Kubernetes cluster with
**20 rethinkdb proxy/webserver pods**, in addition
to our 6-node RethinkDB cluster, and we could handle our load.
Even then, the proxy nodes would often run at relatively high cpu
usage.  I never understood why.  In fact, they were the only part
of the entire SMC architecture whose high CPU usage I didn't
understand.  By training and profession, I'm a pure mathematics
researchers and lover of open source software, so I'm used to trying
to understand how and why things work the way they do, but I never
understood this.

When the RethinkDB company shut down, I initially decided to just wait
and see what happened, maybe for a year or two, since our site
was working fine with the many nodes mentioned above (I also didn't
realize how much money we were wasting on this setup).
Then I was  in a very long and intense meeting with a
potentially major customer for an on-premises install, and one
of their basic requirements was "no AGPL in the stack".  With
the RethinkDB company gone, there was no way to satisfy that requirement,
and [my requests](http://sagemath.blogspot.com/2016/10/rethinkdb-must-relicense-now-what-is.html) went nowhere at the time.

I had assumed that the speed
would increase substantially due to focused work of Daniel
Mewes during 2017. However, my understanding is that he went
to work fulltime at Stripe, and will not be working on
RethinkDB much.  I also worried that the license situation wouldn't be resolved:
["Worrying about licensing is what PG would call a sitcom idea [1] -- it feels like doing useful work, but in actuality it makes no difference whatsoever."](https://github.com/rethinkdb/rethinkdb/issues/6137), though as we all know now [it was just resolved](https://news.ycombinator.com/item?id=13579544)!

So in early December 2016, I decided enough was enough, and I started
rewriting [our Rethink code](https://github.com/sagemathinc/smc/blob/53ef75a99412573ed40c6fc796276c8ac823c7b4/src/smc-hub/rethink.coffee), which is 5600 lines of CoffeeScript, to instead use PostgreSQL. I spent the
first week making prototypes and benchmarks using the
LISTEN/NOTIFY/TRIGGER functionality of PostgreSQL.
For me, I realized the problem should not be "use some cool tech", but
instead "can I use this tech to solve my customer problems".
Even if LISTEN/NOTIFY/TRIGGER are much lower level, and take
a lot more work and thought than RethinkDB changefeeds, I don't care
if the end result is better.

[> "I wonder what will happen to products like SageMathCloud using RethinkDB now that the company is gone away." -- 	nchelluri on Hacker News.](https://news.ycombinator.com/item?id=12663977)



## PostgreSQL

I learned from [this discussion in Hacker news](https://news.ycombinator.com/item?id=12649712) that PostgreSQL has some basic building blocks for implementing something like RethinkDB
changefeeds.   Searching online for uses of [NOTIFY](https://www.postgresql.org/docs/9.6/static/sql-notify.html)/[LISTEN](https://www.postgresql.org/docs/9.6/static/sql-listen.html) yields
some relatively simple (but clear!) demos, which I was very thankful for. I did lots of benchmarks, and came to the conclusion that
this could work.

I knew **exactly** what I needed to accomplish, since I had it all
running on top of RethinkDB in production.  So no design was really
needed.  The problem was clear.  Do exactly the same thing, but using
PostgreSQL's LISTEN/NOTIFY and triggers instead.

Regarding PostgreSQL, I've used it  off and on since the late 1990s (in fact, PostgreSQL started at Berkeley the same year I started graduate school there!).  There have been steady but major improvements to
PostgreSQL over the years, including very good JSON document support,
replication, and clearly somebody spent work making their LISTEN/NOTIFY
functionality fast.  Thank you, whoever you are.

I didn't seriously consider MySQL since it doesn't have LISTEN/NOTIFY, and is also GPL licensed, whereas PostgreSQL has a very liberal license.

After running tests and studying the API, I estimated I could rewrite SMC on top of PostgreSQL in "one month of focused work".

## Implementation

I made a plan and spent all December rewriting SMC on top of PostgreSQL.   Indeed it took exactly a month of focused work to
do the basic rewrite.

The design I used was to setup a small number of LISTEN/NOTIFY
channels, which would listen for changes on a table, and
send the primary key and optionally other small columns to
each connected webserver.   This meant that the total
number of triggers and LISTEN/NOTIFY channels that the
database manages is quite small -- hundreds at most.
When a webserver client gets a notification, it then decides
whether it is interested in that record, and if so does
a SELECT back to the database for the rest of the data,
which it then sends out to clients.  (The problem of deciding
whether to do the further select currently involves an O(N)
call of a bunch of functions that check equality; it could
be done much more efficiently with a Bloom filter or
hash table.)

In moments of frustration at the CPU usage of RethinkDB, I had
imagined implementing something like the above on top of RethinkDB,
but decided not to, since it is literally doing exactly what
RethinkDB **must** be doing.  When I started vaguely thinking through the
details it seemed hard and complicated, and I was worried that it
would be even less efficient than RethinkDB.  Last August 2016, when
I had dinner with Daniel Mewes, he surprised me by telling me that the RethinkDB
proxy nodes were *all* receiving (and presumably doing something with)
*all* of the data for all updates to all tables that had any changefeeds.
Maybe this was why things were  inefficient...

In any case, I wrote code that  automates creation of all triggers
to do listen/notify.  I went through my
tables, and made sure to implement enough
changefeed-style functionality so that they did everything I need.
Also, since I actually knew what I was building ahead of time (and was scared
of having hard-to-debug problems in production), I wrote
a [large number of unit tests](https://github.com/sagemathinc/smc/tree/master/src/smc-hub/test/postgres).



There was also a complicated "graph style" query of "all collaborators on projects"
that caused a lot of trouble with RethinkDB, often taking 10 seconds for certain users
with lots of projects (e.g., me with over 500 projects).  It's a query that is hard
to express efficiently, involving a join over two tables.  Also, RethinkDB couldn't
do a changefeed on that query, so when the projects that I user collaborated on changed,
I would have to kill the changefeed and recreate it.   When rewriting everything,
I decided to just do things right if possible, and came up with a single data
structure that properly tracked all projects and collaborators of a given user
by just watching the whole accounts and projects tables, and properly updating
some data structures.   The code is in `ProjectAndUserTracker` [here](https://github.com/sagemathinc/smc/blob/master/src/smc-hub/postgres-synctable.coffee), and it works very well in practice.   Obviously, again, this same code could have been
written on top of RethinkDB, and it would have helped a lot.

In any case, to build my application on PostgreSQL, many new small problems absolutely
had to be solved, many taking a day of concentration.   Rewriting all the code
from scratch did clean it up a lot.

Also, I hope to build multimaster async replication  on the above
changefeed functionality. This will be important when SMC is geographically distributed.
I also have plans to do a partial-multi-master async between the main public SMC and individual docker images that users run offline, which provide a genuine full offline mode, and also provide simultaneous editing of files (with multiple cursors etc.), but
with all compute happening on the user's local machine in a docker container, which
has its own small local PostgreSQL instance.  But that's for 2018...

## Migration

Next, in early January, I started the process of writing code to migrate
all the data from RethinkDB to PostgreSQL, with minimal downtime (so one big migration, then incremental updates).  I thought this would take a few
hours, but it ended up **taking nearly a month!**  I have a lot of data -- one
table had 150 million records in it...   Another obstruction is that PostgreSQL
is statically typed, whereas RethinkDB is very much not... and this exposed tons
of subtle issues in my data.  In addition, with PostgreSQL it was obvious and
trivial to impose conditions on my data, e.g., all email addresses in the accounts
table are unique, so of course I imposed constraints! -- due to race conditions there were multiple accounts with
the same email address in my RethinkDB data, so I had to write some (scary) code to
deal with that. I also had to deal with things like null bytes in JSON strings, and
timestamps in nested JSON data structures,
and many other issues.
I used a combination of relational columns and JSONB in some cases, which I'll
revisit later.

I did miss [one critical subtle bug](https://github.com/brianc/node-postgres/issues/1200) regarding timestamp precision in the PostgreSQL Node.js driver, which would cost
me days of painful work to debug.


## Comparing speed

As I migrated my data from PostgreSQL, I found myself in a unique position.  I had
years of production real-world data in both RethinkDB and PostgreSQL.   By this point,
I knew both query languages pretty well.   I did a lot of random queries of my data,
sitting in both DB's, and looked at the resulting times.  PostgreSQL was faster,
usually 5x faster, sometimes only 2x faster, and often even 10x faster.   Definitely, the
act of *writing* queries in SQL was much faster  for me than writing ReQL,
despite me having used ReQL seriusly for over a year.   There's something really
natural and powerful about SQL.  And, holy crap, PostgreSQL has a lot of
built in functions that you can use in your queries... and you can add more via
Python and many other languages (I haven't done this yet, but I have dreams of
hooking Sage into PostgreSQL).

I am not providing my data or one single proof of my claims about speed.
Again, this is watercooler talk.  I have a couple hours to share my experiences
with the world, and then I have to get back to work.

Backups, which involve dumping full tables from the database, were
an order of magnitude faster with PostgreSQL.

The total disk space usage was an **order of magnitude less** (800GB versus 80GB) -- some of our tables had a lot of TEXT fields, and PostgreSQL automatically compresses those, which was a huge win.  Also -- to be fair, we had no redundancy with PostgreSQL, whereas 3x redundancy with RethinkDB.  SSD disk space on GCE is expensive, so the reduction in disk usage is saving us a lot of money.

I (and the other SMC devs) run a lot of single-user RethinkDB databases for development
purposes.   PostgreSQL tends to use (at least) an order of magnitude less RAM to do the same thing.

In math software like Sage, I have seen these "order of magnitude differences in speed" with many implementations of algorithms over the years.  Often the first Python
implementation of an algorithm is nice and illustrative and works; then you re-implement
it in Cython, change algorithms, etc., and end up with something that is 100x faster.
This is just the normal experience I've had with math software.  I imagine databases
are similar.  Using 10x more disk space means 10x more reading and writing to disk, and
disk is (way more than) 10x slower than RAM...


## Connection pooling


I spent a huge amount of time worry about connection pooling with RethinkDB to get
better concurrency,  finally just writing my own.  With PostgreSQL I don't even bother,
and instead each web server just has exactly one connection to PostgreSQL, and that
is of course served by exactly one single-threaded process in the PostgreSQL server.
The **root problem** is "make results fast for users", not "have a lot of concurrent
connections".  By optimizing everything, the load on the database and the web servers
is now overall very low, and can easily be handled over a single connection.   There
simply is no need for a connection pool for my application, since PostgreSQL is so fast.
It's also actually really nice that one client web server **can't** slow down the
whole database.

## Going live: things started to fail spectacularly

After all the awesome microbenchmarking above, I expected that when we went live
it would be way more efficient than RethinkDB.  On a nervous quiet Saturday morning,
we switch the live production site over, and everything looked reasonably good
for a while.

**Then things started to fail spectacularly.**

Every connection to the database was pegged at 100% cpu doing SELECT queries.
I didn't know what to do.  It made no sense.  I made the database server faster and
spun up way more web servers, which basically worked... but seemed weird.
I panicked for a while, mulled over the problem, and kept raising the number of
web servers, etc.  This sucked.   I thought for a while the only solution would
be to greatly reduce the number of SELECT's in the changefeeds.  Recall that
changefeeds work by doing a SELECT to get more data when necessary.

After convincing myself not to give up and shut down SMC for good, I calmed down
and studied a lot of logs and found a PostgreSQL query that was taking 15s sometimes
and locking the other queries.  It was a query involving a subquery; it
finds all collaborators
of a user - it's exactly the one mentioned above
that I couldn't make a changefeed on with RethinkDB.
I then tried an instance of this query directly in psql, and
it took only a few milliseconds.  Weird.  OK, I tried it with some other
parameters, and it suddenly took **15 seconds at 100% CPU**, with PostgreSQL doing some linear
scan through data. Using EXPLAIN I found that with full production data
the query planner was doing something idiotic in some cases.  I learned how
to impact the query planner, and then this query went back to taking only
a few milliseconds for any input.
With this one change to influence the query planner (to actually always
use an index I had properly made), things became dramatically faster.
Basically the load on the database server went from 100% to well under 5%.

## The Node.js PostgreSQL driver

The Node.js PostgreSQL driver claims the native bindings provide a
["20-30% increase in parsing speed"](https://github.com/brianc/node-postgres#native-bindings).  For my workload, especially reading BYTEA data (blobs),
the [speed increase is 600%](https://github.com/brianc/node-postgres/issues/1203).
This was another observation I made by looking at log files.

With all these optimizations, the load on the web servers and database, even
when we have 600+ simultaneous users, is barely anything!


## Open source

All the code I wrote related to this blog post is -- ironically -- AGPL.
Basically it is everything that starts with `postgres-` [here](https://github.com/sagemathinc/smc/tree/master/src/smc-hub).

SageMath, Inc. owns all the copyright, so we could license under something else if somebody
is serious about wanting to create a nodejs project on top of PostgreSQL to provide
changefeeds.  I'm too busy with my company to do that, but I would be
supportive.

## Conclusion

I have often said that *"RethinkDB is the first database I ever loved"*.  In fact, it's the reactive approach to databases based on changefeeds that I love (just like I love using React.js).
I still very much love trying
to solve this problem.   If I were in charge of the RethinkDB project, I would delete
much of the code and instead focus on the problem -- changefeeds, and build solutions
on top of PostgreSQL (and maybe other databases).   I'm very thankful for the
RethinkDB project for giving me
the opportunity to spend time **using** this approach to DB's,
so I know how it feels.

Regarding automatic failover and multiple nodes, what really matters is that the site works for users.   Google Compute Engine is so reliable that a single VM tends to stay up for hundreds of days (!), or if it goes down, it comes back very quickly.  PostgreSQL also now
has a very good Master/Slave story.  It's much more likely that of 6 nodes, something will go wrong with one of them, and though RethinkDB automatically fails over, it can take a while and leave clients in bad shape.  Also, at our
current rate of growth, and with current load,
it'll be a long time until one VM isn't sufficient to serve everything; our workload is 90% read and 10% write, so PostgreSQL Master/slave would also very effective for us
for scaling out.

In conclusion, I hope that this post tells you as much about SMC as it does about databases. Other take-aways:
- focus more on the real problem.
- prepare to throw lots of code away; writing the first version(s) is not wasted effort, it brings essential insight
- once you know what the code will do, it's a lot easier to write it in a way that supports testing and refactoring
- open source is critical for solving deep problems
- don't be afraid to try alternative architecture

---

[Discuss Hacker News](https://news.ycombinator.com/item?id=13610146)