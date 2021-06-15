# Zsh Options
KEYTIMEOUT=1

# Environment variables
export BROWSER=open
export EDITOR=vim
export PAGER=less
export MANPAGER=$PAGER
export LESS='--ignore-case --hilite-search --LONG-PROMPT --RAW-CONTROL-CHARS --QUIET --quit-if-one-screen'
export GPG_TTY="$(tty)"
export SSL_CERT_FILE=/usr/local/etc/openssl/certs/cert.pem

fpath=("/usr/local/share/zsh/site-functions" $fpath)
typeset -U fpath

path=("$HOME/.bin" "$HOME/Library/Python/Current/bin" $path)
typeset -U path
