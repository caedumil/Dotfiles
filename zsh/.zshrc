########## ZSHRC
##### Configuration file for ZSH
HISTSIZE=100
SAVEHIST=100
HISTFILE=~/.zhistfile

##### Highlight
local xbase16="/usr/share/base16-shell/base16-ocean.dark.sh"
[[ -s ${xbase16} ]] && source ${xbase16}

##### cd-bookmark
autoload -Uz cd-bookmark
alias cdb='cd-bookmark'

### Movement
bindkey "\e[7~" beginning-of-line           # Home  # rxvt
bindkey "\e[8~" end-of-line                 # End   # rxvt
bindkey "\eOH"  beginning-of-line           # Home  # guake
bindkey "\eOF"  end-of-line                 # End   # guake
bindkey "\e[H"  beginning-of-line           # Home  # termite
bindkey "\e[F"  end-of-line                 # End   # termite

##### Colored Pager
export PAGER='less'
export LESSHISTFILE='-'

##### Aliases
alias egrep='grep -E'
alias fgrep='grep -F'
alias mkdir='mkdir -pv'
alias rmdir='rmdir -pv'
alias mv='mv -v'
alias cp='cp -v'
alias x='aunpack -e'
alias mpv='mpv --quiet'
alias feh='feh --scale-down'
alias trc='transmission-remote-cli'
alias tmux='tmux -2'
alias tintin='tintin -G'
alias tt='tintin'
### Clear aliases
unalias rm
### Extension
alias -s gz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s pdf='zathura'
alias -s {mp3,m4a}='mpv --no-audio-display'

##### Functions
dev () {
    local dir=$(pwd)

    [[ -d ${1} ]] && cd ${1}
    if tmux has-session >/dev/null 2>&1 ; then
        tmux attach-session >/dev/null 2>&1
    else
        tmux >/dev/null 2>&1
    fi
    cd ${dir}
}

##########
