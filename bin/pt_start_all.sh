#!/usr/bin/env bash

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

#
#
# Starts up the smokeping tools, mirrors, and watchdog
#
#

# This determines the location of this directory
PERLTEST_DIR="$( cd -- "$(dirname "$0")"/.. && pwd)"

# Bring in important functions
. $PERLTEST_DIR/functions/common.sh
. $PERLTEST_DIR/functions/screen.sh
. $PERLTEST_DIR/functions/pt.sh

# Make sure we have a good path
PATH="$PERLTEST_DIR/bin:$PATH"

#
# Main Program
#

NICE=nice
if [ -x /usr/bin/ionice ] ; then
    _debug "Using ionice"
    NICE="$NICE ionice -c idle"
fi

FQDN="$(hostname)"
$NICE $PERLTEST_DIR/config/$FQDN

# $PERLTEST_DIR/bin/pt_watchdog.sh

