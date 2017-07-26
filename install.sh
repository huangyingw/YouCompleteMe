#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

brew install go node npm mono
brew install caskroom/cask/brew-cask
brew cask install cargo
git submodule update --init --recursive
./install.py --all
