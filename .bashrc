# Find a ready-to-go .gitignore for the specified language.
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# echo path with only dir initials, except for current dir.
sps() {
  echo "$PWD" | sed -e "s!$HOME!~!"| sed -Ee "s!([^/])[^/]+/!\1/!g"
}

# echo branch for current git workspace
find_br() {
  IFS='%'
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi  
    git_branch="($branch)"' '
  else
    git_branch=""
  fi  
  echo $git_branch
  unset IFS
}

# My PS1: ~/s/o/mepath (gitbranch) $
export PS1="\[\033[0m\]\$(sps) \[\033[1;36m\]\$(find_br)\[\033[0m\]$ "

# set la to display hidden files too
alias la="ls -a"

# paths for cuda
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64"
export CUDA_HOME=/usr/local/cuda

# needed for vim colorscheme to work in desktop
export TERM=screen-256color
