#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    . /etc/lsb-release
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    if [ ! -f /etc/apt/sources.list.d/mono-xamarin.list ]
    then
        echo "deb http://download.mono-project.com/repo/debian $DISTRIB_CODENAME main" |  tee /etc/apt/sources.list.d/mono-xamarin.list
    fi
    apt-get update
    apt-get install -y python-dev mono-complete golang-go
    curl -sL https://deb.nodesource.com/setup | bash -
    apt-get install -y nodejs npm cmake
    npm install xbuild
    curl -sSf https://static.rust-lang.org/rustup.sh | sh
else
    brew install go node npm mono CMake
    brew install caskroom/cask/brew-cask
    brew cask install cargo
fi

git submodule update --init --recursive
/usr/bin/python install.py --all
git submodule update --recursive
git submodule foreach --recursive ~/loadrc/gitrc/grsh.sh
git submodule foreach --recursive ~/loadrc/gitrc/gclean.sh
