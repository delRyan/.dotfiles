function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

#setopt promptsubst
autoload -U colors && colors # Enable colors in prompt

# Colors
bold=$(tput bold)
reset=$(tput sgr0)

black=$(tput setaf 0)
blue=$(tput setaf 33)
cyan=$(tput setaf 37)
green=$(tput setaf 70)
orange=$(tput setaf 166)
purple=$(tput setaf 125)
violet=$(tput setaf 61)
red=$(tput setaf 124)
white=$(tput setaf 15)
yellow=$(tput setaf 220)

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="${blue}±"
GIT_PROMPT_PREFIX="${bold}${blue} ["
GIT_PROMPT_SUFFIX="${blue}]%{$reset_color%}"
GIT_PROMPT_AHEAD="${green}ANUM"
GIT_PROMPT_BEHIND="${red}BNUM"
GIT_PROMPT_MERGING="${cyan}⚡︎"
GIT_PROMPT_UNTRACKED="${orange}u"
GIT_PROMPT_MODIFIED="${yellow}m"
GIT_PROMPT_STAGED="${green}s"

# Show Git branch/tag, or name-rev if on detached head
function parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropriate for various Git repository states
function parse_git_state() {

  # Compose this value via multiple conditional appends.
  local GIT_STATE=""

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi

  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi

}


# If inside a Git repository, print its branch and state
function git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "on ${bold}${violet}${git_where#(refs/heads/|tags/)}%{$reset_color%}$(parse_git_state)"
}

function current_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}


PROMPT='${bold}${orange}%n ' # Name
PROMPT+='${white}at ' # at
PROMPT+='${yellow}$(box_name) ' # Box Name
PROMPT+='${white}in ' # in
PROMPT+='${green}$(current_pwd)%{$reset_color%} ' # Directory
PROMPT+='$(git_prompt_string)' # Git Info 
PROMPT+='
> ' # New Line Prompt Character

export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color [(y)es (n)o (a)bort (e)dit]? "
export RPROMPT=""

