#
# ZSH options
#

# Prompt {{{
setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT

autoload -Uz colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' get-revision true
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr "%F{3}●%f"
zstyle ':vcs_info:git:*' stagedstr "%F{2}●%f"
zstyle ':vcs_info:git:*' patch-format "(%n/%c)"
zstyle ':vcs_info:git:*' formats "[%.7i:%b] [%c%u] [%m]"
zstyle ':vcs_info:git:*' actionformats "[%a:%m] [%b] [%c%u]"

zstyle ':vcs_info:git*+set-message:*' hooks git-branch git-stash git-dirty
zstyle ':vcs_info:git:*:-all-' command =git

+vi-git-branch() {
    local ahead behind remote
    local -a gitstatus

    remote=$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)

    if grep "refs/remotes" <<< ${remote} >/dev/null 2>&1; then
        remote="${remote/refs\/remotes\/}"
    else
        remote="${remote/refs\/heads\/}"
    fi

    ahead=$(git rev-list --count ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null)
    (( $ahead )) && gitstatus+=( "%F{2}+${ahead}%f" )

    behind=$(git rev-list --count HEAD..${hook_com[branch]}@{upstream} 2>/dev/null)
    (( $behind )) && gitstatus+=( "%F{1}-${behind}%f" )

    hook_com[branch]+=" [${remote}] [${(j:/:)gitstatus}]"
}

+vi-git-stash() {
    local -a stashes

    if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
        stashes=$(git stash list 2>/dev/null | wc -l)
        hook_com[misc]+="${stashes} stashed"
    fi
}

+vi-git-dirty() {
    local -i untracked

    untracked=$(git status --porcelain -u | grep '^??' | wc -l)
    (( $untracked )) && hook_com[unstaged]+="%F{1}●%f"
}

setprompt() {
    local -a info cmd lines wd
    local sep

    sep="%F{6}::%f"

    # Top line
    # Prefix
    info+=( "${sep} " )

    # Current dir, yellow if not writable
    [[ -w ${PWD} ]] && info+=( "%F{4}" ) || info+=( "%F{3}" )
    for dir in "${(s:/:)${PWD/#$HOME/~}}"; do
        [[ ${#dir} -gt 10 ]] && dir="${dir:0:5}..."
        wd+="${dir}"
    done
    info+=( "${(j:/:)wd}%f" )

    # Git information
    if [[ -n ${vcs_info_msg_0_} ]]; then
        info+=( " ${sep} " )
        info+=( "%F{8}$(sed -r 's/ \[\]//g;s/(%f)([^%])/\1%F{8}\2/g' <<< ${vcs_info_msg_0_})%f" )
    fi

    # Suffix
    info+=( " ${sep}" )

    # Assemble line
    lines+=( ${(j::)info} )

    # Bottom line
    # Prefix
    cmd+=( " ${sep} " )

    # User & hostname
    cmd+=( "%(!.%F{1}.%F{4})%n%f" )
    [[ -n ${SSH_CLIENT} ]] && cmd+=( "%F{8}@%f%F{1}%m%f" )

    # Jobs runnings
    cmd+=( "%(1j. %F{3}%jj%f.)" )

    # Suffix and last command return status
    cmd+=( " %(?.${sep}.${sep/6/1}) " )

    # Assemble line
    lines+=( "${(j::)cmd}" )

    # Set the prompt
    PROMPT=${(F)lines}
    RPROMPT=''
    SPROMPT='zsh: correct %F{1}%R%f to %F{2}%r%f [nyae]?'
}

precmd() {
    vcs_info
    setprompt
}
# }}}

# History {{{
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
# }}}

# Globbing and FDs {{{
setopt EXTENDED_GLOB
setopt MULTIOS
setopt CLOBBER
# }}}

# Directory {{{
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
# }}}

# Environment {{{
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
# }}}

# Completion {{{
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
# }}}

# Input {{{
zmodload zsh/terminfo
typeset -gA key_info
key_info=(
  'Control'      '\C-'
  'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd \eOD'
  'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc \eOC'
  'Escape'       '\e'
  'Meta'         '\M-'
  'Backspace'    "${terminfo[kbs]}"
  'Delete'       "${terminfo[kdch1]}"
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

# Double-dot parent directory expansion
double-dot-expand() {
    if [[ ${LBUFFER} == *.. ]]; then
        LBUFFER+='/..'
    else
        LBUFFER+='.'
    fi
}
zle -N double-dot-expand
bindkey '.' double-dot-expand

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
# }}}

# Utility {{{
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
if command -v tmux >/dev/null 2>&1; then
    alias tmux='tmux -2'
fi

# envoy-exec
if command -v envoy-exec >/dev/null 2>&1; then
    # openssh
    alias ssh='envoy-exec ssh'
    alias scp='envoy-exec scp'

    # rsync
    alias rsync='envoy-exec rsync'

    # git
    alias gf="envoy-exec git fetch"
    alias gfm="envoy-exec git pull"
    alias gp="envoy-exec git push"
fi
# }}}

# Color man pages {{{
function man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}
# }}}

# Tmux {{{
if command -v tmux >/dev/null && [[ -z ${TMUX} ]] && [[ -n ${SSH_TTY} ]]; then
    tmux start-server

    if ! tmux has-session 2> /dev/null; then
        tmux new-session -d -s ${HOST} \; \
        set-option -t ${HOST} destroy-unattached off &> /dev/null
    fi

    exec tmux attach-session
fi
# }}}

# vim:foldmethod=marker:foldlevel=0
