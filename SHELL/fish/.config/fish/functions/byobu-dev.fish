function byobu-dev --description "Start byobu session at specified directory"
    set -l dir (realpath $argv)
    if test ! -d $dir
        return 1
    end
    byobu-tmux new-session -A -c $dir -s (basename $dir)
end
