#!/bin/bash

# check to see is git command line installed in this machine
IS_GIT_AVAILABLE="$(git --version)"
if [[ $IS_GIT_AVAILABLE == *"version"* ]]; then
  echo "Git is Available"
else
  echo "Git is not installed"
  exit 1
fi

cp -r $HOME/.config/i3 .
cp -r $HOME/.config/polybar .
cp -r $HOME/.config/termite .
cp -r $HOME/.config/dunst .
cp -r $HOME/{.vimrc,.vim/coc-settings.json} ./vim
cp -r $HOME/{.zshrc,p10k.zsh} ./zsh
cp $HOME/{Xresources} .

# Check git status
gs="$(git status | grep -i "modified")"
echo "${gs}"

# If there is a new change
if [[ $gs == *"modified"* ]]; then
  echo "push"
fi

# push to Github
git add -u;
git commit -m "New backup `date +'%Y-%m-%d %H:%M:%S'`";
git push origin master

