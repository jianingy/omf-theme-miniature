function fish_right_prompt
  set -l last_status $status
  set -l cyan (set_color -o cyan)
  set -l grey (set_color 777)
  set -l underline (set_color -u)
  set -l red (set_color -o red)
  set -l normal (set_color normal)

  if test -n "$SSH_CONNECTION"
    set host (hostname) ":"
  end

  echo -n -s $grey ' ← ' $host $underline (prompt_pwd) $normal

  if test $last_status -ne 0
    set_color red
    printf ' %d ' $last_status
    set_color normal
  end
end
