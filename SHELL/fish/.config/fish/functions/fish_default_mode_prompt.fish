function fish_default_mode_prompt --description "Display the default mode for the prompt"
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
        switch $fish_bind_mode
            case insert
                true
            case default
                set_color --bold --background red white
                echo -n '[N]'
            case replace_one
                set_color --bold --background green white
                echo -n '[R]'
            case replace
                set_color --bold --background cyan white
                echo -n '[R]'
            case visual
                set_color --bold --background magenta white
                echo -n '[V]'
        end
    else
        set_color --bold --background green white
        echo -n '[E]'
    end
    set_color normal
    echo -n ' '
end
