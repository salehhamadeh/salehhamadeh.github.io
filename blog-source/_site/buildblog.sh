#!/bin/sh
jekyll build
rm -rf ../blog
mv _site/index.html ../blog.html
mv _site/blog ../blog
