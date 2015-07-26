#!/usr/bin/env bash

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

#
#
# Connects to the screen output for all of the consoles
#
#

# This determines the location of this directory
PERLTEST_DIR="$( cd -- "$(dirname "$0")"/.. && pwd)"

. $PERLTEST_DIR/functions/common.sh
. $PERLTEST_DIR/functions/screen.sh
. $PERLTEST_DIR/functions/pt.sh

_screen_list "$1"
for i in ${SC_LIST[@]}; do
    _screen_connect "$i"
done

_debug "Done!"

