#!/usr/bin/env perl
use v5.14;

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

# This is a helper script that finds the date/time strings
# and parses them, returning any string older than 15 minutes
# or the integer value passed on the command line.

use strict;
use warnings;
use autodie;

use Date::Parse;

MAIN: {

    my $delay = $ARGV[1];
    $delay //= 900;
    if ($delay eq '') { $delay = 900; }

    while (<STDIN>) {
        my $line = $_;
        chomp($line);

        if (! ($line =~ m/Smoking .* at /) ) {
            next; # Not a smoking format
        }

        my $dt = $line;
        $dt =~ s/^.* at //;
        my $time = str2time($dt);

        my $screen = $line;
        $screen =~ s/\s.*$//;

        if ( ($time + $delay) < time() ) {
            print "$line\n";
        }
    }
}
