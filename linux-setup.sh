# Instructions to setup a new Linux machine

# Create a new user
adduser marcelo             # Needs to be made non-interactive

# add it to sudoers
sudo vim /etc/sudoers       # Needs to be made non-interactive

# Log into user account
su marcelo                  # Running the next commands as
                            # the new user needs to be made
                            # non-interactive

# Install nix and cachix
curl -L https://nixos.org/nix/install | sh
. /home/marcelo/.nix-profile/etc/profile.d/nix.sh
nix-env -i cachix
cachix use cachix

# create ssh keys
ssh-keygen -t rsa -b 4096    # Needs to be made non-interactive
sudo cat /root/.ssh/authorized_keys > ~/.ssh/authorized_keys

# Prepare home directory
cd ~ && git clone https://github.com/lazamar/dotfiles.git
cp -R ~/dotfiles/.git .
cd ~ && git reset --hard

# Install programs
nix-env -i marcelo

# Vim extensions
nvim -c PlugInstall          # Needs to be made non-interactive


