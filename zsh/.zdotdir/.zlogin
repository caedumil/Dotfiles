#
# Sourced in login shell
#

(

    for z in ${ZDOTDIR:-${HOME}}/.{zshrc,zcompdump}; do
        if [[ -s ${z} && ( ! -s ${z}.zwc || ${z} -nt ${z}.zwc ) ]]; then
            zcompile ${z}
        fi
    done

) &!
