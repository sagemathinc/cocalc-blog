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

0. you need ruby

1. install jekyll and some extras

       gem install --user-install jekyll jekyll-feed jekyll-pagination bundler

2. Fix `PATH` in probably `.bashrc`

       export PATH="$HOME/.gem/ruby/2.1.0/bin":"$PATH"

   (check if really ruby 2.1.0 in the path!)

3. make sure to restart terminal to fix your path

## License

CC BY-4.0

## Credits

The theme is based on http://github.com/niklasbuschmann/contrast
