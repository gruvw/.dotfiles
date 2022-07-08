# ~/.config/fish/config.fish

source ~/.config/fish/exports.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    # Disables welcome message
    set fish_greeting
    # Colors
    set fish_color_normal white  # the default color
    set fish_color_command white  # the color for commands
    set fish_color_quote yellow  # the color for quoted blocks of text
    set fish_color_redirection magenta  # the color for IO redirections (>)
    set fish_color_end green  # the color for process separators like ';' and '&'
    set fish_color_autosuggestion white --dim  # the color for auto suggestion
    set fish_color_error red --underline  # the color used to highlight potential errors
    set fish_color_param blue  # the color for regular command parameters
    set fish_color_comment white --dim  # the color used for code comments
    set fish_color_escape magenta  # the color used to highlight character escapes like '\n'
    set fish_color_operator green  # the color for parameter expansion operators like '*'
    set fish_pager_color_completion white  # the color of the completion itself
    set fish_pager_color_prefix green --bold  # the color of the prefix string, i.e. the string that is to be completed
    set fish_pager_color_description yellow --italics  # the color of the completion description
    set fish_pager_color_progress cyan --underline  # the color of the indicator at the bottom left corner
    # Set the cursor shapes for the different vi modes.
    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_visual block
    # Loads starship prompt
    starship init fish | source
end
