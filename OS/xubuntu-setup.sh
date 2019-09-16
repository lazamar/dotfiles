# MANUALLY - Add dotfiles home folder

# Install curl
sudo apt-get install curl

# Install Nix
sudo apt-get install git
# install all packages in ~/.nix-defexpr/Marcelo/default.nix
nix-env -i Marcelo

### TERMINAL ###
# Install pip
sudo apt-get install python-pip

# Install powerline shell
pip install powerline-shell

# Install powerline-fonts and reload fonts cache
wget https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf
sudo mv Inconsolata\ for\ Powerline.otf /usr/share/fonts
fc-cache -vf

# Install VimPlug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install VIM extensions with VimPlug
vim +PlugInstall +qall

### UI ###
# Install xmonad
apt-get install xmonad

# Adjust DPI
# Open xfce4-settings-editor and under xsettings change DPI
# For retina display with low resolution use 120dpi
# For retina display with high resolution use 180 dpi


# Google Chrome
# Manually download it from chrome's website and install it
# Make it start quickly:
#    Edit the .desktop files to use no keyring
#    Exec=google-chrome-stable --password-store=basic %U
 

# Sublime Text
# MANUALLY install package control 
# MANUALLY install PackageSync and load my configuration at ~/.sublime_backup/SublimePackagesBackup.zip

# Install Fira Code font for nice ligatures
sudo apt install fonts-firacode

# Create SSH key
# MANuALLY - ssh-keygen -t rsa -b 4096 -C "my_email@example.com"

# Git setup
git config --global core.editor vim
# MANUALLY - git config --global user.name "Marcelo Lazaroni"
# MANUALLY - git config --global user.email my_email@example.com

# Better git log
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%Cgreen(%>(14)%cr) %C(bold blue)<%<(17,trunc)%an>%Creset %s %C(yellow)%d%Creset' --abbrev-commit"


# Install Docker (optional)
# sudo apt install apt-transport-https ca-certificates curl software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
# sudo apt update
# sudo apt install docker-ce docker-compose
