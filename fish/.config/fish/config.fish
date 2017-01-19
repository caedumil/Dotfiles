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
test -f /etc/arch-release; and set -x AURDEST $HOME/Build


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

#
# Fish colors
#
#set fish_color_normal normal                        # the default color
#set fish_color_command blue                         # commands
#set fish_color_quote E6DB74                         # quoted blocks of text
#set fish_color_redirection AE81FF                   # IO redirections
#set fish_color_end F8F8F2                           # process separators like ';' and '&'
#set fish_color_error F8F8F2 --background=F92672     # highlight potential errors
#set fish_color_param A6E22E                         # regular command parameters
#set fish_color_comment 75715E                       # code comments
#set fish_color_match F8F8F2                         # highlight matching parenthesis
#set fish_color_search_match --background=49483E     # highlight history search matches
#set fish_color_operator AE81FF                      # parameter expansion operators like '*' and '~'
#set fish_color_escape 66D9EF                        # highlight character escapes like '\n' and '\x70'
#set fish_color_cwd 66D9EF                           # the current working directory in the default prompt
#
## Additionally, the following variables are available to change the
## highlighting in the completion pager:
#set fish_pager_color_prefix F8F8F2                  # prefix string, i.e. the string that is to be completed
#set fish_pager_color_completion 75715E              # completion itself
#set fish_pager_color_description 49483E             # completion description
#set fish_pager_color_progress F8F8F2                # progress bar at the bottom left corner
#set fish_pager_color_secondary F8F8F2               # background color of the every second completion
