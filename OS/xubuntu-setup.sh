# MANUALLY - Add dotfiles home folder

# Install git
sudo apt-get install git

# Install curl
sudo apt-get install curl


### TERMINAL ###
# Install pip
sudo apt-get install python-pip

# Install powerline shell
pip install powerline-shell

# Install powerline-fonts and reload fonts cache
wget https://github.com/powerline/fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf
sudo mv Inconsolata\ for\ Powerline.otf /usr/share/fonts
fc-cache -vf

# Install urxvt
sudo apt-get install rxvt-unicode


### VIM ###
# Install VIM
sudo apt-get install vim

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
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
# MANUALLY install package control 
# MANUALLY install PackageSync and load my configuration at ~/.sublime_backup/SublimePackagesBackup.zip

# Create SSH key
# MANuALLY - ssh-keygen -t rsa -b 4096 -C "my_email@example.com"

# Git setup
git config --global core.editor vim
# MANUALLY - git config --global user.name "Marcelo Lazaroni"
# MANUALLY - git config --global user.email my_email@example.com


# Install NVM
mkdir ~/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
# Use a node version
# MANUALLY - nvm install VERSION
# MANUALLY - nvm use VERSION
# MANUALLY - nvm alias default VERSION

# Install Docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce docker-compose

