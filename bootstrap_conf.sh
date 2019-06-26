#/usr/bin/sh
cd ~

# Apt Packages
sudo apt install \
    i3 i3blocks arandr xautolock \
    zsh vim wget curl git gitk tmux htop \
    jq \
    python python-pip python3-pip virtualenvwrapper python3-distutils \
    scrot unclutter terminator libsixel-bin \
    keepass2 xdotool thefuck

# Pip packages
sudo -H pip install virtualenv virtualenvwrapper

# Shell configuration
curl -sL git.io/antibody | sh -s
# git clone https://github.com/seebi/dircolors-solarized.git .dircolors

# Nerd Fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf
sudo fc-cache -fv
cd ~

#####################
# Optional Software #
#####################

# Media stuff
echo -n "Install media packages? "
read REPLY
if [ $REPLY != "${REPLY#[Yy]}" ]
then

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90 
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client


echo "Please download playerctl manually"
echo "  https://github.com/acrisci/playerctl/releases/latest"
echo "Press enter to continue"
read NADA

fi

# Work Stuff (Hothead)
echo -n "Install work (Hothead) packages? "
read REPLY
if [ $REPLY != "${REPLY#[Yy]}" ]
then
sudo apt install \
    helix-cli slack-desktop
fi
