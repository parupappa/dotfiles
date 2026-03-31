#!/bin/zsh

# -----------------------------
# Software setting
# -----------------------------
# Docker Desktop completions (must be before compinit)
fpath=(/Users/annosuke.yokoo/.docker/completions $fpath)

# mise
eval "$(/opt/homebrew/bin/mise activate zsh)"
# sheldon
eval "$(sheldon source)"
# starship
eval "$(starship init zsh)"
