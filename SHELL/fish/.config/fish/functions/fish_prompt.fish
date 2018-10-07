function fish_prompt
    # 'fish_mode_prompt' may prepend some information to the prompt.

    # Save last command status for later
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

    # Key bindinds mode.
    ## Set style for default/vi keybindings.
    set -l key_mode (set_color red)">"(set_color yellow)">"(set_color green)">"

    ## Check last status
    test $last_cmd != 0; and set key_mode (set_color red)">>>"

    ## Check different modes for vi keybings.
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
            case default
                set key_mode (set_color green)"<"(set_color yellow)"<"(set_color red)"<"
            case replace_one
                set key_mode (set_color yellow)"<<<"
            case visual
                set key_mode (set_color red)"<<<"
        end
    end
    echo -n $key_mode

    # User.
    test $USER = "root"; and echo -n (set_color red)"#"

    echo -n (set_color normal)" "
end
