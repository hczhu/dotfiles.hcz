#/bin/bash

dir=$(dirname "$0")
for dotfile in gitignore ctags bashrc gitconfig inputrc template.cpp tmux.conf vimrc;
do
  ln -f -s $PWD/$dir/$dotfile $HOME/.$dotfile
done
