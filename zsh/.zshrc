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
    (colima start &>>"$HOME/.colima/autostart.log" &)
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

# Trajectory - AI coding agent observability
export PATH="/Users/annosuke.yokoo/.trajectory/bin:$PATH"

path=(/opt/dogbrew/shims/bin /opt/dogbrew/bin ${${path:#/opt/dogbrew/shims/bin}:#/opt/dogbrew/bin}); fpath=(/opt/dogbrew/share/zsh/site-functions ${fpath:#/opt/dogbrew/share/zsh/site-functions}); case ":${MANPATH-}:" in *:'/opt/dogbrew/share/man':*) ;; *) export MANPATH='/opt/dogbrew/share/man':${MANPATH-} ;; esac # dogbrew shell setup
