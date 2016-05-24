function git_branch {
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  echo "%F{3}$branch%f"
}

function git_stash {
  if [[ $(git stash list 2> /dev/null | wc -l) -gt 0 ]]; then
    stashes=$(git stash list 2> /dev/null | wc -l | awk '{print "!"NF}')
    echo "%F{6}$stashes%f"
  fi
}

function git_prompt {
  [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) ]] && \
    echo " $(git_branch)"
}

alias git='hub'
alias g='git'
alias gh='github .'

alias gb='git branch -av'
alias gs='git status -sb'
alias gco='git checkout'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'
alias gpl='git pull --rebase'
alias gps='git push'
alias gdf='git diff'
alias gdfc='git diff --cached'
alias gdfl='git diff HEAD~1'
alias glo='git log --decorate --oneline -n 15'
alias gcl='git clone'

function gc {
  if [[ $# > 0 ]]; then
    git commit -m $1
  else
    git commit -v
  fi
}

function gaa {
  git add --all
  if [[ $# > 0 ]]; then
    git commit -m $1
  fi
}

function gca {
  if [[ $# > 0 ]]; then
    git commit --amend -m $1
  else
    git commit --amend
  fi
}

function gba {
  git checkout -b $1
  git push origin $1
  git branch --set-upstream-to origin/$1 $1
}

function gbmv {
  git branch -m $1 $2
  git push origin :$1
  git push origin $2
  git branch --set-upstream-to origin/$2 $2
}

function gbrm {
  git push origin :$1
  git branch -D $1
}

function gbt {
  git checkout -t $1
}

function gres {
  echo "Remove all local changes?"
  select REPLY in "Yes" "No"; do
    case $REPLY in
      Yes ) git checkout -f HEAD && git clean -df; break;;
      No ) break;;
    esac
  done
}
