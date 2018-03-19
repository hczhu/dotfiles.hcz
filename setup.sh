#/bin/bash

dir=$(dirname "$0")
fullPath=$PWD
if [ "$dir" != "." -a "$dir" != "" ]; then
  fullPath=$fullPath/$dir
fi
for dotfile in gitignore ctags bashrc gitconfig inputrc template.cpp tmux.conf vimrc;
do
  ln -f -s $fullPath/$dotfile $HOME/.$dotfile
done
