#!/usr/bin/bash

# install vimrc
cp .vimrc ~/.vimrc
# install tomorrow night eighties for vim
mkdir ~/.vim/colors
wget -O ~/.vim/colors/tomorrow-night-eighties.vim https://github.com/chriskempson/tomorrow-theme/raw/master/vim/colors/Tomorrow-Night-Eighties.vim
# install vundle for vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "Please run vim :PluginInstall"

# install neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
# install nvim/init.vim
mkdir -p ~/.config/nvim/colors/
cp init.vim ~/.config/nvim/init.vim
# install tomorrow night eighties for nvim
cp ~/.vim/colors/tomorrow-night-eighties.vim ~/.config/nvim/colors/
# install python3 and gem bundles for neovim
# TODO

# if mac:
#   install bash_profile
cp .bash_profile ~/.bash_profile
#   install phoenix (or give instructions for installing phoenix)
echo "If using a mac, please follow instructions in .phoenix.cljs"

# if ubuntu:
#   install bashrc
cp .bashrc ~/.bashrc

# install tmux config
cp .tmux.conf ~/.tmux.conf

# install alert and push (prompt for box name)
echo "What is this box's name? "
read BOX
echo "What is your pushbullet key? "
read KEY
sed -i -e 's/Beetle/$BOX/g' push
sed -i -e 's/KEY=\"\"/KEY=\"$KEY\"/g' push

# install workon
# TODO

# optional:
#   install python3.6, python3.6-venv
#   install gitconfig
# TODO
