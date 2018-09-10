#!/bin/bash

set -e
set -x

sudo add-apt-repository ppa:kubuntu-ppa/staging-plasma
sudo add-apt-repository ppa:kubuntu-ppa/backports
sudo apt-get check && sudo apt-get update && sudo apt-get autoremove --purge && sudo apt-get autoclean


# Display Manager theme
#https://store.kde.org/p/1214121/
#Install via "System Settings > Startup and Shutdown > Login Screen (SDDM) > Get New Theme".
#To access this setting the sddm-kcm package has to be installed. If in doubt use your package manager to search and if necessary install sddm-kcm first.
#The background can be changed to anything you want on the right hand side in "System Settings > Startup and Shutdown > Login Screen (SDDM)". Select the large green button next to "Background:"


# devstrap
sudo apt-get -y install build-essential nodejs npm openjdk-8-jdk flashplugin-installer git make nmap zsh apache2 apache2-utils libapache2-mod-php curl
sudo apt-get -y install libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev
sudo apt-get -y install libsqlite3-dev mysql-server libmysqlclient-dev autoconf automake emacs unattended-upgrades 

git config --global user.name "jeremyottley"
git config --global user.email "jeremy.ottley@gmail.com"
git config --global core.autocrlf input
git config --global core.safecrlf true
git config --system core.editor vim
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=18000'
git config --global push.default simple

git clone https://github.com/jeremyottley/.cheatsheets.git ~/.cheatsheets
git clone https://github.com/jeremyottley/bash-utils.git ~/.bash
git clone https://github.com/jeremyottley/Startpages.git ~/.startpages
git clone https://github.com/jeremyottley/.pandoc.git ~/.pandoc
git clone https://github.com/jeremyottley/.org.git ~/.org

# Wallpapers
git clone https://github.com/jeremyottley/.wallpapers ~/.wallpapers
mv -i ~/.wallpapers/* /usr/share/wallpapers/
rm -rf ~/.wallpapers

# Fonts
git clone https://github.com/jeremyottley/.fonts
sudo fc-cache -vf

sudo wget https://gist.githubusercontent.com/JeremyOttley/b8357bffff7728c166ae9e37dc00773b/raw/6f13d036fd542eda5afbf11d86f1fef20aac0ff0/50unattended-upgrades -O /etc/apt/apt.conf.d/50unattended-upgrades
sudo wget https://gist.githubusercontent.com/JeremyOttley/b8357bffff7728c166ae9e37dc00773b/raw/6f13d036fd542eda5afbf11d86f1fef20aac0ff0/20auto-upgrades -O /etc/apt/apt.conf.d/20auto-upgrades

# RVM and ruby
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import
curl -sSL https://get.rvm.io | bash -s stable --rails
. ~/.rvm/scripts/rvm
. "$HOME/.rvmrc"
. ~/.rvm/scripts/rvm
current_user=`whoami`
chown -R $current_user ~/.rvm
profile_location=$HOME/.bash_profile
source $profile_location
gem install httparty