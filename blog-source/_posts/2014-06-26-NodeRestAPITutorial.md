---
layout: post
title:  "How to build a scalable REST API using Node.JS and Express"
date:   2014-06-26 12:45:00
categories: web
---

When I build an API, I like to have it as light-weight and scalable as possible. At the same time, I want to be able to easily add or remove features with the least amount of effort possible. Because [Node.JS][nodejs] and [Express][expressjs] give control over the inner workings of a web application, they are the perfect fit.

What will we build?
-------------------
We will build a RESTful API for a library. A library has books, accounts, DVDs, and many more things. As I always do, I will approach the problem by building an API for books only, and then scaling it to include all the other library items.

First Rollout: Build a Dumb Server
----------------------------------
Before we start writing code, we need to fetch the dependencies. Even though the only dependency is Express, I like to keep a package.json file in case I ever decide to add other dependencies in the future. So, the first thing we will do is create a file called package.json and put the following code in it:

{% highlight json %}
{
    "name": "library-rest-api",
    "version": "0.0.1",
    "description": "A simple library REST api",
    "dependencies": {
        "express": "~3.1.0"
    }
}
{% endhighlight %}

Now open up your terminal or command line and go to the project's directory. Type

{% highlight sh %}
npm install
{% endhighlight %}

to install Express. It will be installed in the node_modules directory.

Now that we have all the dependencies ready, let's create a simple server that will capture requests and respond with a Hello World.

{% highlight js %}
// Module dependencies.
var application_root = __dirname,
    express = require( 'express' ); //Web framework

//Create server
var app = express();

// Configure server
app.configure( function() {
    //parses request body and populates request.body
    app.use( express.bodyParser() );

    //checks request.body for HTTP method overrides
    app.use( express.methodOverride() );

    //perform route lookup based on url and HTTP method
    app.use( app.router );

    //Show all errors in development
    app.use( express.errorHandler({ dumpExceptions: true, showStack: true }));
});

//Router
//Get a list of all books
app.get( '/api/books', function( request, response ) {
    var books = [
            {
                title: "Book 1",
                author: "Author 1",
                releaseDate: "01/01/2014"
            },
            {
                title: "Book 2",
                author: "Author 2",
                releaseDate: "02/02/2014"
            }
        ];

    response.send(books);
});
//Insert a new book
app.post( '/api/books', function( request, response ) {
    var book = {
        title: request.body.title,
        author: request.body.author,
        releaseDate: request.body.releaseDate
    };
    
    response.send(book);
});
//Get a single book by id
app.get( '/api/books/:id', function( request, response ) {
    var book = {
        title: "Unique Book",
        author: "Unique Author",
        releaseDate: "03/03/2014"
    };
    
    response.send(book);
});
//Update a book
app.put( '/api/books/:id', function( request, response ) {
    response.send("Updated!");
});
//Delete a book
app.delete( '/api/books/:id', function( request, response ) {
    response.send("Deleted");
});

//Start server
var port = 4711;
app.listen( port, function() {
    console.log( 'Express server listening on port %d in %s mode', port, app.settings.env );
});
{% endhighlight %}

Save the file and run

{% highlight sh %}
node server.js
{% endhighlight %}

to start the server. The server should response with the hardcoded data when you try to get a book and should echo back the data when you try to do another operation, such as inserting, deleting, or updating.

From Dumb to RESTful
--------------------
Before we can use real data in our API, we must understand the two fundamental requirements for every API. These two fundamental requirements are communication and storage.

Communication refers to the way in which data is passed back-and-forth between the server and the clients. Since we are building a RESTful API, our communication protocol is [HTTP][http], which we dealt with using Express.

Storage refers to the medium and format in which data is stored. For example, data can be stored on a database server, in a file, or in memory. To fulfill this requirement, I like to start by using MongoDB to store my data. To access the [MongoDB][mongodb] database from Node.JS, we will use an NPM package called [Mongoose][mongoose].

Setting up the Database
-----------------------
Before you start using real data in your API, you need to install MongoDB or use a third-party service like MongoHQ. Please refer to the instructions on the MongoDB website to install MongoDB.

After you install MongoDB, create a database called library_database. Then, add a collection named "books" to the database. Run the database server (mongod), and you should be all set.

Second Rollout: Use Real Data
-----------------------------
As always, before we start writing any code, we must have all the dependencies ready. The new dependency that we will introduce for this rollout is Mongoose. To install Mongoose, modify your package.json file to look as follows:

{% highlight json %}
{
    "name": "library-rest-api",
    "version": "0.0.1",
    "description": "A simple library REST api",
    "dependencies": {
        "express": "~3.1.0",
        "mongoose": "~3.5.5"
    }
}
{% endhighlight %}

and run

{% highlight sh %}
npm install
{% endhighlight %}

To use Mongoose from our Node.js application, we first need to require it. Change the module dependencies code block to

{% highlight js %}
// Module dependencies.
var application_root = __dirname,
    express = require( 'express' ),     //Web framework
    path = require( 'path' ),           //Utilities for dealing with file paths
    mongoose = require( 'mongoose' );   //Used for accessing a MongoDB database
{% endhighlight %}

Then, we need to connect Mongoose to our database. We use the connect method to connect it to our local (or remote) database. Note that the url points to the database inside MongoDB (in this case it is library_database).

{% highlight js %}
//Connect to database
mongoose.connect( 'mongodb://localhost/library_database' );
{% endhighlight %}

Mongoose provides two neat classes for dealing with data: Schema and model. Schema is used for data validation, and Model is used to send and receive data from the database. We will now create a Schema and a Model that adhere to our original data model.

{% highlight js %}
//Schema
var BookSchema = new mongoose.Schema({
    title: String,
    author: String,
    releaseDate: Date
});
//Model
var BookModel = mongoose.model( 'Book', BookSchema );
{% endhighlight %}

Now we have everything ready to start responding to API requests. Since all of the request/response processing happens in the router, we will only change the router code it account for the persistent data. The new router should look as follows:

{% highlight js %}
//Router
//Get a list of all books
app.get( '/api/books', function( request, response ) {
    return BookModel.find(function( err, books ) {
        if( !err ) {
            return response.send( books );
        } else {
            console.log( err );
            response.send('ERROR');
        }
    });
});
//Insert a new book
app.post( '/api/books', function( request, response ) {
    var book = new BookModel({
        title: request.body.title,
        author: request.body.author,
        releaseDate: request.body.releaseDate
    });
    console.log(request.body.title);
    book.save( function( err ) {
        if( !err ) {
            console.log( 'created' );
        } else {
            console.log( err );
            return response.send('ERROR');
        }
        return response.send( book );
    });
});
//Get a single book by id
app.get( '/api/books/:id', function( request, response ) {
    return BookModel.findById( request.params.id, function( err, book ) {
        if( !err ) {
            return response.send( book );
        } else {
            console.log( err );
            return response.send('ERROR');
        }
    });
});
//Update a book
app.put( '/api/books/:id', function( request, response ) {
    return BookModel.findById( request.params.id, function( err, book ) {
        book.title = request.body.title;
        book.author = request.body.author;
        book.releaseDate = request.body.releaseDate;

        return book.save( function( err ) {
            if( !err ) {
                console.log( 'book updated' );
            } else {
                console.log( err );
                return response.send('ERROR');
            }
            return response.send( book );
        });
    });
});
//Delete a book
app.delete( '/api/books/:id', function( request, response ) {
    BookModel.findById( request.params.id, function( err, book ) {
        return book.remove( function( err ) {
            if( !err ) {
                console.log( 'Book removed' );
                return response.send( '' );
            } else {
                console.log( err );
                return response.send('ERROR');
            }
        });
    });
});
{% endhighlight %}

Here we go, our REST API is now ready to roll.

Evident Patterns
----------------
As we were building our RESTful API, some interesting patterns emerged. For example, the router code block can be swapped with another router code block to add new functionality. In this case, it makes more sense to enclose our routing logic in a separate file. As our code grows, we will also have more schemas, models, and logic to worry about. All of these will eventually need to move out of the server file.

Refactor Code
-------------
There are hundreds of ways to improve our code. For demonstration, we will move the routing logic out of the server.js.

First, create a new file called router.js. In that file, create a function named registerRoutes that takes in the Express app and Mongoose as parameters. Then, move all the routing logic from server.js to the newly created function. The contents of router.js will be something like this:

{% highlight js %}
function registerRoutes(app, mongoose) {
    //Router
    //Get a list of all books
    app.get( '/api/books', function( request, response ) {
        return BookModel.find(function( err, books ) {
            if( !err ) {
                return response.send( books );
            } else {
                console.log( err );
                response.send('ERROR');
            }
        });
    });
    
    //...

    //Delete a book
    app.delete( '/api/books/:id', function( request, response ) {
        BookModel.findById( request.params.id, function( err, book ) {
            return book.remove( function( err ) {
                if( !err ) {
                    console.log( 'Book removed' );
                    return response.send( '' );
                } else {
                    console.log( err );
                    return response.send('ERROR');
                }
            });
        });
    });
}
{% endhighlight %}

The last step is to register the routes from server.js. All you have to do is require your router and call the registerRoutes method in place of your old router.

Next Steps
----------
Congratulations! You did it. You built a RESTful API. However, having the API is only one step of the journey. The more important lesson that you need to learn is to take your journey one step at a time. First, create a dumb app. Then, make it smarter. Then, refactor. The cycle goes on and on. The moral of this lesson is that refactoring is a crucial step in software development. Just like you cannot build a skyscraper with a shaky fundamental, you cannot build web applications with bad code. Farewell and good luck on your journey.

[nodejs]: http://nodejs.org/
[expressjs]: http://expressjs.com/
[http]: http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol
[mongodb]: http://www.mongodb.org/
[mongoose]: http://mongoosejs.com/