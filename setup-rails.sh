#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git
sudo apt-get install -y curl
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.17
nvm use v0.10.17
nvm alias default 0.10.17

# Install jshint to allow checking of JS code within emacs
#Install other useful npm packages
# http://jshint.com/
npm install -g jshint
npm install -g coffee-script
npm install -g grunt-cli
npm install -g bower 
npm install -g nodemon 

#Install rvm
curl -L https://get.rvm.io | bash

# Load rvm and install latest production ruby
source $HOME/.rvm/scripts/rvm
rvm install 2.0.0 
rvm install 1.9.3
rvm use 2.0.0 --default
# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/danteata/dotfiles.git
ln -sb dotfiles/screenrc .screenrc
ln -sb dotfiles/bash_profile .bash_profile
ln -sb dotfiles/bashrc .bashrc
ln -sb dotfiles/vimrc .vimrc
ln -sf dotfiles/emacs.d .emacs.d

sudo apt-get install -y libxml2-dev imagemagick build-essential

./setup-rails/pgsetup.sh

