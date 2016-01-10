#
# Zsh environment
#

# This file will be read if $ZDOTDIR is not defined.
# So it will be used to define $ZDOTDIR and others variables.
if [[ -e ${HOME}/.env ]]; then
    source ${HOME}/.env
fi
