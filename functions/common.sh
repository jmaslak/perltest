#!/usr/bin/env bash

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

DEBUG=1

#
# Display an error message and exit
#
# $1..$n -> Message to display
function _error {
    echo '[ERROR]' "$@" >&2
    exit 1
}

#
# Display a debug message
#
# $1..$n -> Message to display
function _debug {
    if [ "$DEBUG" != "" ] ; then
        echo '[DEBUG]' "$@" >&2
    fi
}

#
# Display a warning message (don't crash)
#
# $1..$n -> Message to display
function _warn {
    echo '[WARN ]' "$@" >&2
}

