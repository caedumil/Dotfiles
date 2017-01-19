function fish_user_key_bindings
    bind --mode insert --key npage      ''
    bind --mode insert --key ppage      ''
    bind --mode insert --key home       beginning-of-line
    bind --mode insert --key end        end-of-line
    bind --mode insert --key backspace  backward-delete-char
    bind --mode insert --key dc         delete-char
end
