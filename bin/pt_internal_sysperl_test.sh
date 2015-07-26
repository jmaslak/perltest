#!/usr/bin/env bash

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

#
#
# Executes testing SYSTEM version of Perl.
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

# Unset Perlbrew - Need local lib already configured
export PATH="${HOME}/sysperl/bin${PATH+:}${PATH}"
export PERL5LIB="${HOME}/sysperl/lib/perl5${PERL5LIB+:}${PERL5LIB}"
export PERL_LOCAL_LIB_ROOT="${HOME}/sysperl${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
export PERL_MB_OPT="--install_base \"/${HOME}/sysperl\""
export PERL_MM_OPT="INSTALL_BASE=${HOME}/sysperl"

#
# Main Program
#

$PERLTEST_DIR/bin/pt_internal_one_cpantest.sh "$@"

