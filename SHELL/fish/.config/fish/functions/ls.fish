#
# Make GNU ls use colors if we are on a system that supports that feature and writing to stdout.
#
function ls --description "List contents of directory"
    set -l param --group-directories-first --color=auto
    if isatty 1
        set -a param --indicator-style=classify
    end
    command ls $param $argv
end

if not set -q LS_COLORS
    set -l dircolors
    for d in gdircolors dircolors
        if command -sq $d
            set dircolors $d
            break
        end
    end

    if set -q dircolors[1]
        set -l colorfile
        for file in ~/.dir_colors ~/.dircolors /etc/DIR_COLORS
            if test -f $file
                set colorfile $file
                break
            end
        end
        # Here we rely on the legacy behavior of `dircolors -c` producing output suitable for
        # csh in order to extract just the data we're interested in.
        set -gx LS_COLORS ($dircolors -c $colorfile | string split ' ')[3]
        # The value should always be quoted but be conservative and check first.
        if string match -qr '^([\'"]).*\1$' -- $LS_COLORS
            set LS_COLORS (string match -r '^.(.*).$' $LS_COLORS)[2]
        end
    end
end
