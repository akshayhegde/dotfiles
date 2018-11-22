# Zsh
export CORRECT_IGNORE='_*'
export KEYTIMEOUT=1

# General
export ARCHFLAGS='-arch x86_64'
export BROWSER='open'
export EDITOR=vim
export PAGER=less
export MANPAGER=$PAGER
export LESS='--quit-if-one-screen --ignore-case --hilite-search --LONG-PROMPT --RAW-CONTROL-CHARS --no-init'
export LESSHISTFILE="$HOME/.cache/.lesshst"

# Compilation
export CFLAGS="-I/Users/ajh/build/include $CFLAGS"
export CXXFLAGS="$CFLAGS $CXXFLAGS"
export LDFLAGS="-L/Users/ajh/build/lib -L/usr/lib $LDFLAGS"

typeset -U CFLAGS
typeset -U CXXFLAGS
typeset -U LDFLAGS
