function tmux-dev --description "Start tmux session at specified directory"
    if test ! \( -d $argv -a -e $argv \)
        return 1
    end
    tmux new-session -A -c $argv -s (basename $argv)
end
