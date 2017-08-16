#
# ZSH options
#

# Prompt {{{
setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT

autoload -Uz colors && colors
autoload -Uz vcs_info

# vcs_info {{{
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' get-revision true
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{2}*%f"               # green
zstyle ':vcs_info:git:*' unstagedstr "%F{3}*%f"             # yellow
zstyle ':vcs_info:git:*' patch-format "%n/%c"
zstyle ':vcs_info:git:*' formats "%F{3}%b%f|%c%u:"
zstyle ':vcs_info:git:*' actionformats "%F{3}%b%f|%c%u|%a %m:"

zstyle ':vcs_info:git*+set-message:*' hooks git-branch git-stash git-dirty
zstyle ':vcs_info:git:*:-all-' command =git

+vi-git-branch() {
    local ahead behind
    local -a gitstatus

    ahead=$(git rev-list --count ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null)
    (( $ahead )) && gitstatus+=( "%F{2}#${ahead}%f" )       # green

    behind=$(git rev-list --count HEAD..${hook_com[branch]}@{upstream} 2>/dev/null)
    (( $behind )) && gitstatus+=( "%F{1}#${behind}%f" )     # red

    hook_com[branch]+="${(j::)gitstatus}"
}

+vi-git-dirty() {
    local -i untracked

    untracked=$(git status --porcelain --untracked-files --ignore-submodules | grep '^??' | wc -l)
    (( $untracked )) && hook_com[unstaged]+="%F{1}*%f"      # red
}

+vi-git-stash() {
    if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
        hook_com[unstaged]+="%F{4}*%f"                      # blue
    fi
}
# }}}

# setprompt() {{{
setprompt() {
    local -a info
    local dir_color cwd git_info arrows

    # Remote connection - red@yellow
    [[ -n ${SSH_TTY} ]] && info+=( "%F{1}%n%f@%F{3}%m%f" )

    # Current dir - cyan if writable, yellow if not writable
    [[ -w ${PWD} ]] && dir_color="%F{6}" || dir_color="%F{3}"
    cwd="${PWD/#${HOME}/~}"
    # if we aren't in ~
    if [[ ${cwd} != '~' ]]; then
        head="${${${${(@j:/:M)${(@s:/:)cwd}##.#?}:h}%/}//\%/%%}"
        tail="$(cut -c -20 <<< ${${cwd:t}//\%/%%} | sed -r 's/[[:space:]]$//')"
        cwd="${head}/${tail}"
    fi
    info+=( "${dir_color}${cwd}%f" )

    # Git information - bright black
    if [[ -n ${vcs_info_msg_0_} ]]; then
        git_info="$(sed -r 's/[| ]://;s/://' <<< ${vcs_info_msg_0_})"
        info+=( "[${git_info}]" )
    fi

    # Python virtualenv - magenta
    [[ -n ${VIRTUAL_ENV} ]] && info+=( "[%F{5}${VIRTUAL_ENV:t}%f]" )

    # Last command status
    if (( ${RETVAL} )); then
        # fail - red / red
        d_arrows="%F{1}>>>%f"
        v_arrows="%F{1}<<<%f"
    else
        # success - red,yellow,green / green,yellow,red
        d_arrows="%F{1}>%f%F{3}>%f%F{2}>%f"
        v_arrows="%F{2}<%f%F{3}<%f%F{1}<%f"
    fi

    # Key bindings mode
    [[ ${KEYMAP} == "vicmd" ]] && arrows="${v_arrows}" || arrows="${d_arrows}"
    info+=( "${arrows}" )

    # User
    [[ ${USER} == "root" ]] && info+=( "%F{1}#%f" )

    # Set the prompt
    PROMPT=" ${(j: :)info} "
    RPROMPT=''
    SPROMPT='zsh: correct %F{1}%R%f to %F{2}%r%f [nyae]?'
}
# }}}

zle-keymap-select() {
    # update prompt for new keymap
    setprompt
    zle reset-prompt
}
zle -N zle-keymap-select

precmd() {
    # get last command exit status
    RETVAL="${?}"

    # get git info
    vcs_info

    # format info for prompt
    setprompt
}

# Update $GPG_TTY before executing a command
preexec() {
    # update tty info on gpg-agent
    if pgrep gpg-agent >/dev/null; then
        export GPG_TTY="${TTY}"
        gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
    fi
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

# 256 colors workaround for Base16
base="${ZDOTDIR:-${HOME}}/.base16-colors.sh"
if [[ -x ${base} ]]; then
    eval ${base}
fi

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
    bindkey "${key_info[PageUp]}" up-line-or-history
fi

if [[ -n "${key_info[PageDown]}" ]]; then
    bindkey "${key_info[PageDown]}" down-line-or-history
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
alias df='df -h'
alias du='du -h'
alias ln='ln -v'
alias ls='ls --group-directories-first --color=auto'
alias la='ls -alh'
alias ll='ls -lh'
alias mkdir='mkdir -pv'
alias mv='mv -v'
alias rmdir='rmdir -pv'

# grep
alias grep='grep --color=auto'
alias egrep='grep -E'
alias fgrep='grep -F'

# misc
alias aup='aunpack -e'
alias feh='feh --scale-down'
alias tmux='tmux -2'
alias trc='transmission-remote-cli'
# }}}

# Colorized man pages {{{
function man() {
    # Modes:
    # mb = begin blinking
    # md = begin bold
    # me = end mode
    # so = begin standout-mode
    # se = end standout-mode
    # us = begin underline
    # ue = end underline

    LESS_TERMCAP_mb=$'\e[1m'     \
    LESS_TERMCAP_md=$'\e[01;36m' \
    LESS_TERMCAP_me=$'\e[0m'     \
    LESS_TERMCAP_so=$'\e[01;30m' \
    LESS_TERMCAP_se=$'\e[0m'     \
    LESS_TERMCAP_us=$'\e[04;36m' \
    LESS_TERMCAP_ue=$'\e[0m'     \
    command man "$@"
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
