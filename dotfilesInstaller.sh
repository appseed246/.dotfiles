#!/bin/sh

for dotfile in .??*
do
    [ $dotfile == '.git' ] && continue
    [ $dotfile == '.gitconfig' ] && continue

    ln -snfv "$PWD/$dotfile" $HOME
done
ln -snfv "$PWD/nvim" $HOME/.vim
