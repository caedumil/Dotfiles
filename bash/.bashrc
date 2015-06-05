#
# ~/.bashrc
#

### If not running interactively, don't do anything
[[ $- != *i* ]] && return

### PS1 -- red for root, blue for the first user, green for any other
#PS1='\[\e[1;31m\]┌─[\u@\h]\[\e[0m\]\[\e[1;36m\][\w]\[\e[0m\]\n\[\e[1;31m\]└───── [\$]\[\e[0m\] '
if [[ $UID = 0 ]]; then
    PS1=" \u@\h \[\e[1;36m\]>>\[\e[0m\] \w \[\e[1;36m\]>>\[\e[0m\] "
else
    PS1=" \u@\h \[\e[1;34m\]>>\[\e[0m\] \w \[\e[1;34m\]>>\[\e[0m\] "
fi

### Ignore double entries and commands prefixed by a ' '
HISTCONTROL=ignoreboth:erasedups

### Variables used later on
# some colors on man pages
if [[ -e $(which vimpager >/dev/null 2>&1) ]]; then
    export PAGER='vimpager'
elif [[ -e $(which most >/dev/null 2>&1) ]]; then
    export PAGER='most -s'
    export LESSHISTFILE='-'
else
    export PAGER='less'
    export LESSHISTFILE='-'
fi

# Default editor
export EDITOR=vim

### Colored output
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -a'
alias grep='grep --color=auto'
alias fgrep='grep -F'
alias egrep='grep -E'
alias ..='cd ..'

### Check EUID and set few aliases
if [[ ! $UID = 0 ]]; then
    alias shutdown='systemctl poweroff'
    alias reboot='systemctl reboot'
fi

### Source .bash_aliases file
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

##### FIM #####
