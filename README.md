# Dirwalk

Dirwalk is a shell-script function that lets you easily change your
working directory to a given Git project.

## History

I frequently find myself with a lot of Git repositories, and I want to
be able to quickly change to the correct directory, without a lot of
typing.

I can create a shell alias to change to the root directory, but how
can I quickly change to the correct sub-directory, without a lot of
typing?

Enter dirwalk!

Just type it, optionally with a regular expression, and it will find
the correct sub-directory.

## Note

Note that this has to be a shell function, otherwise it will change
the working directory of a child process, and then it will exit,
leaving you where you started.

## Supported Shells

I prefer the [fish shell](https://fishshell.com), but I also wrote a
[Zsh](https://www.zsh.org) version. A bash/ksh/POSIX version would not be
difficult to add, if there's interest.


