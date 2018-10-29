function fish_title
  if type -q xdotool
    echo (xdotool get_desktop)#$USER@(hostname):(prompt_pwd)
  else
    echo $USER@(hostname):$PWD
  end
  if [ -n "$TMUX_PANE" ] 
    tmux_pane_title
  end
end

function tmux_pane_title
  printf "\033k"(hostname):(prompt_pwd)"\033\\"
end
