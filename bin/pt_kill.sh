#!/usr/bin/env bash

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

#
#
# Kills a set of tests
#
#

# This determines the location of this directory
PERLTEST_DIR="$( cd -- "$(dirname "$0")"/.. && pwd)"

. $PERLTEST_DIR/functions/common.sh
. $PERLTEST_DIR/functions/screen.sh
. $PERLTEST_DIR/functions/pt.sh

_screen_kill "$1"

