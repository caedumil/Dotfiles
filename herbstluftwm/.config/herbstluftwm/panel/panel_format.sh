#!/usr/bin/env bash

draw_tags() {
    local tag_info=""

    IFS=$'\t' read -ra tags <<< "$(herbstclient tag_status)"
    for i in "${tags[@]}"; do
        case "${i:0:1}" in
            "#") # focused tag, focused monitor
                icon="%{+o} \uE190 %{-o}"
                fg="#FF$(getXresColor.sh foreground)"
                bg="-"
                ul="${fg}"
                ;;
            ":") # occupied tag
                icon=" \uE190 "
                fg="#FF$(getXresColor.sh foreground)"
                bg="-"
                ul="-"
                ;;
            ".") # free tag
                icon=" \uE190 "
                fg="#FF$(getXresColor.sh brightblack)"
                bg="-"
                ul="-"
                ;;
            "!") # urgent window
                icon=" \uE190 "
                fg="#FF$(getXresColor.sh red)"
                bg="-"
                ul="-"
                ;;
        esac
        tag_info+="%{B${bg}}%{F${fg}}%{U${ul}}${icon}%{U-}%{F-}%{B-}"
    done
    printf "%b" "${tag_info}"
}

wm="$(draw_tags)"
while read -r line; do
    case ${line} in
        C*) # clock
            clock="${line#?}"
            ;;
        S*) # system
            sys="${line#?}"
            ;;
        tag*) # wm stats
            wm="$(draw_tags)"
            ;;
        quit_panel|reload) # quit panel
            exit
            ;;
    esac

    printf "%b\n" "${l}${clock} %{c}${wm} %{r}${sys}"
done
