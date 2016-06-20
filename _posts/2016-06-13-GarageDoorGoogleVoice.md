---
layout: post
title:  "Using Google Voice to Control my Garage Door"
date:   2016-06-13 8:45:00
categories: hacking
---


<iframe class="youtube-video" width="760" height="428" src="https://www.youtube.com/embed/Hm1OvV25Gc8" frameborder="0" allowfullscreen></iframe>

Over my break, I decided to start getting into IoT by making my home smarter. I did not want to purchase any of the plug and play devices. The fun part is building these devices. My first idea of home automation is the garage door, since I had all the parts needed to automate it in my junk box.

## Parts

* Garage door with remote or switch
* Breadboard
* Microcontroller
* ESP8266
* 2 resistors
* Transistor
* Wires
* Screwdriver
* Solder and soldering iron (optional)

## The Hardware

![Screenshot](/images/garage-door-switch.jpg)

The easiest way to open a garage door is to push the button on the remote. That would be a good starting point for my device.

First, I opened the remote with a screwdriver. On the PCB, I saw the switch that is pushed when I pushed the button. The switch had four pins. To figure out which pins will open the door, I used a small wire to short every two pins until the door opened.

Now that we know which pins need to be connected to open the garage door, we want to connect the pins using a digital signal. That's where the transistor comes in. I did not have any MOSFETs in my junk box, so I had to settle with an NPN bipolar transistor and a resistor.

We connect the transistor's collector and emitter to the pins of the switch and connect the base to a digital output pin on the microcontroller (with a resistor). I used a Teensy 3.2 microcontroller since it's small and inexpensive.

Finally, we connect the ESP8266 to the microcontroller to be able to use Wifi.

![Screenshot](/images/garage-controller-board.jpg)

## The Software

The code on the Teensy is pretty straightforward. All it does is start an HTTP server that has a single route (/toggledoor). When a client hits this route, the microcontroller sends a HIGH signal to the transistor for 500ms. This emulates a button press and causes the door to open.

I did not have to write any code on my phone. I used two apps to control the door. The first app is [AutoVoice][autovoice]. This app captures whatever I say to Google Now. It has many features for filtering commands and responding to them. I used another amazing app called [Tasker][tasker] to send the HTTP request to my microcontroller. Tasker works with AutoVoice to trigger an action when AutoVoice recognizes a command.

This is all it takes to control a garage door using Google Voice. The next step is to see if I can program the ESP8266 to do all of that without using another microcontroller.

[autovoice]: https://play.google.com/store/apps/details?id=com.joaomgcd.autovoice&hl=en
[tasker]: https://play.google.com/store/apps/details?id=net.dinglisch.android.taskerm&hl=en
