#
# ZSH options
#

# History settings
HISTSIZE=100
SAVEHIST=100
HISTFILE=~/.zhistfile

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source shell colors
local xbase16="/usr/share/base16-shell/base16-ocean.dark.sh"
[[ -s ${xbase16} ]] && source ${xbase16}

# Source .profile if needed
[[ -n ${EDITOR} ]] || source ~/.profile

# Set pager
export PAGER='less'
export LESSHISTFILE='-'

#
# ZSH aliases
#

# coreutils
alias mkdir='mkdir -pv'
alias rmdir='rmdir -pv'
alias mv='mv -v'
alias cp='cp -v'
alias l='ls -1'

# grep
alias egrep='grep -E'
alias fgrep='grep -F'

# atool
alias x='aunpack -e'

# mpv
alias mpv='mpv --quiet'

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

# Clear prezto aliases
unalias rm

# Extension
alias -s gz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s pdf='zathura'

#
# Zsh functions
#

#
# Terminal fixes
#

# Misbehaving keys
bindkey "\e[7~" beginning-of-line           # Home  # rxvt
bindkey "\e[8~" end-of-line                 # End   # rxvt
bindkey "\e[H"  beginning-of-line           # Home  # termite
bindkey "\e[F"  end-of-line                 # End   # termite
