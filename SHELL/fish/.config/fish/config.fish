# Disable greeting
set fish_greeting ""

# Set vi style keybindings:
fish_vi_key_bindings

# Cursor shape
# values are 'block', 'line' or 'underscore'
if status is-interactive
    set -U fish_cursor_default line
    set -U fish_cursor_insert line
    set -U fish_cursor_visual line
end

# Add '~/.local/bin' to PATH:
fish_add_path $HOME/.local/bin

# SSH & GPG-agent
set -x SSH_AUTH_SOCK /run/user/(id -u $USER)/gnupg/S.gpg-agent.ssh

function _gpg-agent_env --on-event fish_preexec
    if pgrep gpg-agent >/dev/null
        set -x GPG_TTY (tty)
        gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
    end
end

# Pager
set -x PAGER less
set -x LESSHISTFILE -

# Editor
set -x EDITOR nvim
set -x VISUAL $EDITOR

# Git prompt settings
set __fish_git_prompt_showdirtystate 1
set __fish_git_prompt_showstashstate 1
set __fish_git_prompt_showuntrackedfiles 1
set __fish_git_prompt_showcolorhints 1
set __fish_git_prompt_showupstream informative
set __fish_git_prompt_describe_style branch

set __fish_git_prompt_char_stateseparator "|"
set __fish_git_prompt_char_stagedstate "+"
set __fish_git_prompt_char_dirtystate "*"
set __fish_git_prompt_char_untrackedfiles "%"
set __fish_git_prompt_char_stashstate "!"
set __fish_git_prompt_char_upstream_equal "="
set __fish_git_prompt_char_upstream_ahead ">"
set __fish_git_prompt_char_upstream_behind "<"
set __fish_git_prompt_char_upstream_diverged "<>"
