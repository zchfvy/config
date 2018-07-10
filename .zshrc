#zmodload zsh/zprof
# #############################
# # -- Core shell Settings -- #
# #############################
#
# Antibody (plugins)
source <(antibody init)
antibody bundle < ~/.zsh_plugins

# Theme
source $HOME/.zsh_themes/solar_flare.zsh-theme
setopt PROMPT_SUBST

# Setup 'config' script alias to save local dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Personal scripts
PATH=$PATH:~/bin

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
source /usr/local/bin/virtualenvwrapper_lazy.sh

# Solarized LS colors (and autocomplete list too)
eval `dircolors ~/.dircolors/dircolors.256dark ` 
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit
compinit

# ########################
# # -- Personal Prefs -- #
# ########################
#
# zsh extensions
autoload -U zmv
unsetopt autocd # I dont like this functionality
SAVEHIST=1000000
HISTSIZE=1000000
HISTFILE=~/.zsh_history
setopt append_history
setopt share_history
setopt HIST_IGNORE_SPACE
eval $(thefuck --alias)

bindkey '^[OA' history-search-backward
bindkey '^[OB' history-search-forward
bindkey '^[[1;2A' history-beginning-search-backward
bindkey '^[[1;2B' history-beginning-search-forward
bindkey '^[[1;5A' history-substring-search-up
bindkey '^[[1;5B' history-substring-search-down


# Tab completion
bindkey '^[[Z' reverse-menu-complete
zstyle ':completion:*' menu select

# Alieses
alias ls='ls --color=auto'


# #############################
# # -- Work Specific Stuff -- #
# #############################
#
#SSH
# ssh () { command ssh "$@"; ~/.ssh/colorterm.sh none}
alias jassh="ssh -i ~/.ssh/jasonhamiltonsmith"
# Add RVM to PATH for scripting.
# Make sure this is the last PATH variable change.
#
# DO I STILL NEED THIS??
# export PATH="$PATH:$HOME/.rvm/bin"
# source /home/jhamiltonsmith/.rvm/scripts/rvm
#zprof
