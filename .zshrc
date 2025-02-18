# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/hbutow/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="amuse"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
COMPLETION_WAITING_DOTS="true"

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
plugins=(
  git docker terraform git-prompt git-auto-fetch zsh-kubectl-prompt
)

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

# no shared history between active shells please
unsetopt SHARE_HISTORY

export PATH="/usr/local/bin/:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/Users/hbutow/bin:$PATH"
export PATH="$PATH:/Users/hbutow/go/bin"

# setup krew.dev for kubectl plugin management
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# use Homebrew's version of make
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"

# word jumping powers activate!
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# Docker aliases
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dvls='docker volume ls'
alias dsp='docker system prune -f'
alias dspo="docker ps --filter 'status=exited' -q | xargs docker rm && docker images -q --filter 'dangling=true' | xargs docker rmi"
alias dka='docker ps -q | xargs docker kill'
alias dkrma='docker ps -a -q | xargs docker rm'
alias drmia="docker images --format '{{.Repository}}:{{.Tag}}' | xargs docker rmi --force"
alias dvrma='docker volume ls -q | xargs docker volume rm'
alias d='docker'
alias dm='docker-machine'
alias dc='docker-compose'

# Git aliases
alias gs='git status'

# Kubernetes aliases
kga_func() {
  namespaceName=$1
  kubectl api-resources --namespaced=true --verbs=list -o name | grep -v '^events\.events\.k8s\.io$' | grep -v '^events$' | xargs echo | tr ' ' ',' | xargs kubectl get -n "${namespaceName}"
}
alias kga="kga_func $1"

kgacw_func() {
  kubectl api-resources --namespaced=false --verbs=list -o name | xargs -L1 kubectl get --show-kind --ignore-not-found
}
alias kgacw="kgacw_func"

# kubectl completions activate!
source <(kubectl completion zsh)

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

alias kill-garbage='sudo launchctl unload \
     /Library/LaunchDaemons/some.plist \
     /Library/LaunchDaemons/some-other.plist'

export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home

# raise the default number of open files because macOS is mad and sets it to 256
ulimit -n 4096

# this needs to be at the end of the file
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -Uz compinit
compinit

source <(/usr/local/bin/starship init zsh --print-full-init)
