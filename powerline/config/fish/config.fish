set JAVA_HOME (/usr/libexec/java_home -v 1.8)
set JRE_HOME $JAVA_HOME

set PATH $HOME/.rvm/bin /usr/local/bin $PATH

# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

set -g fish_color_user magenta
set -g fish_color_host yellow
set -g fish_prompt_git_status_git_dir '⚒'  
set -g fish_prompt_git_remote_space ' '

. $HOME/.config/fish/informative_git_prompt.fish

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  # User
  set_color $fish_color_user
  echo -n (whoami)
  set_color normal

  echo -n '@'

  # Host
  set_color $fish_color_host
  echo -n (hostname -s)
  set_color normal

  echo -n ':'

  # PWD
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal

  printf '%s ' (__informative_git_prompt)

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  echo -n '$ '
  
  set_color $fish_color_normal

end

function fish_right_prompt -d "Write out the right prompt"

  # Time
  set_color -o black
  echo (date +%R)
  set_color $fish_color_normal

end
