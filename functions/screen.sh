#!/usr/bin/env bash

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

# For detecting invalid characters (spaces)
SP='[^0-9a-zA-Z_-][^0-9a-zA-Z_-]*'

# Starts a screen session if one by a given name is not already
# running.
#
#   $1    -> Name of session
#   $2    -> Command to run in Screen
#   $3-$n -> [Optional] Arguments to Command
#
function _screen_start {
    if [ "$2" == "" ] ; then
        _error "Must provide description and command"
    fi

    screen -ls | egrep "\.${PT_PREFIX}$1${SP}" >/dev/null
    if [ $? -ne 0 ] ; then
        # Not found, so we start
        SESSION="$1"
        _debug "Starting screen session \"$1\""
        shift
        if [ "$PT_TITLE" != "" ] ; then
            screen -d -m -S "${PT_PREFIX}$SESSION" -t "$PT_TITLE" \
                -c $PERLTEST_DIR/include/screenrc -U -- "$@"
        else
            screen -d -m -S "${PT_PREFIX}$SESSION" \
                -c $PERLTEST_DIR/include/screenrc -U -- "$@"
        fi
        sleep 5 # We stagger these a bit
    else
        # Screen already running
        _warn "Screen session \"$1\" is already running"
        return 1
    fi

    return 0
}

# Interactively connect to a screen
function _screen_connect {
    _screen_exist "$1" >/dev/null
    if [ $? -ne 0 ] ; then return 1 ; fi

    _debug "Connecting to session \"$SC\""
    # This already has the prefix.
    screen -r "$SC"
    return 0
}

# Tests to see if a screen exists
# $1 -> Screen name
#
# Returns 0 if exist, != 0 otherwise
# Also returns (side effect) "SC" representing pts.<name> of screen
function _screen_exist {
    if [ "$1" == "" ] ; then
        _error "Must provide the screen name"
    fi

    if [[ "$1" == *.* ]] ; then
        SC=$(screen -ls | egrep "${PT_PREFIX}$1${SP}" | awk '{print $1}' | head -1)
    else
        SC=$(screen -ls | egrep "\.${PT_PREFIX}$1${SP}" | awk '{print $1}' | head -1)
    fi

    if [ "$SC"z == ""z ] ; then
        _warn "Screen session \"$1\" is not running"
        return 1
    fi

    return 0
}

# Gets the title bar of the current screen
# $1 -> Screen name
#
# Returns 0 if exist, != 0 otherwise
# Also Returns (side effect) screen name in $SC_TITLE
function _screen_title {
    _screen_exist "$1" >/dev/null
    if [ $? -ne 0 ] ; then return 1 ; fi

    SC_TITLE="$(screen -S "$SC" -Q title)"
    return 0;
}

# Gets list (in array) of current screen sessions
# that match a given name prefix
#
# $1 -> Prefix to match (can be empty to match all)
#
# Returns, via side-effect, array of names.  This can be empty.
function _screen_list {
    SC_LIST=( $(screen -ls | \
                egrep "^${SP}[0-9]" | \
                awk '{print $1}' | \
                grep "^[0-9][0-9]*\.${PT_PREFIX}$1" | \
                sed -e "s/^[0-9][0-9]*\.${PT_PREFIX}//" | \
                sort
    ) )
}

# Kills a screen session
#
# $1 -> Name to kill
function _screen_kill {
    _screen_exist "$1" >/dev/null
    if [ $? -ne 0 ] ; then return 1 ; fi

    # This already has the prefix.
    screen -S "$SC" -X quit

    _debug "Sent quit to session \"$SC\""
    return 0
}
