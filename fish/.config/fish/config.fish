#
# Fish Environment
#

# SSH & GPG-agent
set -x SSH_AUTH_SOCK /run/user/(id -u $USER)/gnupg/S.gpg-agent.ssh

function _gpg-agent_env --on-event fish_preexec
    if pgrep gpg-agent >/dev/null
        set -x GPG_TTY (tty)
        gpg-connect-agent updatestartuptty /bye >/dev/null ^&1
    end
end

# Pager
set -x PAGER less
set -x LESSHISTFILE -

# Editor
set -x EDITOR vim
set -x VISUAL $EDITOR

# Pacaur
test -f /etc/arch-release; and set -x AURDEST $HOME/Build/AUR


#
# Fish git prompt
#

# Settings
set __fish_git_prompt_showdirtystate yes
set __fish_git_prompt_showstashstate yes
set __fish_git_prompt_showuntrackedfiles yes
set __fish_git_prompt_showupstream informative
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status chars
set __fish_git_prompt_char_stateseparator "|"
set __fish_git_prompt_char_stagedstate (set_color green)"●"(set_color normal)
set __fish_git_prompt_char_dirtystate (set_color yellow)"●"(set_color normal)
set __fish_git_prompt_char_untrackedfiles (set_color red)"●"(set_color normal)
set __fish_git_prompt_char_stashstate (set_color blue)"●"(set_color normal)
set __fish_git_prompt_char_upstream_ahead (set_color green)"↑"(set_color normal)
set __fish_git_prompt_char_upstream_behind (set_color red)"↓"(set_color normal)
