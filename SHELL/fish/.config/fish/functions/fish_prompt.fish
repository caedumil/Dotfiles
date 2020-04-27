function fish_prompt --description "Write out the prompt"
    # Save last command status for later.
    set -l last_cmd $status

    # Remote connection.
    if test $SSH_TTY
        set -l r_user (set_color red)(whoami)
        set -l r_host (set_color yellow)(hostname)
        echo -n $r_user(set_color white)"@"$r_host" "
    end

    # Current dir.
    test -w (pwd); and set -l color cyan; or set -l color yellow
    echo -n (set_color $color)(prompt_pwd)" "

    # Git information.
    echo -n (set_color normal)(__fish_git_prompt "[%s]")" "

    # Virtualenv information
    set -g VIRTUAL_ENV_DISABLE_PROMPT 1
    if test -n "$VIRTUAL_ENV"
        echo -n (set_color normal)"["
        echo -n (set_color magenta)(basename "$VIRTUAL_ENV")
        echo -n (set_color normal)"] "
    end

    # Prompt fixed body.
    if test "$last_cmd" -eq 0
        # Colored if previous command exit successfully.
        echo -n (set_color red)">"(set_color yellow)">"(set_color green)">"
    else
        # Red if failed.
        echo -n (set_color red)">>>"
    end

    # User.
    test $USER = "root"; and echo -n (set_color red)" #"

    echo -n (set_color normal)" "
end
