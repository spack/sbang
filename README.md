# sbang

`sbang` lets you run scripts with very long shebang (`#!`) lines.

Many operating systems limit the length and number of possible arguments
in shebang lines, making it hard to use interpreters that are deep in the
directory hierarchy or require special arguments.

To use, put the long shebang on the second line of your script, and
make sbang the interpreter, like this:

    #!/bin/sh /path/to/sbang
    #!/long/path/to/real/interpreter with arguments

`sbang` will run the real interpreter with the script as its argument.

## Longer explanation

Suppose you have a script, `long-shebang.sh`, like this:

    1    #!/very/long/path/to/some/interp
    2
    3    echo "success!"

If `very/long/path` is actually very long, running this script will
result in an error on some OS's. On Linux, you get this:

    $ ./long-shebang.sh
    -bash: ./longshebang.sh: /very/long/path/to/some/interp: bad interpreter:
           No such file or directory

On macOS, the system simply assumes the interpreter is the shell and
tries to run with it, which is not likely what you want.


### `sbang` on the command line

You can use `sbang` in two ways. You can use it directly, from the
command line, like this:

    $ sbang ./long-shebang.sh
    success!


### `sbang` as the interpreter

You can also use `sbang` *as* the interpreter for your script. Put
`#!/bin/sh /path/to/sbang` on line 1, and move the original shebang to
line 2 of the script:

    1    #!/bin/sh /path/to/sbang
    2    #!/long/path/to/real/interpreter with arguments
    3
    4    echo "success!"

    $ ./long-shebang.sh
    success!

On Linux, you could shorten line 1 to `#!/path/to/sbang`, but other
operating systems like Mac OS X require the interpreter to be a binary,
so it's best to use `sbang` as an argument to `/bin/sh`. Obviously, for
this to work, `sbang` needs to have a short enough path that *it* will
run without hitting OS limits.

### Other comment syntaxes

For Lua, node, and php scripts, the second line can't start with `#!`, as
`#` is not the comment character in these languages (though they all
ignore `#!` on the *first* line of a script). Instrument such scripts
like this, using `--`, `//`, or `<?php ... ?>` instead of `#` on the
second line, e.g.:

    1    #!/bin/sh /path/to/sbang
    2    --!/long/path/to/lua with arguments
    3    print "success!"

    1    #!/bin/sh /path/to/sbang
    2    //!/long/path/to/node with arguments
    3    print "success!"

    1    #!/bin/sh /path/to/sbang
    2    <?php #/long/path/to/php with arguments ?>
    3    <?php echo "success!\n"; ?>

## How it works

`sbang` is a very simple posix shell script. It looks at the first two
lines of a script argument and runs the last line starting with `#!`,
with the script as an argument. It also forwards arguments.


## Authors

`sbang` was created by Todd Gamblin, tgamblin@llnl.gov, as part of
[Spack](https://github.com/spack/spack).

## License

`sbang` is distributed under the terms of both the MIT license and the
Apache License (Version 2.0). Users may choose either license, at their
option.

All new contributions must be made under both the MIT and Apache-2.0
licenses.

See [LICENSE-MIT](https://github.com/spack/sbang/blob/develop/LICENSE-MIT),
[LICENSE-APACHE](https://github.com/spack/sbang/blob/develop/LICENSE-APACHE),
[COPYRIGHT](https://github.com/spack/sbang/blob/develop/COPYRIGHT), and
[NOTICE](https://github.com/spack/sbang/blob/develop/NOTICE) for details.

SPDX-License-Identifier: (Apache-2.0 OR MIT)

LLNL-CODE-811652
