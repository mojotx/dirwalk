# This zsh function searches for all of the Git projects under the
# current working directory, and lists them.  When you enter the
# number, you change to that directory. If you specify any parameters,
# they are treated as regular expressions, and only the directories
# matching those patterns are printed.
#
# To use this, add this to your fpath and .zshrc
#
# Example:
# mkdir ~/.config/zsh/fpath
# copy <this file> ~/.config/zsh/fpath
#
#Then add these two lines to the end of your .zshrc:
#   fpath=(~/.config/zsh/fpath $fpath)
#   autoload -Uz dirwalk


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

    if [[ ${#DIRLIST[@]} -eq 0 ]]
    then
        print "${RED}No git sub-directories found!${OFF}" >&2
        return 1
    fi

     for ((i = 1; i <= $#DIRLIST; i++)) printf "${CYAN}%2d${OFF} - %s\n" $i $DIRLIST[i]

    print -n "${BOLD}Enter number: ${OFF}"
    read

    if ! [[ "${REPLY}" =~ ^[0-9]+$ ]]; then
        print "${RED}Error: invalid input ${BLACK}(${REPLY} is not a number!)${OFF}\n" >&2
        return 1
    fi

    if [[ ${REPLY} -gt ${#DIRLIST} ]]
    then
        print "\x1b[31mError: invalid input ${BLACK}(${REPLY} > ${#DIRLIST})${OFF}" >&2
        return 1
    fi

    cd "${DIRLIST[REPLY]}"

}
