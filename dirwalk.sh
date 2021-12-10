#!/bin/sh
# This sh function searches for all of the Git projects under the
# current working directory, and lists them.  When you enter the
# number, you change to that directory. If you specify any parameters,
# they are treated as regular expressions, and only the directories
# matching those patterns are printed.
#
# To use this, you can add it to your .bash_aliases file. Note the
# two '>>' characters so that you APPEND to an existing file,
# rather than overwriting it.
#
# Example:
# cat  <this file>  >> ~/.bash_aliases
#
#Then make sure you have something like this in your .bashrc file
#
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi


dirwalk ()
{

    # Detect color terminal
    if [ -x /usr/bin/tput ] && /usr/bin/tput setaf 1 >&/dev/null; then
        BLACK="\x1b[01;30m"
        RED="\x1b[01;31m"
        GREEN="\x1b[01;32m"
        YELLOW="\x1b[01;33m"
        BLUE="\x1b[01;34m"
        MAGENTA="\x1b[01;35m"
        CYAN="\x1b[01;36m"
        WHITE="\x1b[01;37m"
        BOLD="\x1b[1m"
        OFF="\x1b[0m"
    fi


    typeset -a DIRLIST

    for gitdir in $(find . -type d -name .git -print)
    do
        dir=$(dirname $gitdir)

        if [[ $# -gt 0 ]]; then
            for pattern in "$@"
            do
                if [[ $dir =~ $pattern ]]
                then
                    DIRLIST+=("$dir")
                fi
            done
        else
            if [[ ${#dir} -gt 3 ]]
            then
                DIRLIST+=("${dir:2}")
            fi
        fi
    done

    if [[ ${#DIRLIST} -eq 0 ]]
    then
        printf "${RED}No git sub-directories found!${OFF}\n" >&2
        return 1
    fi

    typeset -i i=0
    while [[ $i -lt ${#DIRLIST[@]} ]]; do
        printf "${CYAN}%2d${OFF} - %s\n" "$i" "${DIRLIST[$i]}"
        i=$(expr $i + 1 )
    done

    printf "${BOLD}Enter number: ${OFF}"
    read

    if ! [[ "${REPLY}" =~ ^[0-9]+$ ]]; then
        printf "${RED}Error: invalid input ${BLACK}(${REPLY} is not a number!)${OFF}\n" >&2
        return 1
    fi


    if [[ "${REPLY}" -ge "${#DIRLIST[@]}" ]]
    then
        printf "${RED}Error: invalid input ${BLACK}(${REPLY} >= ${#DIRLIST[@]})${OFF}\n" >&2
        return 1
    fi

    cd "${DIRLIST[REPLY]}"

}
