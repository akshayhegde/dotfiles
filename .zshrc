# ajh17's ~/.zshrc

# Autoload {{{1
autoload -U edit-command-line
zle -N edit-command-line

# Source externals {{{1
source ~/.zsh/styles.zsh
source ~/.zsh/aliases
source ~/.zsh/ajh.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# Fasd {{{1
fasd_cache="$HOME/.cache/.fash-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook >| "$fasd_cache"
fi
source "$fasd_cache" && unset fasd_cache

# Variables {{{1
export ARCHFLAGS="-arch x86_64"
export BROWSER='open'
export CORRECT_IGNORE='_*'
export EDITOR=vim
export GREP_COLOR='1;33'
export GREP_OPTIONS='--color=auto'
export KEYTIMEOUT=1
export LANG='en_US.UTF-8'
export LESS='-F -g -i -M -R -S -w -X -z-4'
export PAGER='less'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,bold'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta,bold'

# Settings {{{1
setopt alwaystoend completeinword completealiases pathdirs automenu autolist menucomplete
setopt prompt_subst transientrprompt extendedglob globdots globcomplete correct recexact
setopt sharehistory histignoredups histreduceblanks histignorespace
setopt banghist incappendhistory histexpiredupsfirst histignorealldups
setopt histfindnodups histsavenodups histverify
setopt pushdtohome pushdsilent autopushd pushdminus
setopt longlistjobs autoresume multios
setopt autocd cdablevars multios rmstarwait
setopt rcquotes autoparamslash markdirs
setopt chaselinks combiningchars
unsetopt flowcontrol caseglob clobber extendedhistory nomatch

# History {{{1
HISTFILE=$HOME/.cache/.zhistory
HISTSIZE=200000
SAVEHIST=200000

# Key Remappings (Vi-mode) {{{1
bindkey -v
bindkey -M vicmd "?" history-incremental-pattern-search-backward
bindkey -M vicmd "/" history-incremental-pattern-search-forward
bindkey -M vicmd v edit-command-line
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^r' redo
bindkey -M vicmd '~' vi-swap-case
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[Z' reverse-menu-complete
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^l' clear-screen
bindkey '^k' kill-line
bindkey '^u' backward-kill-line
bindkey '^r' history-incremental-search-backward
bindkey '^p' history-search-backward
bindkey '^n' insert-last-word
bindkey '^?' backward-delete-char

# Functions {{{1
function cdf {
    target=`osascript -e 'tell application "Finder" to get POSIX path of (target of front Finder window as text)'`
    if [[ "$target" != "" ]]; then
        cd "$target"; echo "Going to $target"
    else
        echo -e 'There are no Finder windows!' >$2
    fi
}

# Colorize man pages
man() {
      env \
          LESS_TERMCAP_mb=$(printf "\e[1;31m") \
          LESS_TERMCAP_md=$(printf "\e[1;31m") \
          LESS_TERMCAP_me=$(printf "\e[0m") \
          LESS_TERMCAP_se=$(printf "\e[0m") \
          LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
          LESS_TERMCAP_ue=$(printf "\e[0m") \
          LESS_TERMCAP_us=$(printf "\e[1;32m") \
          man "$@"
}
