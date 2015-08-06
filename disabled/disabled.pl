#!/usr/bin/env perl
#
# Copyright (C) 2015 Joel C. Maslak
# All Rights Reserved
#

use 5.010;

use strict;
use warnings;
use autodie;

use Carp;
use File::Slurper;

MAIN: {
    if ( ! -d "${ENV{HOME}}/.cpan/prefs" ) {
        die "${ENV{HOME}}/.cpan/prefs directory does not exist";
    }

    my ($file) = File::Slurper::read_text('problem-modules.txt');
    my (@lines) = sort { lc($a) cmp lc($b) } split /\n/, $file;

    my $out = '';

    foreach my $line (@lines) {
        chomp($line);
        $line =~ s/#.*$//;
        $line =~ s/^\s+//;
        $line =~ s/\s+$//;
        $line =~ s/\s+/ /g;

        if (! ($line =~ /.+\s.+\s.+/)) { next; }

        my ($pkg, $module, $reason, $comments) =
            $line =~ /^(\S+)\s(\S+)\s(\S+)(?:\s?)(.*)$/;

        if ($reason =~ /_/) {
            my ($os, $r) = split /_/, $reason;
            $reason = $r;

            if (lc($os) ne lc($^O)) {
                print "$pkg blocked only on $os - ignoring\n";
                next;
            }
        }
        
        print "$pkg blocked on this platform ($reason)\n";

        $out .= "---\n";
        $out .= "comment: \"$comments\"\n";
        $out .= "match:\n";
        $out .= "    distribution: \"/$pkg\"\n";
        $out .= "disabled: 1\n";
    }

    File::Slurper::write_text("${ENV{HOME}}/.cpan/prefs/disabled.yml", $out);

    print "Created preference file\n";
}
