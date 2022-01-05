# ~/.config/fish/functions/fish_user_key_bindings.fish

function fish_user_key_bindings
  # Enables VI mode
  fish_vi_key_bindings
  # Remap jk to <esc> in Normal mode
  bind -M insert -m default jk backward-char force-repaint
  # Tab accept autosuggestion in insert mode
  bind -M insert \t accept-autosuggestion
  # Ctrl + space: show completions in insert mode
  bind -M insert -k nul complete-and-search
end
