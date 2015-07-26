#!/usr/bin/env bash

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

#
#
# Watches for problems with hung processes
#
#  $1    -> Max amount of time a Smoker process can stay on
#           the same package
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

while true ; do

    # Create log location
    if [ \! -e $PERLTEST_DIR/log ] ; then
        _debug "Creating log directory"
        mkdir $PERLTEST_DIR/log
    fi

    # Get status of screens, using temp file
    _debug "Getting status of test sessions"
    TMP=$( mktemp )
    $PERLTEST_DIR/bin/pt_sessions_list.sh |\
        $PERLTEST_DIR/bin/pt_internal_detect_hang.pl >>$TMP

    # Look for the hung processes
    HUNG=$( awk '{print $1}' <$TMP )
    for SCREEN in ${HUNG[@]} ; do
    
        # Extract the title from screen sessions that are hung
        log=$( egrep "^$SCREEN\s" <$TMP )

        date=$( date )
        echo "$date [WARN ] HANGDETECT $log"
        echo "$date [WARN ] HANGDETECT $log" >>$PERLTEST_DIR/log/watchdog.log

        # Kill the bad screen
        _screen_kill "$SCREEN"
    done

    # Cleanup after self
    rm $TMP

    # Try to restart anything killed or crashed
    $PERLTEST_DIR/bin/pt_start_all.sh

    _debug "Sleeping for 1800 seconds"
    sleep 1800
done

