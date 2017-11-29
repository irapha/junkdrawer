export CLASSPATH=$CLASSPATH:/Users/raphael/Documents/Java/JUnit/junit-4.12.jar:/Users/raphael/Documents/Java/JUnit/hamcrest-core-1.3.jar

# Find a ready-to-go .gitignore for the specified language.
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# Use brew vim
alias vim="/usr/local/Cellar/vim/7.4.488/bin/vim"
alias vi="/usr/local/Cellar/vim/7.4.488/bin/vim"

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

# set up completion for bash
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# gradle alias
alias gradle="/usr/local/bin/gradle"

# set la to display hidden files too
alias la="ls -a"

# Add GHC 7.10.2 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.2.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# record timestamps for 'history' command
echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> ~/.bashrc
