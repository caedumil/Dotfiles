#
# Zsh environment
#

# This file will be read if $ZDOTDIR is not defined.
# So it will be used to define $ZDOTDIR.
if [[ -z ${ZDOTDIR} ]]; then
    export ZDOTDIR="${HOME}/.zdotdir"
fi
