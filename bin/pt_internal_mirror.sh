#!/usr/bin/env bash

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

#
#
# Script to build a CPAN mirror
#
#

# This determines the location of this directory
PERLTEST_DIR="$( cd -- "$(dirname "$0")"/.. && pwd)"

. $PERLTEST_DIR/functions/common.sh
. $PERLTEST_DIR/functions/screen.sh
. $PERLTEST_DIR/functions/pt.sh

while true ; do
    echo ""
    minicpan \
        -l /data/cpan-mirror \
        -r http://cpan.mirror.facebook.net/ \
        --log-level debug
    _debug "Sleeping for 1800 seconds"
    sleep 1800
done
