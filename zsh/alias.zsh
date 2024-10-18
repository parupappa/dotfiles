#!/bin/bash

alias c='clear'
alias reload='exec $SHELL -l'
alias ll='ls -laG'
alias tf='terraform'
alias k='kubectl'

# colordiff
if [[ -x $(which colordiff) ]]; then
    alias diff='colordiff'
fi
