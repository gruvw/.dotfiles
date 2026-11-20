# ~/.config/fish/functions/fish_user_key_bindings.fish

function fish_user_key_bindings
  # Enables VI mode
  fish_vi_key_bindings

  # Remap jk to <esc> in Normal mode
  # bind -M insert -m default j,k backward-char repaint-mode
  # Tab accept autosuggestion in insert mode
  bind -M insert tab accept-autosuggestion
  # Ctrl + space: show completions in insert mode
  bind -M insert ctrl-space complete-and-search
end
