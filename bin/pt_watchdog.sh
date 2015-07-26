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

# The command to do the actual "smoking" inside Screen
INTERNALCMD=pt_internal_watchdog.sh


#
# Main Program
#

_debug "Running screen to manage the watchdog service"
PT_TITLE="watchdog"
_screen_start "watchdog" "$PERLTEST_DIR/bin/$INTERNALCMD"
_debug "Started screen for watchdog service"

