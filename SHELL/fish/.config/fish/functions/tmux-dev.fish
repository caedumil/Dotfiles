function tmux-dev --description "Start tmux session at specified directory"
    set -l dir (realpath $argv)
    if test ! \( -d $dir -a -e $dir \)
        return 1
    end
    tmux new-session -A -c $dir -s (basename $dir)
end
