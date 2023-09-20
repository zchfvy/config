#zmodload zsh/zprof
# #############################
# # -- Core shell Settings -- #
# #############################
#
# Antibody (plugins)
source <(antibody init)
antibody bundle < ~/.zsh_plugins

# Theme
source $HOME/.zsh_themes/my-bt.zsh-theme
setopt PROMPT_SUBST

# Setup 'config' script alias to save local dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Personal scripts
# PATH=$PATH:~/bin

# Solarized LS colors (and autocomplete list too)
eval `dircolors ~/.dircolors/dircolors.256dark ` 
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
autoload -Uz compinit
compinit

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")" 

# Pyenv
# export PATH="/home/jason/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
export VIRTUALENV_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_SCRIPT=~/.local/bin/virtualenvwrapper.sh
source ~/.local/bin/virtualenvwrapper_lazy.sh

# Python
# alias python=python3
# alias pip=pip3
# alias python2=/usr/bin/python
# alias pip2=/usr/bin/pip

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

# Aliases and functions
alias ls='ls --color=auto'
alias less='less -R'
cheat() { curl -s cheat.sh/"$1" | less }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
