# CoCalc Blog

This is the source code for the https://blog.sagemath.com blog.

## Build

    ./make.sh    # check content of ./www
    ./publish.sh # pushes to GCS

## Live Preview

Run

    ./preview.sh

To run jekyll with the `watch` option and also render future postings.
That's only useful for authoring and the baseurl is hardcoded to a project on SMC.

## Install

0. You need ruby

1. Install jekyll and some extras

       gem install --user-install jekyll jekyll-feed jekyll-pagination bundler

## Categories (in the works)
- News -- New things related to the product or company
- At Work -- Case studies on using SMC for something real

## Including images

Like all the other assets, they need base url prefixing.
The canonical location for images is `src/img`.
Therefore, include them like that:

    <img src="{{ '/img/smc-sagews-cell-toggle-2.png' | prepend: site.baseurl }}">

## Analytics for our blog

**Adjust the dates** here and get page views for each post:

https://analytics.google.com/analytics/web/#report/content-overview/a34321400w122528512p128198125/

## License

CC BY-4.0

## Credits

The theme is based on http://github.com/niklasbuschmann/contrast
