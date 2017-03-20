#
# Zsh environment
#

# This file will be read if $ZDOTDIR is not defined.
# So it will be used to define $ZDOTDIR.
if [[ -z ${ZDOTDIR} ]]; then
    export ZDOTDIR="${HOME}/.zdotdir"
fi

# SSH & GPG agent
export SSH_AUTH_SOCK="/run/user/${UID}/gnupg/S.gpg-agent.ssh"

# Pager
export PAGER="less"
export LESSHISTFILE="-"

# Editor
export EDITOR="vim"
export VISUAL="${EDITOR}"

# Pacaur
if [[ -f /etc/arch-release ]]; then
    export AURDEST="${HOME}/Dev/Build/AUR"
    export ASPROOT="${HOME}/Dev/Build/ABS"
fi
