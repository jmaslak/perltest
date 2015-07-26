#!/usr/bin/env bash

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

#
#
# Returns title of screen session
#
# $1 -> List session containing this prefix,
#       if supplied
#
#

# This determines the location of this directory
PERLTEST_DIR="$( cd -- "$(dirname "$0")"/.. && pwd)"

. $PERLTEST_DIR/functions/common.sh
. $PERLTEST_DIR/functions/screen.sh
. $PERLTEST_DIR/functions/pt.sh

printf "%-32s%s\n" "Screen_Name" "Title_Bar"

_screen_list "$1"
for i in ${SC_LIST[@]}; do
    _screen_title "$i"
    printf "%-32s%s\n" "$i" "$SC_TITLE"
done

