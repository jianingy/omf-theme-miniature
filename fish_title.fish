function fish_title
  # Customize terminal window title
  hostname
  if [ -n "$TMUX_PANE" ] 
    tmux_pane_title
  end
end

function tmux_pane_title
  printf "\033k"(hostname)"\033\\"
end
