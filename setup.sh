#/bin/bash

dir=$(dirname "$0")
fullPath=$PWD
if [ "$dir" != "." -a "$dir" != "" ]; then
  fullPath=$fullPath/$dir
fi
for dotfile in clang-format gitignore ctags bashrc gitconfig inputrc template.cpp tmux.conf vimrc;
do
  ln -f -s $fullPath/$dotfile $HOME/.$dotfile
done

for vimfile in filetype.vim; do
  ln -f -s $fullPath/$vimfile $HOME/.vim/$vimfile
done

echo "Installing Tmux Plugin Manager..."
mkdir -p ~/.tmux/plugins
tmux source ~/.tmux.conf
