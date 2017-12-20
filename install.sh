#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

OS=`uname`
if [ $OS != "Darwin" ];
then
    . /etc/lsb-release
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    echo "deb http://download.mono-project.com/repo/debian $DISTRIB_CODENAME main" |  tee /etc/apt/sources.list.d/mono-xamarin.list
    apt-get update
    apt-get install -y python-dev mono-complete golang-go
    curl -sL https://deb.nodesource.com/setup | bash -
    apt-get install -y nodejs npm
    npm install xbuild
    curl -sSf https://static.rust-lang.org/rustup.sh | sh
else
    brew install go node npm mono CMake
    brew install caskroom/cask/brew-cask
    brew cask install cargo
fi

git submodule update --init --recursive
./install.py --all

if [ $OS == "Darwin" ];
then
    brew unlink python
fi
