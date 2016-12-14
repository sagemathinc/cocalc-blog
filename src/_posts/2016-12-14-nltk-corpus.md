---
title:  "NLTK text corpus"
date:   2016-12-14 11:00:00
categories: python
author: haraldschilly
---


The full 2.4gb [NLTK text corpus](http://www.nltk.org/data.html) is now available.
You can for example run this in our SageMath or the Anaconda Python environment:

```
from nltk.corpus import brown
w = brown.words()
len(list(w))
```

which gives

```
1161192
```