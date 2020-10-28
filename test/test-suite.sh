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

# enable debug mode for tests below to work
export SBANG_DEBUG=1

title "Testing languages with shell-style comments"
contains "/usr/bin/perl -x"         $SBANG shebangs/perl.pl
contains "/usr/bin/env perl -x"     $SBANG shebangs/perl-env.pl
contains "/usr/bin/perl -w -x"      $SBANG shebangs/perl-w.pl
contains "/usr/bin/env perl -w -x"  $SBANG shebangs/perl-w-env.pl

contains "/usr/bin/ruby -x"         $SBANG shebangs/ruby.rb
contains "/usr/bin/env ruby -x"     $SBANG shebangs/ruby-env.rb

contains "/usr/bin/python"          $SBANG shebangs/python.py
contains "/usr/bin/env python"      $SBANG shebangs/python-env.py

contains "/bin/sh"                  $SBANG shebangs/sh.sh
contains "/bin/bash"                $SBANG shebangs/bash.bash

title "Testing languages without shell-style comments"
contains "/path/to/lua"             $SBANG shebangs/lua.lua
contains "/path/to/node"            $SBANG shebangs/node.js
contains "/usr/bin/php"             $SBANG shebangs/php.php

title "Testing sbang fails with invalid input"
fails $SBANG
fails $SBANG nonexistent-file
fails $SBANG shebangs/no-interpreter

title "Testing sbang doesn't loop infinitely"
fails $SBANG shebangs/sbang
fails $SBANG shebangs/sbang-env
