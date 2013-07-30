#!/usr/bin/perl

use strict;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);


###### Adjust the following storage location #########

# Storage location for files with a trailing slash to indicate a directory
my $store = '/tmp/latrine/';

###### Change the following only if you know what you're doing #########


my $view = param('view') || '';
my $key = param('key') || '';

# Locus Pro Parameters
# Latitude - current GPS latitude (in degree unit, rounded on 5 decimal places)
my $lat = param('lat') || '';
# Longitude - current GPS longitude (in degree unit, rounded on 5 decimal places)
my $lon = param('lon') || '';
# Altitude - current altitude value in meter (improved altitude value by filter and barometer)
my $alt = param('alt') || '';
# Speed - current GPS speed (in m/s)
my $speed = param('speed') || '';
# Accuracy - current GPS accuracy (in metres)
my $acc = param('acc') || '';
# Bearing - current GPS bearing (in degree)
my $bearing = param('bearing') || '';
# Time - current GPS time (in format defined by user. You may choose from predefined styles or define you own by this specification)
# my $time = param('time') || '';
# Text field - text field with own define key/value pair.
# my $var = param('var') || '';

# Check storage location
if ($store =~ /\/$/) {
	unless (-d $store) { mkdir($store, 0770) }
	unless (-d $store) { die( "Can\'t create $store: $!" ) }
} else {
	die 'You forgot the trailing slash to indicate a directory!';
}

# Current Unix timestamp
my $time = time;
my $now = $time;

# JSON output
print header('application/json');
print '{';
# Check private key
if ($key =~ /^[\d\w]{5,15}$/ ) {
	$store .= "$key.latlon"; # Create storage location
	# Save latitude, longitude and other data into text file
	if ( $lat =~ /^(\-?\d+(\.\d+))$/ && $lon =~ /^(\-?\d+(\.\d+))$/ ) {
		$alt = '0' unless ($alt > 0 && $alt <= 10000);
		$speed = '0' unless ($speed > 0 && $speed <= 900);
		$bearing = '0' unless ($bearing > 0 && $bearing <= 360);
		$acc = '0' unless ($acc > 0 && $acc <= 1000);
		if (open STORE, "> $store") {
			print STORE "$lat:$lon:$alt:$speed:$bearing:$acc:$time";
			close STORE;
		} else {
			print '"error":"Can\'t open filestore"';
		}
	# Output latitude, longitude and other data as JSON
	} elsif ($view == '1' ) {
		if (open STORE, "< $store") {
			while(<STORE>) {
				($lat,$lon,$alt,$speed,$bearing,$acc,$time) = split(/:/,$_) if $_ =~ /^(\-?\d+(\.\d+))/;
			}
			print qq ~ "lat":"$lat","lon":"$lon","alt":"$alt","speed":"$speed","bearing":"$bearing","acc":"$acc","time":"$time","now":"$now"~;
			close STORE;
		} else {
			print '"error":"Can\'t open filestore"';
		}
	# Parameters are missing
	} else {
		print '"error":"Please provide at least lat and lon parameters"';
	}
# Private key is missing
} else {
	print '"error":"Please provide your private key (at least 5 characters up to 15 characters a-zA-Z0-9_)."';
}
# Done!
print '}';