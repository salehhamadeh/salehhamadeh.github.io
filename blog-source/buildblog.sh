#!/bin/sh
jekyll build
rm -rf ../blog
mv _site/index.html ../blog.html
mv _site/blog ../blog
cp _site/feed.xml ../blog/feed.xml
mv _site/feed.xml ../feed.xml
