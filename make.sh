#!/usr/bin/env bash
cd `dirname "$0"`
cd src
jekyll build --destination ../www
cd ..

