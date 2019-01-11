# Zsh
export CORRECT_IGNORE='_*'
export KEYTIMEOUT=1

# Zsh completions
fpath=(/sw/share/zsh-completions /sw/share/zsh/functions /sw/share/zsh/site-functions ~/.zsh/Completion $fpath)
typeset -U FPATH

# General
export BROWSER='open'
export EDITOR=vim
export PAGER=less
export MANPAGER=$PAGER
export LESS='--quit-if-one-screen --ignore-case --hilite-search --LONG-PROMPT --RAW-CONTROL-CHARS --no-init'
export LESSHISTFILE="$HOME/.cache/.lesshst"

# Compilation
export ARCHFLAGS='-arch x86_64'
export CPATH="/sw/include"
export LIBRARY_PATH="/sw/lib"
export LD_LIBRARY_PATH="/sw/lib"
