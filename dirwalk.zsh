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
        print "\x1b[31mNo git sub-directories found!\x1b[0m" >&2
        return 1
    fi

     for ((i = 1; i <= $#DIRLIST; i++)) printf "\x1b[36m%2d\x1b[0m - %s\n" $i $DIRLIST[i]

    print -n "\x1b[1mEnter number: \x1b[0m"
    read

    if [[ ${REPLY} -gt ${#DIRLIST} ]]
    then
        print "\x1b[31mError: invalid input \x1b[1;30m(${REPLY} > ${#DIRLIST})\x1b[0m" >&2
        return 1
    fi

    cd "${DIRLIST[REPLY]}"

}
