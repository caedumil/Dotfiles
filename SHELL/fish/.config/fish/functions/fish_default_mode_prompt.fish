function fish_default_mode_prompt --description "Display the default mode for the prompt"
    if test "$fish_key_bindings" = "fish_vi_key_bindings" -o "$fish_key_bindings" = "fish_hybrid_key_bindings"
        switch $fish_bind_mode
            case insert
                echo 'magenta'
            case default
                echo 'blue'
            case replace_one
                echo 'green'
            case replace
                echo 'green'
            case visual
                echo 'cyan'
        end
    else
        normal
    end
end
