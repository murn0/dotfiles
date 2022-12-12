#!/usr/bin/env bash

set -ue

DOTFILES_HOME="$HOME/.dotfiles"

git clone "https://github.com/murn0/dotfiles.git" ${DOTFILES_HOME}
cd ${DOTFILES_HOME} && make setup