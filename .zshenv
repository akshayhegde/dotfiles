# Environmental Variables {{{1
export CORRECT_IGNORE='_*'
export KEYTIMEOUT=1

# general
export BROWSER='open'
export EDITOR=vim
export PAGER=less
export MANPAGER=$PAGER
export LESS='--quit-if-one-screen --ignore-case --hilite-search --LONG-PROMPT --RAW-CONTROL-CHARS --no-init'
export LESSHISTFILE="$HOME/.cache/.lesshst"

# compilation
export CFLAGS="-I/Users/ajh/build/include -I/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include"
export CXXFLAGS="-I/Users/ajh/build/include"
export LDFLAGS="-L/Users/ajh/build/lib"

typeset -U CFLAGS
typeset -U CXXFLAGS
typeset -U LDFLAGS
