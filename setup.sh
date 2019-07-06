#/bin/bash

set -ex

maybeCreateDir() {
  dir=$1
  if [ ! -r ${dir} ]; then
    echo "Creating ${dir}"
    mkdir -p ${dir}
  fi
}

prog_name=$(basename "$0")
dir_name=$(cd "$(dirname "$0")" || exit 1; pwd -P)

if [ -r ${HOME}/.dotfiles ]; then
  rm -i ${HOME}/.dotfiles
fi
ln -s ${dir_name} ${HOME}/.dotfiles
for dotfile in clang-format gitignore ctags bashrc gitconfig inputrc template.cpp tmux.conf vimrc hgrc; do
  if [ -r ${HOME}/.${dotfile} ]; then
    echo "${HOME}/.${dotfile} already exists! Skipped it."
  else
    ln -f -s ${dir_name}/${dotfile} ${HOME}/.${dotfile}
  fi
done

maybeCreateDir ${HOME}/.vim

for vimfile in filetype.vim; do
  ln -f -s ${dir_name}/${vimfile} ${HOME}/.vim/${vimfile}
done

echo "Installing Tmux Plugin Manager..."

tmuxPluginDir=${HOME}/.tmux/plugins
maybeCreateDir ${tmuxPluginDir}

if [ ! -r ${tmuxPluginDir} ]; then
  mkdir -p ${tmuxPluginDir}
fi
if [ ! -r ${tmuxPluginDir} ]; then
  git clone https://github.com/tmux-plugins/tpm ${tmuxPluginDir}/tpm
fi
tmux source ${HOME}/.tmux.conf

if [ ! -r ${HOME}/.ssh/config ]; then
  ln -s ${dir_name}/ssh_config ${HOME}/.ssh/config
fi
