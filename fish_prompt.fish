function prompt_segment -d "Function to show a segment"
  # Get colors
  set -l bg $argv[1]
  set -l fg $argv[2]

  # Set 'em
  set_color -b $bg
  set_color $fg

  # Print text
  if [ -n "$argv[3]" ]
    echo -n -s $argv[3]
  end
end

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  set -l last_status $status
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l blue_underline (set_color -u -o blue)
  set -l magenta (set_color -o magenta)
  set -l green (set_color -o green)
  set -l normal (set_color normal)

  set -l cwd (if set -q SSH_CONNECTION
                  echo $blue_underline(basename (prompt_pwd))
              else
                  echo $blue(basename (prompt_pwd))
               end)

  # output the prompt, left to right

  # Add a newline before prompts
  echo -e ""

  # Display the current directory name
  echo -n -s "$cwd$normal"

  # Show git branch and dirty state
  if [ (_git_branch_name) ]
    set -l git_branch ':' (_git_branch_name)

    if [ (_is_git_dirty) ]
      set git_info $red " ✘" $git_branch
    else
      set git_info $green " ✔" $git_branch
    end
    echo -n -s $git_info $normal
  end

  # Display [venvname] if in a virtualenv
  if set -q VIRTUAL_ENV
      echo -n -s ' ' (set_color -b blue black) ' ' (basename "$VIRTUAL_ENV") ' ' $normal
  end

  if test $last_status -ne 0
    echo -n -s (set_color red) ' ‼' $normal
  end

  # Terminate with a nice prompt char
  set -l uid (id -u $USER)
  if [ $uid -eq 0 ]
    echo -n -s " "
    prompt_segment red white " ! "
    set_color normal
    echo -n -s " "
  else
    if set -q SSH_CONNECTION
      echo -n -s $yellow ' ➜  ' $normal
    else
      echo -n -s $magenta ' λ ' $normal
    end
  end

end
