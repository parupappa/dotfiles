eval "$(/opt/homebrew/bin/brew shellenv)"

source /Users/annosuke.yokoo/.privilegesalias

path=(/opt/dogbrew/shims/bin /opt/dogbrew/bin ${${path:#/opt/dogbrew/shims/bin}:#/opt/dogbrew/bin}); fpath=(/opt/dogbrew/share/zsh/site-functions ${fpath:#/opt/dogbrew/share/zsh/site-functions}); case ":${MANPATH-}:" in *:'/opt/dogbrew/share/man':*) ;; *) export MANPATH='/opt/dogbrew/share/man':${MANPATH-} ;; esac # dogbrew shell setup
