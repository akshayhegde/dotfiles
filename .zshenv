skip_global_compinit=1

fpath=(~/.zsh/Completion ~/build/share/zsh/site-functions $fpath)
path=(~/build/bin /usr/local/sbin ~/.bin $path)
manpath=(~/build/share/man $manpath)

# Environmental Variables
export CFLAGS="-I/Users/ajh/build/include $CFLAGS"
export LDFLAGS="-L/Users/ajh/build/lib $LDFLAGS"
export BROWSER='open'
export CORRECT_IGNORE='_*'
export EDITOR=vim
export GREP_COLOR='1;33'
export KEYTIMEOUT=1
export LESS='-FigXR'
export PAGER='less'
export CC=clang
export CXX=clang++
