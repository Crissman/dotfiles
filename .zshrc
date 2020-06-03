# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias cdg='cd /Users/Crissman/GDrive/Github'
alias alg='alias | grep'
alias scr='vim /Users/Crissman/GDrive/scratch.txt'
alias zrc='vim ~/.zshrc; conup'
alias vrc='vim ~/.vimrc; conup'
alias cc='export CWD=$PWD; cdc; pip install -e . > /dev/null; flake8; cd docs; make clean; SPHINXOPTS= make html; cd $CWD'
alias awsh='ssh -i ~/.ssh/crissman_aws_virginia.pem ubuntu@$AWS' 
alias awsf='ssh -N -f -L localhost:8888:localhost:8889 ubuntu@$AWS'
alias glast='git diff-tree --no-commit-id --name-only -r HEAD~1..HEAD'
alias gvl='cdc;vim $(glast)'

alias cl='clear'
alias cr='clear; fc -e : -1'
alias config='git --git-dir=/Users/crissman/.cfg/ --work-tree=/Users/crissman'
alias conup='cd;config commit -am "`date`";config pull origin master; config push origin master;cd -;source ~/.fzf.zsh; source ~/.zshrc'
alias pi='pip install --upgrade pip; pip install -U'
alias mmv='noglob zmv -W'
alias cpu='top -F -R -o cpu'
alias ex='exit'
alias grum='git rebase upstream/master'
alias pip='pip3'
alias sm='ssh m102'
alias nnh='history | cut -c 8-'

# Change to the github Chainer directory
cdc() {
	if [ -e /Users/Crissman/GDrive/Github/chainer/ ]; then
		cd /Users/Crissman/GDrive/Github/chainer
	elif [ -e ~/chainer/ ]; then
		cd ~/chainer
	else
		echo "Chainer directory not found!" >&2
	fi
}

# Change to the github Optuna directory
cdo() {
	if [ -e /Users/Crissman/GDrive/Github/Optuna/ ]; then
		cd /Users/Crissman/GDrive/Github/Optuna
	elif [ -e ~/optuna/ ]; then
		cd ~/optuna
	else
		echo "Optuna directory not found!" >&2
	fi
}

# Automated creation of new branch for function tests, test, and compare to master test
ct() {
	export CWD=$PWD
	cdc
	cd tests/chainer_tests/functions_tests/
	gpr "$1" "$2"
	pytest -m "not slow and not gpu and not cudnn and not ideep" $(ag -g "$1".py)
	gcm
	pytest -m "not slow and not gpu and not cudnn and not ideep" $(ag -g "$1".py)
	cd $CWD
}

bp() {
	export CWD=$PWD
	cdg
	cd backport
	python backport.py --repo "$1" --token $GTOK --pr "$2"
	cd $CWD
}

# Create a git branch for a pull request
gpr() {
	gcm
	git fetch upstream pull/"$2"/head:"$1"-pr"$2"
	git checkout "$1"-pr"$2"
}
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=/users/Crissman/anaconda3/bin:$PATH
export CHAINER_BUILD_CHAINERX=1
export MAKEFLAGS=-j8  # Using 8 parallel jobs
export MALMO_XSD_PATH=/Users/Crissman/Documents/Github/MalmoPlatform/Schemas

# Secure info replicated elsewhere
if [ "$(uname 2> /dev/null)" != "Linux" ]; then
	source $HOME/GDrive/secure.sh
fi

export PFKUBE_DOCKER_ALLOWED_RUNTIME_UID=2127
export PFKUBE_MNJ_DEFAULT_DOCKER_REGISTRY=harbor.mnj.pfn.io/user-crissman  # This is used when --target-cluster=mnj
export PFKUBE_MNJ_DEFAULT_DOCKER_CRED_NAME=pfkube-harbor-cred  # This is used when --target-cluster=mnj
export PFKUBE_MNJ_DEFAULT_GIT_SECRET_NAME=pfkube-git-secret  # This is used when --target-cluster=mnj
