#
# ZSH options
#

# History settings
HISTSIZE=100
SAVEHIST=100
HISTFILE=${ZDOTDIR:-$HOME}/.zhistory

# Source Zim
if [[ -s ${ZDOTDIR:-$HOME}/.zim/init.zsh ]]; then
    source ${ZDOTDIR:-$HOME}/.zim/init.zsh
else
    source ${ZDOTDIR:-$HOME}/.zshrc.fallback
fi

# Silent shell
setopt nobeep

# Remove any RPROMPT from display when accepting a command.
setopt transient_rprompt

# Add custom path
fpath=( ${ZDOTDIR}/zthemes $fpath )

# Load custom prompt
autoload -Uz promptinit && promptinit
prompt caedus

#
# ZSH input
#

# Misbehaving keys
bindkey "\e[7~" beginning-of-line           # Home  # rxvt
bindkey "\e[8~" end-of-line                 # End   # rxvt
bindkey "\e[H"  beginning-of-line           # Home  # termite
bindkey "\e[F"  end-of-line                 # End   # termite

#
# ZSH aliases
#

# coreutils
alias mkdir='mkdir -pv'
alias rmdir='rmdir -pv'
alias mv='mv -v'
alias cp='cp -v'
alias ls='ls --group-directories-first --color=auto'
alias la='ls -lah'
alias l='ls -1'

# grep
alias egrep='grep -E'
alias fgrep='grep -F'

# atool
alias x='aunpack -e'

# feh
alias feh='feh --scale-down'

# transmission-remote-cli
alias trc='transmission-remote-cli'

# tmux
alias tmux='tmux -2'

# gpg-exec
if command -v gpg-exec >/dev/null 2>&1; then
    # openssh
    alias ssh='gpg-exec ssh'
    alias scp='gpg-exec scp'

    # rsync
    alias rsync='gpg-exec rsync'

    # git
    alias gf="gpg-exec git fetch"
    alias gfm="gpg-exec git pull"
    alias gp="gpg-exec git push"
fi

# Extension
alias -s gz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s pdf='zathura'

# Start tmux in remote shell
if command -v tmux >/dev/null && [[ -z ${TMUX} ]] && [[ -n ${SSH_TTY} ]]; then
    tmux start-server

    if ! tmux has-session 2> /dev/null; then
        tmux new-session -d -s ${HOST} \; \
        set-option -t ${HOST} destroy-unattached off &> /dev/null
    fi

    exec tmux attach-session
fi