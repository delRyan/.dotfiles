#! /bin/bash

ln -sf $PWD/git/gitconfig ~/.gitconfig
ln -sf $PWD/git/gitignore ~/.gitignore

rm -rf ~/.zsh
ln -s $PWD/zsh ~/.zsh
ln -sf $PWD/zsh/zshrc ~/.zshrc

rm -rf ~/.vim
ln -s $PWD/vim ~/.vim
ln -sf $PWD/vim/vimrc ~/.vimrc

ln -sf $PWD/tmux/.tmux.conf ~/.tmux.conf

# Don't disturb other apps using ~/.config
mkdir -p ~/.config
ln -sf $PWD/config/* ~/.config/
