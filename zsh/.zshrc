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

autoload -Uz compinit
compinit

# colima: start in background if not running
if command -v colima &>/dev/null; then
  if ! colima status &>/dev/null; then
    (colima start &) &>/dev/null
  fi
fi

# BEGIN SCFW MANAGED BLOCK
alias npm="scfw run npm"
alias pip="scfw run pip"
alias poetry="scfw run poetry"
export SCFW_DD_AGENT_LOG_PORT="10365"
export SCFW_DD_LOG_LEVEL="ALLOW"
export SCFW_HOME="/Users/annosuke.yokoo/.scfw"
# END SCFW MANAGED BLOCK
