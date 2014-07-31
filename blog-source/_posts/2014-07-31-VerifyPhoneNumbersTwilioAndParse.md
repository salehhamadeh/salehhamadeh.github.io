---
layout: post
title:  "How to verify phone numbers using Twilio and Parse"
date:   2014-07-31 7:50:00
categories: [web, mobile, twilio, parse]
---

Do you want to create an app that relies on a user's phone number to function? If so, you have probably heard about [Twilio][twilio]. Twilio provides an API for developers to send and receive text messages as well as calls. On the other hand, [Parse][parse] has gained much popularity as a mobile app backend. Using Twilio along with Parse, you can verify your users' phone numbers and store them in a database using fewer than 35 lines of server-side code. Sounds too good to be true, doesn't it? Let's get started.

Parse Cloud Functions
---------------------
We need to store the code that communicates with Twilio somewhere on the server. This code is placed in what Parse calls [Cloud Functions][cloud-functions]. Simply, Cloud Functions are functions that run on the server. However, they are triggered by the clients, which makes them act as API endpoints. For our purposes, we need to define two Cloud Functions: one to send the verification code to the user and one to verify the user's number.

Creating Your First Cloud Function
----------------------------------
To start developing Cloud Functions, you must first have Parse's Command Line Tool installed on your machine. Since Parse did a great job in explaining this process, I will not repeat it here. If you have never written a Cloud Function before, please follow the Getting Started section of the [Parse Cloud Code Guide][cloud-code-guide].

Send Verification Code
----------------------
The first Cloud Function that we need to write is the one that send the verification code to the user's phone. Luckily, Parse comes with bundled with a [Twilio Cloud Module][twilio-cloud-module]. In other words, you do not need to install a Twilio client for your Parse function. All you need to do is import it. To import it, put the following line at the top of your main.js file, replacing <Your Twilio Account Sid> and <Your Twilio Auth Token> with their respective values from your Twilio dashboard.

{% highlight js %}

var twilio = require('twilio')('<Your Twilio Account Sid>', '<Your Twilio Auth Token>');

{% endhighlight %}

Now, you have all you need to define your verfication code cloud function. I will call this function sendVerificationCode, but you can have any name that you like. The function is defined as follows:

{% highlight js %}

Parse.Cloud.define("sendVerificationCode", function(request, response) {
	var verificationCode = Math.floor(Math.random()*999999);
	var user = Parse.User.current();
	user.set("phoneVerificationCode", verificationCode);
	user.save();
	
    twilio.sendSms({
	    From: "<Your Twilio phone number>",
	    To: request.params.phoneNumber,
	    Body: "Your verification code is " + verificationCode + "."
    }, function(err, responseData) { 
	    if (err) {
	      response.error(err);
	    } else { 
	      response.success("Success");
	    }
  	});
});

{% endhighlight %}

This function accepts the phone number as a parameter, as seen in request.params.phoneNumber. It generates a verification code and stores it in the user's record. Then, it sends that code to the user via Twilio.

Verify Phone Number
-------------------
The second Cloud Function that we need to define is the one that verifies the user's phone number and stores it in the database. I will call this function verifyPhoneNumber, and it will take the phone number and the verification code as parameters. It is defined as follows:

{% highlight js %}

Parse.Cloud.define("verifyPhoneNumber", function(request, response) {
	var user = Parse.User.current();
	var verificationCode = user.get("phoneVerificationCode");
	if (verificationCode == request.params.phoneVerificationCode) {
		user.set("phoneNumber", request.params.phoneNumber);
		user.save();
		response.success("Success");
	} else {
		response.error("Invalid verification code.");
	}
});

{% endhighlight %}

As you can see, this function first checks if the verification code that the user sends matches that which was saved in the database. If it is, it sets the user's phone number to the number that the user included in his request.

Deploying the Cloud Functions
-----------------------------
At this point, you are done with your server-side logic. Go ahead and save the main.js file. Then, use the command line to go to the root directory of your cloud code. When you are there, run the following command to push your code to Parse:

{% highlight js %}

parse deploy

{% endhighlight %}

Next Steps
----------
Now that your backend is ready to roll, it is time to connect your client-side. With Parse's SDK, all you need to do is use the Call Cloud Function command. This differs from platform to platform, so refer to the Parse documentation to find the command for calling a Cloud Function from your client app.

Of course, this is not the best solution to verify phone numbers. It has some drawbacks, such as the user using a different phone number in the verification step. This tutorial is meant to demonstrate how Twilio and Parse can be used together. Now, it is time to use your head and come up with a better and more secure solution. Have fun coding.

[twilio]: https://www.twilio.com/
[parse]: https://parse.com/
[cloud-functions]: https://www.parse.com/docs/cloud_code_guide
[cloud-code-guide]: https://parse.com/docs/cloud_code_guide
[twilio-cloud-module]: https://www.parse.com/docs/cloud_modules_guide#twilio