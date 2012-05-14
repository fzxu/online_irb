Browser based IRB
=================

A very simple Ruby Interpreter Online, based on Sinatra


[Online demo](http://onlineirb.cloudfoundry.com/)
-------------


How to install locally
----------------------
    bundle install
	
    ruby onlineirb.rb
	
Then you would be able to access localhost:4567 from your browser.

How to use
----------

You can clear the console by:

    irb> clear
  
You also can use ending **\\** to continue programming, the whole bunch of code would be executed at the statement without **\\** ending.

![screen shot](online_irb/raw/master/screenshot.png "Screen Shot")

You can also deploy this project to cloudfoundy.com without any changes required.