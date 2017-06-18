# Initialize promptline
source ~/.promptline_snapshot.sh
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="agnoster"
ZSH_THEME=""

# Gets rid of "user@hostname" when logged in on local machine
DEFAULT_USER="harrisonbachrach"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(npm pylint brew git vi-mode)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/bin:$PATH
export PATH=/bin:$PATH
export PATH=/usr/sbin:$PATH
export PATH=/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/texbin:$PATH
export PATH=/opt/local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/Users/harrisonbachrach/.p2/pool/plugins/org.eclim_2.6.0/bin:$PATH

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# For XQuartz
export PATH=/usr/local/bin:/opt/X11/bin:$PATH

export PATH=$HOME/Documents/Code/Go/bin:$PATH
export GOPATH=$HOME/Documents/Code/Go

# For ROOT
export PATH=/usr/local/bin:/opt/X11/bin:/usr/local/root/bin:$PATH
export ROOTSYS=~/Documents/Code/root

# For PyRoot
export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH

# For AWS
export PATH=~/Library/Python/3.5/bin:$PATH

# Aliases
alias vi='mvim -v'
alias vim='mvim -v'
alias matlab='/Applications/MATLAB_R2016a.app/bin/matlab -nodesktop'
alias thanksgivingFlights="swa --from 'OAK' --to 'BUR' --leave-date '11/23/2016' --return-date '11/27/2016' --passengers 1"
alias sshTml="ssh -t -X -l hib wtrw.lanl.gov ssh ml-fe.lanl.gov"
alias wolfram="/Applications/Mathematica.app/Contents/MacOS/WolframKernel"
alias python='python3'

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# For FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# For virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=~/Documents/Code/Python
source /usr/local/bin/virtualenvwrapper.sh

# For vi-mode
bindkey -M viins 'jj' vi-cmd-mode

source ~/.zlogin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# So that zsh restricted history works with vi-mode
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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
