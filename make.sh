#!/usr/bin/env bash
cd `dirname "$0"`
rm -rf www/
cd src
jekyll build --destination ../www
cd ..

