---
layout: post
title:  "Moving the Blog to Jekyll"
date:   2013-12-24 13:35:15
categories: blogging
---

After two hours of non-stop coding, I crafted this blog and added it to my website. Of course, this would have not been possible without the contributions of the open-source community, namely [Jekyll][jekyll], [Github Pages][github-pages], and [Scott Chacon][schacon].

For those who have never heard of Jekyll, Jekyll is a tool for creating blogs. I chose Jekyll for the following reasons:

*   It generates static websites.
*   It is fully customizable.

I will clarify what I mean by a static site. Unlike Wordpress and most other blogging tools, Jekyll does not need a database or back-end scripting. When I first read about that, it was impossible to believe. The site was saying that the blog works without data, which is essential for any blog. If this was true, then anyone can use Jekyll to host a blog using any of the free file servers. I can host a blog on Dropbox. I can host a blog using Apache ONLY. It turns out that what Jekyll claimed was true. Instead of being the blog, Jekyll is the blog generator. It takes in markdown files or text files, runs them through several parsers and templates, and creates a complete site with HTML and CSS. Since Jekyll blogs do not need any back-end scripting, it was the perfect tool for hosting a blog on Github Pages.

Since I use many tools to develop my website ([jQuery][jquery], [Twitter Bootstrap][bootstrap], [Font Awesome][font-awesome], ...), I prefer to use tools that do not conflict with the others. I love the tools that give the developers the freedom to use any other libraries and that focus on one thing and do it perfectly. Jekyll met both of my needs. As a website generator, it gives me the blog out of the oven. I did not use any extra link or script tags. Jekyll granted me full customization of the shape of my blog. Using the [Liquid][liquid] template language, I was able to seemlessly integrate the blog posts with my website. Even though the blog and the site are two different projects on my computer, the blog appears to be part of the website when it is hosted online.

Jekyll was not only the best choice for my blog, but was also extremely easy to learn. I encourage anyone who is interested in Jekyll to install it, create an empty blog (it comes with all the necessary files), and skim through the blog's source code. Look at the code, tweak it, and read Jekyll's getting started guide, and you will have your own static and fully-customizable blog in no time.

[jekyll-gh]: https://github.com/mojombo/jekyll
[jekyll]:    http://jekyllrb.com
[github-pages]: http://pages.github.com
[schacon]:   https://github.com/schacon/schacon.github.com
[jquery]:    http://jquery.com
[bootstrap]: http://getbootstrap.com
[font-awesome]: http://fontawesome.io
[liquid]:    http://docs.shopify.com/themes/liquid-basics