---
layout: post
title:  "Web Security: Unvalidated Redirects"
date:   2014-04-06 10:00:00
categories: web
---

Did you expect to be on Google or some other page but found yourself here? Then, let me tell you that you were a victim to one of the top 10 web security threats: [Unvalidated Redirects][unvalidated-redirects]. Do not worry, you are in safe hands (this blog).

What Happened?
--------------
The link that you clicked is probably a redirection link, such as those found in Google's search results. Companies like Google and Twitter use redirection links to track where their users are going. It helps them gather information and hide information. For example, using redirection URLs, websites can:

*   Track where their userbase is going.
*   Hide referral information (search query strings, etc...) from the websites that the users are redirected to.

Why is this a Threat?
---------------------
Most users who surf the web do not look at their address bar on every page they visit. To most of them, seeing that a link starts with www.google.com is enough to make the link trusted. Now if a malicious user creates a website that clones Google's login page and sends a redirection URL that starts with www.google.com, the victims are only 1 step close to sending out their password.

Other users may use this security weakness to get more traffic. If the "bad" users serve ads, they make more money.

What Defenses can Web Developers Take to Keep their Websites Safe?
------------------------------------------------------------------
The easiest way to keep your sites safe is to stay away from redirection using query string parameters. If this is not something that you can easily do, here are some strategies that you can use:

*   Keep a hash map of URLs. In other words, instead of having the URL in the query string, have a key that refers to that URL there. In this way, only the URLs for the keys that YOU define are redirectable.
*   A better method is to have a domain name dedicated to URL redirections. [Twitter][twitter] uses [t.co][t-co] to track its users' whereabouts while explicitly showing them that they will be redirected. [Yahoo][yahoo] uses r.search.yahoo.com for the same purpose.

What Defenses can Users Take to Stay Safe?
------------------------------------------
Look at the full URL before visiting a link. The first part of it does not tell you everything. For some URLs, this practice can be tedious. In that case, look at the URL every time you are about to submit a form or enter sensitive information.

[unvalidated-redirects]: https://www.owasp.org/index.php/Top_10_2010-A10-Unvalidated_Redirects_and_Forwards
[twitter]: https://twitter.com/
[t-co]: https://support.twitter.com//entries/109623
[yahoo]: https://www.yahoo.com/
