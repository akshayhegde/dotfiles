export PKG_PREFIX=/usr/local
export KEYTIMEOUT=1
export BROWSER='open'
export EDITOR=vim
export PAGER=less
export MANPAGER=$PAGER
export LESS='--ignore-case --hilite-search --LONG-PROMPT --RAW-CONTROL-CHARS --no-init'
export ARCHFLAGS='-arch x86_64'
export LD_LIBRARY_PATH="${PKG_PREFIX}/lib:/usr/lib:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"

#fpath=("${PKG_PREFIX}/share/zsh-completions" "${PKG_PREFIX}/share/zsh/functions" "${PKG_PREFIX}/share/zsh/site-functions" "$fpath")

typeset -U FPATH

export LS_COLORS="$(printf '%s' 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33' \
    ':so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01' \
        ':mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=01:st=37;44:ex=01;32')"
