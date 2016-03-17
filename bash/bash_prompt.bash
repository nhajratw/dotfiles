#      BASE03=$(tput setaf 8)
#      BASE02=$(tput setaf 0)
#      BASE01=$(tput setaf 10)
#      BASE00=$(tput setaf 11)
#      BASE0=$(tput setaf 12)
#      BASE1=$(tput setaf 14)
#      BASE2=$(tput setaf 7)
#      BASE3=$(tput setaf 15)
#      YELLOW=$(tput setaf 3)
#      ORANGE=$(tput setaf 9)
#      RED=$(tput setaf 1)
#      MAGENTA=$(tput setaf 5)
#      VIOLET=$(tput setaf 13)
#      BLUE=$(tput setaf 4)
#      CYAN=$(tput setaf 6)
#      GREEN=$(tput setaf 2)
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

function parse_git_branch {
  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="On branch ([^${IFS}]*)"
  remote_pattern="Your branch is (.*) of"
  diverge_pattern="Your branch and (.*) have diverged"
  if [[ ! ${git_status} =~ "working directory clean" ]]; then
    state="${RED}⚡️ "
  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${YELLOW}👆"
    else
      remote="${YELLOW}👇"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}↕"
  fi
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " (${branch})${remote}${state}"
  fi
}

function prompt_func() {
    previous_return_value=$?;
    prompt="\\[${TITLEBAR}${BLUE}[${YELLOW}\u@\h${BLUE}:${RED}\w${GREEN}$(parse_git_branch)${BLUE}]${COLOR_NONE} "
    if test $previous_return_value -eq 0
    then
        PS1="${prompt}➔ "
    else
        PS1="${prompt}${RED}➔${COLOR_NONE} "
    fi
}

PROMPT_COMMAND=prompt_func
