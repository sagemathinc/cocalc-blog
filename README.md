# SageMathCloud Blog

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

2. Fix `PATH` in probably `.bashrc`

       export PATH="$HOME/.gem/ruby/2.1.0/bin":"$PATH"

   (check if really ruby 2.1.0 in the path!)

3. Make sure to restart terminal to fix your path

## Categories (in the works)
- News -- New things related to the product or company
- At Work -- Case studies on using SMC for something real

## Analytics for our blog

https://analytics.google.com/analytics/web/#report/content-overview/a34321400w122528512p128198125/ 

## License

CC BY-4.0

## Credits

The theme is based on http://github.com/niklasbuschmann/contrast
