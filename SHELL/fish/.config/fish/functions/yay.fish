function yay
    set -l dir /opt/makepkg/gnupg
    if test -d $dir
        set -l GNUPGHOME $dir
    end
    command yay $argv
end

