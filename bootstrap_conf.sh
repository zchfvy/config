#/usr/bin/sh

# Apt Packages
sudo apt install \
    i3 arandr xautolock \
    zsh vim wget curl git tmux htop \
    python python-pip python3-pip virtualenvwrapper python3-distutils \
    scrot unclutter terminator playerctl libsixel-bin spotify-client \
    helix-cli slack-desktop keepass2

# Pip packages
sudo -H pip install virtualenv virtualenvwrapper

# Configure vim
mkdir -p ~/.vim/swp ~/.vim/backup ~/.vim/undo
geit clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Shell configuration
curl -sL git.io/antibody | sh -s
# git clone https://github.com/seebi/dircolors-solarized.git .dircolors
