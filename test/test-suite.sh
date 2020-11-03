#!/bin/sh
#
# Copyright 2013-2020 Lawrence Livermore National Security, LLC and other
# sbang project developers. See the top-level COPYRIGHT file for details.
#
# SPDX-License-Identifier: (Apache-2.0 OR MIT)

set -u
. ./test-framework.sh

# you must set SBANG when running the test suite
if [ -z "${SBANG:-}" ]; then
    echo_red "error: must set SBANG to location of sbang script"
    exit 1
fi

# ensure that arguments are not all passed together as one big string,
# and that escaped arguments are handled.
title "Test arguments are parsed and passed properly"
equals "arg1"      $SBANG shebangs/arg1.sh arg1 "arg2 arg2" arg3\ arg3 arg4
equals "arg2 arg2" $SBANG shebangs/arg2.sh arg1 "arg2 arg2" arg3\ arg3 arg4
equals "arg3 arg3" $SBANG shebangs/arg3.sh arg1 "arg2 arg2" arg3\ arg3 arg4
equals "arg4"      $SBANG shebangs/arg4.sh arg1 "arg2 arg2" arg3\ arg3 arg4

# enable debug mode for tests below to work -- this outputs what would be run
export SBANG_DEBUG=1

title "Testing languages with shell-style comments"
equals "/usr/bin/perl -x shebangs/perl.pl"              $SBANG shebangs/perl.pl
equals "/usr/bin/env perl -x shebangs/perl-env.pl"      $SBANG shebangs/perl-env.pl
equals "/usr/bin/perl -w -x shebangs/perl-w.pl"         $SBANG shebangs/perl-w.pl
equals "/usr/bin/env perl -w -x shebangs/perl-w-env.pl" $SBANG shebangs/perl-w-env.pl

equals "/usr/bin/ruby -x shebangs/ruby.rb"              $SBANG shebangs/ruby.rb
equals "/usr/bin/env ruby -x shebangs/ruby-env.rb"      $SBANG shebangs/ruby-env.rb

equals "/usr/bin/perl5.32.0 -x shebangs/perl-ver.pl"    $SBANG shebangs/perl-ver.pl
equals "/usr/bin/ruby2.7 -x shebangs/ruby-ver.rb"       $SBANG shebangs/ruby-ver.rb

equals "/usr/bin/python shebangs/python.py"             $SBANG shebangs/python.py
equals "/usr/bin/env python shebangs/python-env.py"     $SBANG shebangs/python-env.py

equals "/bin/sh shebangs/sh.sh"                         $SBANG shebangs/sh.sh
equals "/bin/bash shebangs/bash.bash"                   $SBANG shebangs/bash.bash

title "Testing languages without shell-style comments"
equals "/path/to/lua shebangs/lua.lua"                  $SBANG shebangs/lua.lua
equals "/path/to/node shebangs/node.js"                 $SBANG shebangs/node.js
equals "/usr/bin/php shebangs/php.php"                  $SBANG shebangs/php.php

title "Testing sbang fails with invalid input"
fails $SBANG
fails $SBANG nonexistent-file
fails $SBANG shebangs/no-interpreter

title "Testing sbang doesn't loop infinitely"
fails $SBANG shebangs/sbang
fails $SBANG shebangs/sbang-env
