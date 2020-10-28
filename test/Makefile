# Copyright 2013-2020 Lawrence Livermore National Security, LLC and other
# sbang project developers. See the top-level COPYRIGHT file for details.
#
# SPDX-License-Identifier: (Apache-2.0 OR MIT)

# Run make to run the test suite with just sbang.
# Run make COVERAGE=TRUE to run with kcov
COVERAGE_DIR = ../coverage
SBANG_SCRIPT = ../sbang
SBANG = $(if $(COVERAGE),kcov $(COVERAGE_DIR) ,)$(SBANG_SCRIPT)

test:
	echo $(SBANG)
	SBANG="$(SBANG)" ./test-suite.sh

shellcheck:
	shellcheck $(SBANG_SCRIPT)
