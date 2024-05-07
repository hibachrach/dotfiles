## Shell configuration
# Sets the shell command history size cap
export HISTSIZE=10000000
export SAVEHIST=10000000

# Decorates the shell by setting PROMPT in a precmd_function. For details,
# search for 'EXPANSION OF PROMPT SEQUENCES' in `man zshall`.
source ~/.promptline_snapshot.sh
# eval "$(starship init zsh)"

# Add scripts installed by Homebrew to path
export PATH=/usr/local/bin:$PATH

### Oh My Zsh (plugin manager) configuration
# Path to oh-my-zsh installation.
export ZSH=/Users/hbachrach/.oh-my-zsh

# Plugins to be loaded by oh-my-zsh
plugins=(you-should-use git vi-mode bundler)

source $ZSH/oh-my-zsh.sh

# Set up `help` to do its job of explaining various builtin commands and not
# just alias to the man pages
unalias run-help 2>/dev/null
autoload run-help
HELPDIR=/usr/local/share/zsh/help
alias help=run-help

# Set up 'zmv' builtin for complex multi-file move operations to automatically
# load
autoload -U zmv

# Set up tetriscurses to automatically load :^)
autoload -U tetriscurses

# So that zsh prefix-restricted history works with vi-mode
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# Bind the sequence `jj` when in zsh's vi emulator's insert mode to escape to
# the vi emulator's command mode (i.e. `vi-cmd-mode`)
bindkey -M viins 'jj' vi-cmd-mode

## Language agnostic tools

### For git

alias gwd="git webdiff"
alias gcm!="git commit --amend --reuse-message HEAD"
alias grh~="git reset HEAD~"
alias gfu="git log -n 50 --pretty=format:'%h %s' --no-merges | fzf | cut -c -7 | xargs -o git commit --fixup"


### For Ripgrep

export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/rc
alias rg="rg --hidden --glob '!.git'"
alias rgnt="rg -g'!test/' -g'!spec/'"

### For (n)vim or whichever editor

export EDITOR="nvim"
# NOTE: ACMR means (Added || Copied || Modified || Renamed), see
# `--diff-filter` in `man git-diff` for details
alias v="$EDITOR"
alias h="hx"
# Open files that have been added or changed since the last commit (including
# untracked files)
alias vd="$EDITOR \$(git diff HEAD --name-only --diff-filter=ACMR) \$(git ls-files --others --exclude-standard)"
# Open files with staged changes
alias vds="$EDITOR \$(git diff --staged --name-only --diff-filter=ACMR)"
# Open files that were changed in the last commit
function vdc() {
  local ref=$1
  $EDITOR $(git diff "${ref:-HEAD^}" --name-only --diff-filter=ACMR)
}

alias vimdiff="nvim -d"

function vs() {
  if [ $# -ne 0 ] && [ $1 != "-h" ]; then
    # Presumes EDITOR is vi-esque (e.g. vi, vim, nvim, etc.)
    $EDITOR -q =(rg --vimgrep "$@")
  else
    echo "usage: `basename $0` <regex>"
    echo "searches current directory with \`rg\`, opens (vim-like) $EDITOR, and adds matches to the quickfix list"
  fi
}

function vsnt() {
  if [ $# -ne 0 ] && [ $1 != "-h" ]; then
    # Presumes EDITOR is vi-esque (e.g. vi, vim, nvim, etc.)
    $EDITOR -q <(rgnt --vimgrep "$@")
  else
    echo "usage: `basename $0` <regex>"
    echo "searches current directory with \`rg\`, opens (vim-like) $EDITOR, and adds matches to the quickfix list (ignores test dirs)"
  fi
}

function ppsql() {
  sqlfmt - | bat -l sql
}

alias tmr=tmuxinator

### For FZF

# Sets up fzf, a generic fuzzy-search filter program
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf_functions.sh ] && source ~/.fzf_functions.sh
[ -f ~/.fzf_functions_key_bindings.zsh ] && source ~/.fzf_functions_key_bindings.zsh
export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

function fzf-git-branches-widget() {
  LBUFFER="${LBUFFER}$(__gbsel)"
  local ret=$?
  zle reset-prompt
  return $ret
}

function __gbsel() {
  local cmd="git branch"
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

zle -N fzf-git-branches-widget
bindkey '^G' fzf-git-branches-widget

# Fuzzy-find a git branch and check it out
function gcof() {
  local branches branch
  branches=$(git branch -vv --sort=-committerdate) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function fzf-git-changed-files-widget() {
  LBUFFER="${LBUFFER}$(__gdsel)"
  local ret=$?
  zle reset-prompt
  return $ret
}

function __gdsel() {
  local cmd="git diff --name-only; git ls-files --others --exclude-standard"
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

zle -N fzf-git-changed-files-widget
bindkey '^A' fzf-git-changed-files-widget

# Fuzzy-search the contents of the files in the current directory and open the
# selected files
# function fl() {
#   local matches files_string files
#   matches=$(ag --nobreak --nonumbers --noheading . | fzf --multi)
#   if [[ ! -z "$matches" ]]; then
#     files_string= $(echo $matches | awk -F: '{print $1}' | uniq)
#     files=(${(f)files_string})
#     $EDITOR ${(j: :)files}
#   fi
# }

# Fuzzy-search the names of the files in the current directory with live
# preview (with syntax highlighting)
# function fp() {
#   # Try highlight, coderay, rougify in turn, then fall back to cat
#   fzf --preview '[[ $(file --mime {}) =~ binary ]] &&
#                    echo {} is a binary file ||
#                    (highlight -O ansi -l {} ||
#                     coderay {} ||
#                     rougify {} ||
#                     cat {}) 2> /dev/null | head -500'
# }

### For tmux

alias t="tmux attach -t"
alias tn="tmux new -s"

### Misc.

alias f="fff"

alias google-chrome="open -a '/Applications/Google Chrome.app' "
alias go_to_gems="cd /Users/hbachrach/.rbenv/versions/3.0.6/lib/ruby/gems/3.0.0/gems"

export PATH="/Users/hbachrach/path_dependencies:$PATH"
export PATH="/Users/hbachrach/scripts:$PATH"

## Language-specific tools

### For python

alias p="python3"
alias pip="pip3"
export PATH="/Users/hbachrach/.local/bin/:$PATH"

### For ruby

# Silence warnings for ruby. See `-W` flag in `man ruby` for details
export RUBYOPT=-W0

#### For rbenv
export RBENV_ROOT="${HOME}/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi

### For psql
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
export PGHOST=localhost
export PAGER="less -S" # Prevents wrapping with long rows

### For node

#### For nodenv
eval "$(nodenv init -)"

### For Java
export JAVA_HOME=$(/usr/libexec/java_home -v14)

### For Crystal
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

if [ -e $HOME/.environment_specific_zshrc ]; then
  source $HOME/.environment_specific_zshrc
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


### For Nim
export PATH="$HOME/.nimble/bin/:$PATH"

### For Rust
export PATH="$HOME/.cargo/bin:$PATH"

# added by travis gem
[ -f /Users/hbachrach/.travis/travis.sh ] && source /Users/hbachrach/.travis/travis.sh

export CPATH=`xcrun --show-sdk-path`/usr/include


export RUBYFMT_USE_RELEASE=1
alias rubyfmt="/Users/hbachrach/.rbenv/versions/2.5.8/bin/ruby --disable=all /Users/hbachrach/personal/programming/forks/rubyfmt/rubyfmt.rb" 


### For direnv
# eval "$(direnv hook zsh)"

### For Elixir
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

[ -f "/Users/hbachrach/.ghcup/env" ] && source "/Users/hbachrach/.ghcup/env" # ghcup-env

# export PATH="/usr/local/opt/llvm/bin:$PATH"

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

export OVERCOMMIT_DISABLE=1 # For now...
