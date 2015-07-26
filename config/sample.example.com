#!/bin/bash

# Copyright (C) 2015 By Joel C. Maslak
# Licensed under the terms of Perl 5

#
#
# Perl Smoking Config File
#
#

# Program       Perl Version                   Arguments
pt_mirror.sh    perl-5.22.0
pt_smoke_one.sh sysperl
pt_smoke_one.sh perl-5.23.1		       'random=>1'

