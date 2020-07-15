# Instructions to setup a new Linux machine

# Create a new user
adduser marcelo

# add it to sudoers
sudo vim /etc/sudoers

# Log into user account
su marcelo

# Install nix and cachix
curl -L https://nixos.org/nix/install | sh
. /home/marcelo/.nix-profile/etc/profile.d/nix.sh
nix-env -i cachix
cachix use cachix

# create ssh keys
ssh-keygen -t rsa -b 4096
sudo cat /root/.ssh/authorized_keys > ~/.ssh/authorized_keys

# Prepare home directory
cd ~ && git clone https://github.com/lazamar/dotfiles.git
cp -R ~/dotfiles/.git .
cd ~ && git reset --hard

# Install programs
nix-env -i marcelo

# Vim extensions
nvim -c PlugInstall


