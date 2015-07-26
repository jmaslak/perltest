#!/usr/bin/env bash

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

#
#
# Starts up the mirroring
#
#  $1    -> Version of Perl (as defined by Perlbrew) to use
#

# This determines the location of this directory
PERLTEST_DIR="$( cd -- "$(dirname "$0")"/.. && pwd)"

# Bring in important functions
. $PERLTEST_DIR/functions/common.sh
. $PERLTEST_DIR/functions/screen.sh
. $PERLTEST_DIR/functions/pt.sh

# The command to do the actual "smoking" inside Screen
INTERNALCMD=pt_internal_mirror.sh

#
# Main Program
#

VER=$1
shift
_debug "Running screen to start mirror using $VER"

which perlbrew >/dev/null
if [ $? -ne 0 ] ; then
    _error "Cannot find perlbrew in your path"
fi

PT_TITLE="cpan_mini"
_screen_start "cpan_mini" perlbrew exec --with "$VER" \
    "$PERLTEST_DIR/bin/$INTERNALCMD"

_debug "Started screen for mirror using $VER"

