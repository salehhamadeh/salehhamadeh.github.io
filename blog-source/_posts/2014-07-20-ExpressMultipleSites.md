---
layout: post
title:  "How to host multiple websites using Express.js"
date:   2014-07-20 10:15:00
categories: [web, nodejs, express]
---

Hosting multiple websites using NodeJS and Express is made very simple using Express's [virtual hosts][vhost]. Using virtual hosts, you do not need to worry about using a reverse proxy to forward your visitors to different ports. Simply, a virtual host is an Express app tied to a domain name. What does that mean in code? Let's see!

Our Workspace
-------------
For demonstration, let us assume that we own two domain names: potato.com and tomato.com. We want www.potato.com to direct to the potato website, which is located in a directory named potato, and we want www.tomato.com to direct to the tomato website, which is located in a directory named tomato. For simplicity's sake, both websites are static websites.

Creating a Virtual Host
-----------------------
As I mentioned earlier, a virtual host is an Express app. This is not entirely true. A virtual host wraps up an application into a middleware. After it is wrapped up, we can use it in our main application. The code below shows how to create a virtual host (or vhost).

{% highlight js %}

function createVirtualHost(domainName, dirPath) {
    var vhost = express();
    //parses request body and populates request.body
    vhost.use( express.bodyParser() );
    //checks request.body for HTTP method overrides
    vhost.use( express.methodOverride() );
    //Where to serve static content
    vhost.use( express.static( dirPath ) );
    //Show errors
    vhost.use( express.errorHandler({ dumpExceptions: true, showStack: true }));

    return express.vhost(domainName, vhost)
}

{% endhighlight %}

For our potato and tomato app, we will need to create two virtual hosts as follows:

{% highlight js %}

var potatoHost = createVirtualHost("www.potato.com", "potato");
var tomatoHost = createVirtualHost("www.tomato.com", "tomato");

{% endhighlight %}

Using the Virtual Hosts
-----------------------
Using the virtual hosts is as simple as using any piece of middleware. All we have to do is pass them to app.use:

{% highlight js %}

var app = express();
app.use(potatoHost);
app.use(tomatoHost);

{% endhighlight %}

The Full Server Code
--------------------
{% highlight js %}

// Module dependencies.
var application_root = __dirname,
    express = require( 'express' );

function createVirtualHost(domainName, dirPath) {
    var vhost = express();
    //parses request body and populates request.body
    vhost.use( express.bodyParser() );
    //checks request.body for HTTP method overrides
    vhost.use( express.methodOverride() );
    //Where to serve static content
    vhost.use( express.static( dirPath ) );
    //Show errors
    vhost.use( express.errorHandler({ dumpExceptions: true, showStack: true }));

    return express.vhost(domainName, vhost)
}

//Create server
var app = express();

//Create the virtual hosts
var potatoHost = createVirtualHost("www.potato.com", "potato");
var tomatoHost = createVirtualHost("www.tomato.com", "tomato");

//Use the virtual hosts
app.use(potatoHost);
app.use(tomatoHost);

//Start server
var port = 80;
app.listen( port, function() {
    console.log( 'Express server listening on port %d in %s mode', port, app.settings.env );
});

{% endhighlight %}

Testing the Server
------------------
In order to see the server work, we must own both domain names and set their addresses to that of our server. Since we do not own the domain names and the process is arduous, we will modify the hosts file to make those domain names point to our local machine.

On Windows, the hosts file can be found in c:\windows\system32\drivers\etc

On Mac or Linux, the hosts file can be found in /etc

The hosts file may be hidden on some systems. If you do not see it in the directory, make sure that you enable viewing hidden files from your folder options or control panel.

Open the hosts file, add the following lines of code to the bottom of the file, and save it.

{% highlight sh %}

127.0.0.1 www.potato.com
127.0.0.1 www.tomato.com

{% endhighlight %}

Now, run your NodeJS application and navigate to www.potato.com and www.tomato.com from any browser. Voila! You should now be directed to the potato website and the tomato website respectively. Give yourself a pat on the back and have some chicken alfredo with a potato and a tomato on the side.

[vhost]: https://github.com/expressjs/vhost