export KEYTIMEOUT=1
export BROWSER='open'
export EDITOR=vim
export PAGER=less
export MANPAGER=$PAGER
export LESS='--ignore-case --hilite-search --LONG-PROMPT --RAW-CONTROL-CHARS --QUIET --no-init'
export GPG_TTY="$(tty)"
export SSL_CERT_FILE=/usr/local/etc/openssl/certs/cert.pem

fpath=("/usr/local/share/zsh/site-functions" $fpath)
typeset -U FPATH
