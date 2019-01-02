#/bin/bash

set -ex

maybeCreateDir() {
  dir=$1
  if [ ! -r ${dir} ]; then
    echo "Creating ${dir}"
    mkdir -p ${dir}
  fi
}

dir=$(dirname "$0")
fullPath=${PWD}
if [ "${dir}" != "." -a "${dir}" != "" ]; then
  fullPath=${fullPath}/${dir}
fi
if [ -r ${HOME}/.dotfiles ]; then
  rm -i ${HOME}/.dotfiles
fi
ln -s ${fullPath} ${HOME}/.dotfiles
for dotfile in clang-format gitignore ctags bashrc gitconfig inputrc template.cpp tmux.conf vimrc; do
  if [ -r ${HOME}/.${dotfile} ]; then
    echo "${HOME}/.${dotfile} already exists! Skipped it."
  else
    ln -f -s ${fullPath}/${dotfile} ${HOME}/.${dotfile}
  fi
done

maybeCreateDir ${HOME}/.vim

for vimfile in filetype.vim; do
  ln -f -s ${fullPath}/${vimfile} ${HOME}/.vim/${vimfile}
done

echo "Installing Tmux Plugin Manager..."

maybeCreateDir ${HOME}/tmux/plugins

tmuxPluginDir=${HOME}/tmux/plugins
if [ ! -r ${tmuxPluginDir} ]; then
  mkdir -p ${tmuxPluginDir}
fi
if [ ! -r ${tmuxPluginDir} ]; then
  git clone https://github.com/tmux-plugins/tpm ${tmuxPluginDir}/tpm
fi
tmux source ${HOME}/.tmux.conf
