########## ZSHRC
##### Configuration file for ZSH
HISTSIZE=100
SAVEHIST=100
HISTFILE=~/.zhistfile

##### Options
### Basics
setopt nobeep
### Changing Directories
setopt auto_cd
setopt pushd_ignore_dups
### Expansion and Globing
setopt extended_glob
setopt nomatch
### History
setopt append_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
### Completion
setopt always_to_end
setopt auto_menu
setopt complete_aliases
setopt complete_in_word
unsetopt menu_complete
### Correction
setopt correct
### Prompt
setopt prompt_subst
setopt transient_rprompt

##### Enable colors
autoload -U colors
colors

##### Highlight
local xbase16="/usr/share/base16-shell/base16-chalk.dark.sh"
local vbase16="${HOME}/.vbase16/base16-chalk.dark.sh"
[[ -s ${xbase16} ]] && source ${xbase16}
[[ $TERM == "linux" && -s ${vbase16} ]] && source ${vbase16}

##### cd-bookmark
autoload -Uz cd-bookmark
alias cdb='cd-bookmark'

##### Command completion
autoload -Uz compinit promptinit
compinit
promptinit
### rehash path
zstyle ':completion:*' rehash true
### cd style
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warning' '%BSorry, no matches for: %d%b'

##### Display
[[ $UID == 0 ]] && local pcolor="yellow" || local pcolor="magenta"
local sep="%F{${pcolor}}•%f"
### Git info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "%F{red} ⚡%f"
zstyle ':vcs_info:*' stagedstr "%F{green}→ %f"
zstyle ':vcs_info:git:*' formats "%b ${sep}%u %c${sep}"
zstyle ':vcs_info:git:*' actionformats "%b ${sep} %a ${sep}%u %c${sep}"
precmd() {
    vcs_info
}
### Prompt
PROMPT=' ${sep} %n ${sep} %m ${sep} %35<…<%2~%>> ${sep} ${vcs_info_msg_0_}
 ${sep} %F{${pcolor}}>>%f '

##### Bindkeys
bindkey -v                                  # vi mode
### Movement
bindkey "\e[C"  forward-char                # Right
bindkey "\e[D"  backward-char               # Left
bindkey "\e[1~" beginning-of-line           # Home
bindkey "\e[4~" end-of-line                 # End
bindkey "\e[c"  forward-word                # Shift+Right
bindkey "\e[d"  backward-word               # Shift+Left
bindkey "\e[7~" beginning-of-line           # Home  # rxvt
bindkey "\e[8~" end-of-line                 # End   # rxvt
bindkey "\eOH"  beginning-of-line           # Home  # guake
bindkey "\eOF"  end-of-line                 # End   # guake
bindkey "\e[H"  beginning-of-line           # Home  # termite
bindkey "\e[F"  end-of-line                 # End   # termite
### History Control
bindkey "\e[5~" beginning-of-history        # PageUp
bindkey "\e[6~" end-of-history              # PageDown
bindkey "\e[A"  history-search-backward     # Up
bindkey "\e[B"  history-search-forward      # Down
### Modifying Text
bindkey "\e[3~" delete-char                 # Del
bindkey "\e[3$" kill-whole-line             # Shift+Del
bindkey "\e[3~" delete-char                 # Del   # quake

##### Colored Pager
export PAGER='less'
export LESSHISTFILE='-'

##### Aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -l -h'
alias la='ls -a'
alias lla='ls -a -l -h'
alias grep='grep --color=auto'
alias egrep='grep -E'
alias fgrep='grep -F'
alias mkdir='mkdir -p -v'
alias mv='mv -v'
alias cp='cp -v'
alias ..='cd ..'
alias x='aunpack -e'
alias mpv='mpv --quiet'
alias feh='feh --scale-down'
alias trc='transmission-remote-cli'
### Extension
alias -s gz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s pdf='zathura'
alias -s {mp3,m4a}='mpv --no-audio-display'

##### Functions
dev () {
    local dir=$(pwd)

    [[ -d ${1} ]] && cd ${1}
    tmux a || tmux
    cd ${dir}
}

##########
