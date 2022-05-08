# use neovim
alias vim="nvim"

# echo path with only dir initials, except for current dir.
sps() {
  echo "$PWD" | sed -e "s!$HOME!~!"| sed -Ee "s!([^/])[^/]+/!\1/!g"
}

# echo branch for current git workspace
find_br() {
  IFS='%'
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
  ¦ if [[ "$branch" == "HEAD" ]]; then
  ¦ ¦ branch='detached*'
  ¦ fi
  ¦ git_branch="($branch)"' '
  else
  ¦ git_branch=""
  fi
  echo $git_branch
  unset IFS
}

# My PS1: ~/s/o/mepath (gitbranch) $
# export PS1="\[\033[0m\]\$(sps) \[\033[1;36m\]\$(find_br)\[\033[0m\]$ "
shpwd() {
  echo ${${:-/${(j:/:)${(M)${(s:/:)${(D)PWD:h}}#(|.)[^.]}}/${PWD:t}}//\/~/\~}
}
PROMPT='%F{green}% $(shpwd)%f %F{green}%#%f '
setopt PROMPT_SUBST

# set la to display hidden files too
alias la="ls -a"

# record timestamps for 'history' command
export HISTTIMEFORMAT="%d/%m/%y %T "
