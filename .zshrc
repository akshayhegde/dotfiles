#######################################
#     Watabou's .zshrc file           #
#     Modified: May 13, 2012          #
#     Path: $HOME/.zshrc              #
#     Random Comment: zsh rules!      #
#######################################

# Use 64-bit architecture for compiling as default
export ARCHFLAGS="-arch x86_64"

# Zsh Environment Variables 
ZSH=$HOME/.oh-my-zsh
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH
export PATH=$PATH:$HOME/.rvm/bin
export RUBYOPT=rubygems
export EDITOR='mvim -v'
export JAVA_HOME=/usr/local/jdk
export PAGER=less
export LESSCHARSET=utf-8
export LESSHISTFILE="~/.zsh/lesshist/" 
export LESSHISTSIZE=1000

# Auto load zsh goodies. 
autoload -U promptinit colors
promptinit
colors

# Load fasd. 
eval "$(fasd --init auto)"

# Load hub.
eval "$(hub alias -s)"

# Using a theme inspired by Steve Losh. 
ZSH_THEME="macademia"

# Disable zsh auto update.
DISABLE_AUTO_UPDATE="true"

# Load all the plugins
plugins=(brew compleat gem git github pip rvm osx zsh-syntax-highlighting)
source $ZSH/plugins/history-substring-search/history-substring-search.zsh
source $ZSH/oh-my-zsh.sh

# Cool aliases personalized to my liking.
alias vim="mvim -v" 
alias cp="cp -vi"
alias rm="rm -vi"
alias mv="mv -vi" 
alias ll="ls -l" 
alias la="ls -a"
alias c="clear"
alias ez="mvim -v ~/.zshrc"
alias sz="source ~/.zshrc"
alias evi="mvim -v ~/.vimrc"
alias updateBrew="brew update;brew outdated;brew upgrade;brew cleanup"
alias j="z" # For fasd
alias musicmpd="mpd && mpdscribble && ncmpcpp" # start mpd server, scrobbling and client.
alias top="htop" # Since htop > top. Requires htop to be installed.
# Toggle show all files in the Finder
alias showfilesY="defaults write com.apple.Finder AppleShowAllFiles YES ; killall Finder"
alias showfilesN="defaults write com.apple.Finder AppleShowAllFiles NO ; killall Finder"

# Zsh options
setopt menucomplete       # On an ambiguous completion, inserts first match immediately.
setopt prompt_subst       # complete functions in the prompt.
setopt nobeep             # beeps are annoying.
setopt notify             # report status of background jobs immediately.
setopt globdots           # don't require a leading period in a filename to be matched. 
setopt correct            # correct the spelling of commands.
setopt pushdtohome        # just entering pushd will cd to home folder.
setopt cdablevars         # try expand a "cd" argument if. 
setopt autolist           # automatically list choices when zsh doesn't understand a command.
setopt correctall         # try to correct the spelling of all arguments in a line.
setopt autocd             # imply "cd" when I only type a path. 
setopt recexact           # when completing, recognize exact matches. 
setopt longlistjobs       # list jobs in the long format.
setopt autoresume         # use single word simple commands for resumption of a existing job.
setopt extendedhistory    # save commands with a time stamp.
setopt histignoredups     # don't add duplicate commands into the history list.
setopt histreduceblanks   # and don't add blanks either.
setopt histignorespace    # done add a command to history that starts with a space
setopt pushdsilent        # don't print the directory stack after pushd/popd.
setopt autopushd          # make "cd" command = pushd.
setopt pushdminus         # exchange + and - when used with a number to specify a dir in the stack. 
setopt extendedglob       # enable more globbing features.
setopt rcquotes           # allow multiple quotes to signify a single quote within a single quoted string.
setopt globcomplete       # expand globs
setopt rmstarwait         # if issuing the "rm *" command, tell zsh to wait 10 seconds.
setopt completeinword     # complete inside a word.
setopt sharehistory       # share history between multiple shells
setopt noclobber          # don't overwrite files by default

# History settings
HISTFILE=$HOME/.zhistory
HISTSIZE=2000
SAVEHIST=2000

# Some zsh styling options {{{

# Use cache to speed some stuff 
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# default completions:
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# always use verbose completions
zstyle ':completion:*' verbose yes

# color listing
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# This partially colors depending on what the user has typed when hitting tab:
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

# complete process ids for the kill command
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# completion styles for descriptions
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:options' description yes

# change syntax highlighting for the path from underlining to a color
# Use with zsh-syntax-highlighting plugin
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
# }}}
################################# End of .zshrc ###############################
