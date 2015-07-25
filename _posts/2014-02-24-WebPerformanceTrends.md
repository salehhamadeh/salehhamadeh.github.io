---
layout: post
title:  "Web Performance Trends: One Load, That's All"
date:   2014-02-24 5:15:00
categories: web
---

After all the HTML 5 buzz, I couldn't but notice the new direction in which the web is being taken. At first, the Internet was a collection of pages (most of it still is). However, now we start feeling that some websites are not pages anymore. Take [Trello][trello], a project management web application by Fog Creek Software, for a example. After signing into Trello, all your clicks show instantaneous results, and you feel that the website is really an application more than a website. However, the link in the navbar still shows that you are moving between pages. You know that your internet connection is not that fast, so what exactly is happening? Trello, along with many other [SPA's][spa], utilize HTML5's History API to achieve this. The History API allows web developers to manipulate your browser's history (they cannot view it) by adding new links. In this way, the user thinks that he was directed to a new page when this is not quite the case. Client-side templating engines, like [Mustache][mustache] and [Handlebars][handlebars], can let the browser download the whole website upon the first load. Then, these websites use the History API alongside the client-side templating engines to render instantaneous pages.

Looking at the performace aspect of this technique, we can see that sites are shifting from the traditional load-on-page-request approach to the "One Load, That's All" approach. In this way, the website is going to take a longer time to download, but once it is downloaded, everything else is instantaneous. Using HTML5's LocalStorage API, one can save the website's pages and templates so that the user will not have to download the entire website every time he visits it.

However, the new approach has some limitations. First, they can only work that way on devices that support HTML5. Moreover, they require strong devices to run on, memory-wise and computation-wise.

So, what do you think is the better approach for websites at the moment?


[trello]: https://trello.com/
[spa]: www.wikipedia.org/wiki/Single-page_application
[mustache]: http://mustache.github.io/
[handlebars]: http://handlebarsjs.com/