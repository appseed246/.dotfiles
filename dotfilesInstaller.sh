#!/bin/sh

for dotfile in .??*
do
    [ $dotfile == '.git' ] && continue
    [ $dotfile == '.gitconfig' ] && continue

    ln -snfv "$PWD/$dotfile" $HOME
done
ln -snfv "$PWD/nvim" $HOME/.vim
ln -snfv "$PWD/nvim/init.vim" $HOME/.vimrc
ln -snfv "$PWD/nvim" $HOME/$XDG_CONFIG_HOME/nvim
