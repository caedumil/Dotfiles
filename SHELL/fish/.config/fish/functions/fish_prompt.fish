function __prompt_usr --description "Output user/host information"
    test -n "$SSH_CONNECTION" ; and set -l hst yellow ; or set -l hst blue
    test "$USER" = "root" ; and set -l usr red ; or set -l usr cyan

    set_color $usr
    echo -n "$USER"
    set_color normal
    echo -n "@"
    set_color $hst
    echo -n (prompt_hostname)
    set_color normal
end

function __prompt_pwd --description "Output current directory information"
    test -w (pwd) ; and set -l color blue ; or set -l color yellow

    set_color $color
    echo -n (prompt_pwd)
    set_color normal
end

function __prompt_venv --description "Output Virtualenv information"
    test -n "$VIRTUAL_ENV" ; or return

    set_color normal
    echo -n (basename "$VIRTUAL_ENV")
end

function fish_prompt --description "Write out the prompt"
    # Disable python's virtualenv default prompt
    set -g VIRTUAL_ENV_DISABLE_PROMPT 1

    # Save some information for later
    set -l _cmd $status
    set -l _git (fish_git_prompt "%s")
    set -l _venv (__prompt_venv)

    # Print prompt
    set_color magenta
    echo -n "┌─"

    echo -n "─("
    __prompt_usr
    set_color magenta
    echo -n ")"

    echo -n "─["
    __prompt_pwd
    set_color magenta
    echo -n "]"

    if test -n "$_git"
        echo -n "─["
        echo -n "$_git"
        set_color magenta
        echo -n "]"
    end

    set_color normal
    echo ""

    set_color magenta
    echo -n "└─"

    if test -n "$_venv"
        echo -n "─<"
        echo -n "$_venv"
        set_color magenta
        echo -n ">"
    end

    if test "$_cmd" -ne 0
        set_color red
        echo -n " !"
    else
        echo -n  " >"
    end

    set_color normal
    fish_default_mode_prompt
end
