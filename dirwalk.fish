# This fish function searches for all of the Git projects under the
# current working directory, and lists them.  When you enter the
# number, you change to that directory. If you specify any parameters,
# they are treated as regular expressions, and only the directories
# matching those patterns are printed.
#
# To use this, copy this file to ~/.config/fish/functions
function dirwalk --description="walk git directories"

    trap return SIGINT

    set -l useRegex 0
    if test (count $argv) -gt 0
        set useRegex 1
    end

    # The find command finds all of the .git directories. We just want the containing directory.
    # For instance, if we find "/foo/bar/baz/.git", we just want "/foo/bar/baz".
    for dir in (find . -type d -name .git -print)
        set parentDir (dirname $dir)
        if test $useRegex -eq 1
            for pattern in $argv
                if string match -r -q $pattern $parentDir
                    set -a DIRLIST (dirname $dir)
                    #printf "%sMATCH: %s%s\n" (set_color green) $parentDir (set_color normal)
                else
                    #printf "%s MISS: %s%s\n" (set_color brblack) $parentDir (set_color normal)
                end
            end
        else
            set -a DIRLIST (dirname $dir)
        end

    end

    switch (count $DIRLIST) 
    case 0
        # If the array is empty, bail out early
        echo (set_color -o red)Nothing found!(set_color normal)
        return
    case 1
        # If there's only one match, go there
        echo (set_color green)Found it!(set_color normal)
        pushd $DIRLIST[1]
        return $status
    end

    set i 1
    for dir in $DIRLIST
        printf "%s%2d%s - %s\n" (set_color cyan) $i (set_color normal) $dir
        set i (math $i + 1)
    end

    read -P (set_color -o)"Enter number: "(set_color normal) n

    if [ -z $n ]
        return
    end
    if not string match -qr '^[0-9]+$' -- $n
        echo (set_color red)$n is an invalid response(set_color normal)
        return 1
    end
    if [ $n -eq 0 ]
        return
    end

    # Make sure value is within range
    if test $n -gt (count $DIRLIST) -o  $n -lt 1
        printf "%sIndex %d out of range (%d not within 1–%d)%s\n" (set_color -o red) $n $n (count $DIRLIST) (set_color normal)
        return 1
    end

    echo $DIRLIST[$n]

    pushd $DIRLIST[$n]
    return $status
end
