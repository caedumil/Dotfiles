#
# ZSH options
#

#
# Custom path
#
fpath=( ${ZDOTDIR}/zthemes $fpath )

#
# Prompt
#
setopt TRANSIENT_RPROMPT

autoload -Uz promptinit && promptinit
prompt caedus

#
# History
#
HISTFILE=${ZDOTDIR:-${HOME}}/.zhistory
HISTSIZE=100
SAVEHIST=100

setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

#
# Globbing and FDs
#
setopt EXTENDED_GLOB
setopt MULTIOS
setopt CLOBBER

#
# Directory
#
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME

#
# Environment
#
setopt AUTO_RESUME
setopt LONG_LIST_JOBS
setopt NOTIFY
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_CHECK_JOBS

# ls colors
if [[ -s ${ZDOTDIR:-${HOME}}/.dircolors ]]; then
    source <(dircolors --sh ${ZDOTDIR:-${HOME}}/.dircolors)
else
    source <(dircolors --sh)
fi

#
# Completion
#
autoload -Uz compinit && compinit -C -d ${ZDOTDIR:-${HOME}}/.zcompdump

setopt HASH_LIST_ALL
setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt AUTO_LIST
setopt PATH_DIRS
setopt NO_CASE_GLOB
setopt NO_MENU_COMPLETE

# group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# directories
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'expand'
zstyle ':completion:*' squeeze-slashes true

# enable caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-${HOME}}/.zcompcache"

# ignore useless commands and functions
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'

# completion sorting
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# history
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# smart editor completion
zstyle ':completion:*:(nano|vim|nvim|vi|emacs|e):*' ignored-patterns '*.(wav|mp3|flac|ogg|mp4|avi|mkv|webm|iso|dmg|so|o|a|bin|exe|dll|pcap|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|mobi|epub|png|jpeg|jpg|gif)'

#
# Input
#
zmodload zsh/terminfo
typeset -gA key_info
key_info=(
  'Control'      '\C-'
  'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd \eOD'
  'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc \eOC'
  'Escape'       '\e'
  'Meta'         '\M-'
  'Backspace'    "^?"
  'Delete'       "^[[3~"
  'F1'           "${terminfo[kf1]}"
  'F2'           "${terminfo[kf2]}"
  'F3'           "${terminfo[kf3]}"
  'F4'           "${terminfo[kf4]}"
  'F5'           "${terminfo[kf5]}"
  'F6'           "${terminfo[kf6]}"
  'F7'           "${terminfo[kf7]}"
  'F8'           "${terminfo[kf8]}"
  'F9'           "${terminfo[kf9]}"
  'F10'          "${terminfo[kf10]}"
  'F11'          "${terminfo[kf11]}"
  'F12'          "${terminfo[kf12]}"
  'Insert'       "${terminfo[kich1]}"
  'Home'         "${terminfo[khome]}"
  'PageUp'       "${terminfo[kpp]}"
  'End'          "${terminfo[kend]}"
  'PageDown'     "${terminfo[knp]}"
  'Up'           "${terminfo[kcuu1]}"
  'Left'         "${terminfo[kcub1]}"
  'Down'         "${terminfo[kcud1]}"
  'Right'        "${terminfo[kcuf1]}"
  'BackTab'      "${terminfo[kcbt]}"
)

local key
for key in "${(s: :)key_info[ControlLeft]}"; do
    bindkey ${key} backward-word
done
for key in "${(s: :)key_info[ControlRight]}"; do
    bindkey ${key} forward-word
done

if [[ -n "${key_info[Home]}" ]]; then
    bindkey "${key_info[Home]}" beginning-of-line
fi

if [[ -n "${key_info[PageUp]}" ]]; then
    bindkey "${key_info[PageUp]}" beginning-of-history
fi

if [[ -n "${key_info[PageDown]}" ]]; then
    bindkey "${key_info[PageDown]}" end-of-history
fi

if [[ -n "${key_info[End]}" ]]; then
    bindkey "${key_info[End]}" end-of-line
fi

if [[ -n "${key_info[Insert]}" ]]; then
    bindkey "${key_info[Insert]}" overwrite-mode
fi

bindkey "${key_info[Delete]}" delete-char
bindkey "${key_info[Backspace]}" backward-delete-char

bindkey "${key_info[Left]}" backward-char
bindkey "${key_info[Right]}" forward-char

bindkey "${key_info[Up]}" up-line-or-beginning-search
bindkey "${key_info[Down]}" down-line-or-beginning-search

# Expandpace
bindkey ' ' magic-space

# Clear
bindkey "${key_info[Control]}L" clear-screen

# Bind Shift + Tab to go to the previous menu item.
if [[ -n "${key_info[BackTab]}" ]]; then
    bindkey "${key_info[BackTab]}" reverse-menu-complete
fi

# Put into application mode and validate ${terminfo}
zle-line-init() {
    if (( ${+terminfo[smkx]} )); then
        echoti smkx
    fi
}
zle-line-finish() {
    if (( ${+terminfo[rmkx]} )); then
        echoti rmkx
    fi
}
zle -N zle-line-init
zle -N zle-line-finish

#
# Utility
#
setopt NOBEEP
setopt CORRECT

# coreutils
alias chmod='chmod --preserve-root -v'
alias chown='chown --preserve-root -v'
alias cp='cp -v'
alias df='df -kh'
alias du='du -kh'
alias ls='ls --group-directories-first --color=auto'
alias la='ls -lah'
alias ll='ls -lh'
alias l='ls -1'
alias mkdir='mkdir -pv'
alias mv='mv -v'
alias rmdir='rmdir -pv'

# grep
alias grep='grep --color=auto'
alias egrep='grep -E'
alias fgrep='grep -F'

# atool
alias axe='aunpack -e'

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

#
# Tmux
#
if command -v tmux >/dev/null && [[ -z ${TMUX} ]] && [[ -n ${SSH_TTY} ]]; then
    tmux start-server

    if ! tmux has-session 2> /dev/null; then
        tmux new-session -d -s ${HOST} \; \
        set-option -t ${HOST} destroy-unattached off &> /dev/null
    fi

    exec tmux attach-session
fi
