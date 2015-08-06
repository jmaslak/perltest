#!/usr/bin/env bash

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

#
#
# Executes testing one version of Perl.
# This is intended to be called within a screen session
# by pt_smokeone.sh
#
#  $1-$n -> Any options (should look like Perl code) you want
#           to pass to CPAN::Reporter::Smoker::start();
#           (can be zero args)
#

# This determines the location of this directory
PERLTEST_DIR="$( cd -- "$(dirname "$0")"/.. && pwd)"

# Bring in important functions
. $PERLTEST_DIR/functions/common.sh
. $PERLTEST_DIR/functions/screen.sh
. $PERLTEST_DIR/functions/pt.sh

#
# Main Program
#

VER=`perl -e 'print $^V'`
_debug "Using Perl Version: $VER"

#
# Make sure we have some key modules
#
# This is done interactively, just in case.
#
_debug "Validating smoking modules exist"
cpan YAML
cpan Task::CPAN::Reporter
cpan Test::Reporter::Transport::Metabase
cpan Crypt::SSLeay
cpan IO::Socket::SSL
cpan CPAN::Reporter::Smoker
cpan App::cpanminus

# We use cpanm here because cpan with my settings
# seems to disagree with these modules.
cpan Term::ReadLine::Perl
cpan Term::ReadLine
cpan Term::ReadKey
cpan Term::ReadLine::Gnu

# And we use this one for pushing out updates to the disabled list
cpan File::Slurper

#
# Make sure we're up to date
#
CDIR="$PWD"
cd "$PERLTEST_DIR/disabled"
git pull
./disabled.pl
cd "$CDIR"

export NONINTERACTIVE_TESTING=1

perl -MCPAN::Reporter::Smoker -e "start($@);"

_warn "Smoker died prematurely - ctrl-C to exit"
while true ; do sleep 60 done

