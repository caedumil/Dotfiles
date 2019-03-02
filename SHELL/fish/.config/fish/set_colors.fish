# Colors:
# http://fishshell.com/docs/current/index.html#variables-color


# the default color
set fish_color_normal normal
# the color for commands
set fish_color_command white
# the color for regular command parameters
set fish_color_param blue
# the color for process separators like ';' and '&'
set fish_color_end brblack
# the color for quoted blocks of text
set fish_color_quote --bold white
# the color for IO redirections
set fish_color_redirection white
# the color used to highlight potential errors
set fish_color_error yellow
# the color used for code comments
set fish_color_comment brblack
# the color used for autosuggestions
set fish_color_autosuggestion brblack
# the color used when selecting text (in vi visual mode)
set fish_color_selection --background=brblack --bold white
# the color used to highlight matching parenthesis
set fish_color_match --background=blue
# the color used to highlight history search matches and selected pager item (must be a background)
set fish_color_search_match --background=brblack bryellow
# the color for parameter expansion operators like '*' and '~'
set fish_color_operator cyan
# the color used to highlight character escapes like '\n' and '\x70'
set fish_color_escape cyan


# Additionally, the following variables are available to change the
# highlighting in the completion pager:
# the color of the prefix string, i.e. the string that is to be completed
set fish_pager_color_prefix --underline --bold white
# the color of the completion itself
set fish_pager_color_completion normal
# the color of the completion description
set fish_pager_color_description blue
# the color of the progress bar at the bottom left corner
set fish_pager_color_progress --reverse
# the background color of the every second completion
set fish_pager_color_secondary normal
