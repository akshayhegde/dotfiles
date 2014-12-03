# Settings for Zsh Completions

# Cache completions {{{1
ZCACHEDIR=~/.cache/
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion::complete:*' use-cache true
zstyle ':completion' cache-path $ZCACHEDIR
autoload -Uz compinit && compinit -i -C -d $ZCACHEDIR/zcompdump

# Completion options {{{1
#
