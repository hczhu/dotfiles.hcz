#/bin/bash

for dotfile in ctags bashrc gitconfig inputrc template.cpp tmux.conf vimrc;
do
  ln -f -s $PWD/$dotfile $HOME/.$dotfile
done
