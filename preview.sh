#!/usr/bin/env bash
cd `dirname "$0"`
rm -rf www/
cd src

BASE="/369491f1-9b8a-431c-8cd0-150dd15f7b11/raw/blog.sagemath/www/"

# derived config file, which changes the baseurl
cp _config _config_preview.yml
sed -i "s|baseurl: \"\"|baseurl: \"$BASE\"|" _config_preview.yml

echo; echo; echo; echo
echo ">>>>>>>>>>>> open browser in https://cocalc.com$BASE <<<<<<<<<<<<<"
echo "             edits will compile when source files change, and 'future' posts will be shown, too!"
echo; echo; echo; echo

jekyll build --future --watch --destination ../www --config _config_preview.yml

cd ..

