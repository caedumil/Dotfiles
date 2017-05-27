# The fish_mode_prompt function is prepended to the prompt
function fish_mode_prompt --description "Displays the current mode"
    # Do nothing if not in default mode
    if test "$fish_key_bindings" = "fish_default_key_bindings"
        set_color --bold --background green white
        echo '[E]'
    end
    set_color normal
    echo -n ' '
end
