# SageMathCloud Blog

based on http://github.com/niklasbuschmann/contrast

## Build

    ./make.sh    # check content of ./www
    ./publish.sh # pushes to GCS

Note, that one has to fix the baseurl in the _config.yml for local preview here

## License

CC BY-4.0

## Install

1. install jekyll and some extras

       gem install --user-install jekyll jekyll-feed jekyll-pagination bundler

2. Fix `PATH` in probably `.bashrc`

       export PATH="$HOME/.gem/ruby/2.1.0/bin":"$PATH"

   (check if really ruby 2.1.0 in the path!)

3. make sure to restart terminal to fix your path