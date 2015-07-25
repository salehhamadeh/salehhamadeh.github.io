---
layout: post
title:  "Make a Blog Social (Without a Database)"
date:   2013-12-28 17:13:00
categories: web
---

What does it mean by saying that a blog is social? Social, by definition, means humanly-interactive. In other words, it involves different human beings interacting with one another. In this article, I will show you the 3 steps that I took to make my static [Jekyll][jekyll] blog social WITHOUT using A DATABASE.

1. Add the [Addthis][addthis] Smart Layer for sharing articles to social networks.
2. Create a mailing list to keep the blog subscribers notified about the latest news.
3. Add comments to each blog post.

Sharing on Social Networks
--------------------------
The buttons that appear on the left-hand side of this page allow you to share any post on my blog to almost any social network you can think of. Even though this is a powerful feature, it is extremely easy to integrate it into your own website, thanks to [Addthis][addthis]. Go to the [Addthis Smart Layers][addthis-smart-layers] page and customize the toolbar to fit your need. Then, click on Generate Code. This gives you HTML code, which you can paste anywhere inside your page's HTML. That's it! You created your blog's first social interaction service.

Mailing List
------------
You may wonder how to create a mailing list without a database or any server-side scripting. Is it possible? It's not. However, there are Software-as-a-Services out there that do just that. The tool that I used for my own personal blog is [Mail Chimp][mailchimp]. Mailchimp is free, as long as you do not send over 12,000 emails per month or have fewer than 2,000 subscribers. First, go ahead and create an account on Mail Chimp. In the registration's sign up form, there is an Organization's Name field. You do not need to be an organization to use that. The Organization Name is really the name of your website or blog. When you create an account and sign in, you will see the dashboard, which will show you the 3 steps that are needed to get you started. First, click on Create a List and create one. I called my list "Blog Subscribers." After you create your list, click on Lists, click on the list you created, and then click on Signup forms. This will show you a page with 3 different choices: General forms, embedded forms, and form integrations. General forms create complete forms for registration, embedded forms are forms that can be embedded anywhere on your website (just like the one I use on my blog), and form integrations allow you to use Mail Chimp with other web services. You can choose whichever one fits your needs. If you choose embedded forms, you will see a page where you can create your own signup form and design it so it looks good. After going through the form-building process, copy the form's HTML code and paste it wherever you want the form to appear on your website.

Comments
--------
No website is really social without discussions and arguments. Without chicken there is no fried chicken, and without arguments there is no social life. I guess that was a bad comparison, but you get the point: discussion is the key to social interaction.

[Disqus][disqus] is an amazing tool that you find everywhere but may not know its value. That's exactly what happened with me. I remember seeing Disqus on many websites, but I had never tried to create an account to see what motivates all these people to use Disqus. Before 3 days, I decided to go to Disqus.com directly and see what it truly is. It turned out to be comments, profiles, a social media, and anaytics all-in-one. In addition to that, it was as easy as copying-and-pasting to integrate to my website.

Enough talking and let's start getting this done. Head over to [Disqus][disqus] and create an account. After that, click on the link that says, "Add Disqus to your website," at the top-right corner of the screen. Fill out the site's name and category and then click on Finish Registration. Then, you should see a list of platforms that you can use Disqus with. Choose the one that best fits your needs. This should give you step-by-step instructions to add Disqus to your blog. If you click on Universal Code, you will get the HTML for adding Disqus. Copy the HTML and paste it wherever you want to add Disqus in your blog.

TADA!
-----
TADA! You now have a website that has social-media sharing, mailing lists, and discussions. Give yourself a pat on the back and have a look at the great work that you have done.

[jekyll]: http://jekyllrb.com/
[addthis]: http://www.addthis.com/
[addthis-smart-layers]: https://www.addthis.com/get/smart-layers
[mailchimp]: http://mailchimp.com/
[disqus]: http://www.disqus.com/