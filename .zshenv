export PKG_PREFIX=/sw
export KEYTIMEOUT=1
export BROWSER='open'
export EDITOR=vim
export PAGER=less
export MANPAGER=$PAGER
export LESS='--quit-if-one-screen --ignore-case --hilite-search --LONG-PROMPT --RAW-CONTROL-CHARS --no-init'
export ARCHFLAGS='-arch x86_64'
export LD_LIBRARY_PATH="/sw/lib:/usr/lib:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"

fpath=("${PKG_PREFIX}/share/zsh-completions" "${PKG_PREFIX}/share/zsh/functions" "${PKG_PREFIX}/share/zsh/site-functions" "$fpath")

typeset -U FPATH
