function man
     set -x LESS_TERMCAP_mb (printf '\e[1m')
     set -x LESS_TERMCAP_md (printf '\e[01;36m')
     set -x LESS_TERMCAP_me (printf '\e[0m')
     set -x LESS_TERMCAP_so (printf '\e[01;30m')
     set -x LESS_TERMCAP_se (printf '\e[0m')
     set -x LESS_TERMCAP_us (printf '\e[04;36m')
     set -x LESS_TERMCAP_ue (printf '\e[0m')
     command man $argv
end
