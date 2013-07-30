Latrine
=======

[Locus Map](http://www.locusmap.eu/) Android GPS live tracking server script

==== THIS IS ALPHA SOFTWARE - USE AT YOUR OWN RISKS ====

Latrine is a minimalist GPS live tracking server script.
It is very easy to set up and requires no database.
All you need is a web server which can execute Perl scripts.

More information on the live tracking feature of Locus Map Pro can be found on its [documentation web page](http://docs.locusmap.eu/doku.php/manual:live_tracking).


Features
--------

* Tracking: Server receives data from Android device with Locus Pro installed and live tracking enabled.
* Live following: Data sent by Locus Pro is shown live on map.
* Multiple map layers: Currently you can choose between OpenStreetMap, OpenCylceMap, Hike and Bike (with Hillshading) and ESRI
* Multi-user: Authentication with key


Functions
---------

Authentication is done with a key. Anyone who knows the key can see and update the GPS location.
Your key must be at least 5 characters up to 15 characters `a-zA-Z0-9_`.

### Update

	http://<SERVER>/latrine.pl?key=<KEY>&lat=<Latitude>&lon=<Longitude>&alt=<Altitude>&speed=<Speed>&bearing=<Bearing>&acc=<Accuracy>

Example:

	http://localhost/cgi-bin/latrine.pl?key=OnMyBike&lat=45.09&lon=6.07&acc=5&speed=4.16666667

### Get JSON

	http://<SERVER>/latrine.pl?key=<KEY>&view=1

Example:

	http://localhost/cgi-bin/latrine.pl?key=OnMyBike&view=1


### Show map

	http://<SERVER>/latrine.html?#<KEY>

[Example](http://imgur.com/RkcIopH):

	http://localhost/latrine.html?#OnMyBike



Installation
------------

1.) Adjust the storage location `my $store = '/tmp/latrine/';` in `latrine.pl`
2.) Adjust the location (URL) to your Perl script `var perlScript = 'latrine.pl';` in `latrine.html`
3.) Upload `latrine.pl` and `latrine.html` onto your web server. The Perl script `latrine.pl` must be executable by the web server.


Sample Configuration for Mac OS X
---------------------------------

* Web Sharing must be [enabled](http://support.apple.com/kb/HT3323)
* Copy `latrine.html` to `/Library/WebServer/Documents/`
* Copy `latrine.pl` to `/Library/WebServer/CGI-Executables/` and run `chmod +x latrine.pl`
* Default storage location in `latrine.pl` is just fine
* Adjust the location (URL) in `latrine.html` to `var perlScript = '/cgi-bin/latrine.pl';`

