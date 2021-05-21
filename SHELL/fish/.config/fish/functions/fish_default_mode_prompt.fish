function fish_default_mode_prompt --description "Display the default mode for the prompt"
    if test "$fish_key_bindings" = "fish_vi_key_bindings" -o "$fish_key_bindings" = "fish_hybrid_key_bindings"
        switch $fish_bind_mode
            case insert
                true
            case default
                set_color --background red white
                echo -n '[N]'
            case replace_one
                set_color --background green white
                echo -n '[R]'
            case replace
                set_color --background cyan white
                echo -n '[R]'
            case visual
                set_color --background magenta white
                echo -n '[V]'
        end
    else
        set_color --bold --background green white
        echo -n '[E]'
    end
    set_color normal
    echo -n ' '
end
