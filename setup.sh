#!/bin/sh
cd "$(dirname "$0")"

echo "Install vim-plug"
#sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       #https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config/nvim}
VIM_PLUG_HOME=${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/
echo "Config Home Path: ${CONFIG_HOME}"
echo "Vim-Plug Home Path: ${VIM_PLUG_HOME}"

mkdir -p $CONFIG_HOME
mkdir -p $VIM_PLUG_HOME

echo "Install vim-plug"
cp -rv plug.vim.setup ${VIM_PLUG_HOME}/plug.vim

echo "copy configs to $CONFIG_HOME"
cp -rv init.vim ${CONFIG_HOME}/
cp -rv ginit.vim ${CONFIG_HOME}/
cp -rv entry ${CONFIG_HOME}/

nvim +checkhealth +PlugInstall

echo "Setup NeoVim Done!"

install(){

}
