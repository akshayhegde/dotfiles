export KEYTIMEOUT=1
export BROWSER='open'
export EDITOR=vim
export PAGER=less
export MANPAGER=$PAGER
export LESS='--ignore-case --hilite-search --LONG-PROMPT --RAW-CONTROL-CHARS --no-init'
export GPG_TTY="$(tty)"
export SSL_CERT_FILE=/usr/local/etc/openssl/certs/cert.pem

fpath=("/usr/local/share/zsh/functions" "/usr/local/share/zsh/site-functions" "/usr/share/zsh/5.8/functions" $fpath)
typeset -U FPATH

export LS_COLORS="$(printf '%s' 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33' \
    ':so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01' \
        ':mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=01:st=37;44:ex=01;32')"
