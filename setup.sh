#! /bin/bash

sudo apt update
sudo apt upgrade
sudo apt install -y vim terminator build-essential cmake python3-dev
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp vimrc ~/.vimrc
cp bashrc ~/.bashrc
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clang-completer
