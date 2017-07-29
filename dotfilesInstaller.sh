#!/bin/sh

if has "git"; then
    git clone --recursive "$GITHUB_URL" "$(dirname $0)"

elif has "curl" || has "wget"; then
    tarball="xxx"

    if has "curl"; then
        curl -L "$tarball"
    elif has "wget"; then
        wget -O - "$tarball"
    fi | tar xv -

    mv -f xxx "$(dirname $0)"

else
    die "curl or wget required"
fi

cd $(dirname $0)
for dotfile in .??*
do
    echo $dotfile
    [ $dotfile == '.git' ] && continue
    [ $dotfile == '.gitconfig' ] && continue

    ln -snfv "$PWD/$dotfile" $HOME
done
