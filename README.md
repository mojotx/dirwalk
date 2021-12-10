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

## Example

[![asciicast](https://asciinema.org/a/mdWiHDlEl02C4r8OH1LEQ1Znp.svg)](https://asciinema.org/a/mdWiHDlEl02C4r8OH1LEQ1Znp)

## Note

Note that this has to be a shell function, otherwise it will change
the working directory of a child process, and then it will exit,
leaving you where you started.

## Supported Shells

I prefer the [fish shell](https://fishshell.com), but I also wrote a
[Zsh](https://www.zsh.org) version and
[Bash](https://gnu.org/software/bash) version. With some fiddling, you
could probably get this to work with a more minimal shell, such as the
original Bourne shell, or one of the lighter-weight shells such as
ash. I may do so, when I find time.

## To-Do

I will be adding a ksh specific version soon. I may also see if I can
consolidate the POSIX-ish shells, such as Zsh and Bash, into one
script. However, currently there are some subtle differences between
the shells that makes that challenging, e.g., zsh indexing arrays
starting with 1, while Bash starts with 0, etc.
