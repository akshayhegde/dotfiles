# ajh17's ~/.zshrc

# Styles {{{1
# Cache completions
ZCACHEDIR=~/.cache/
zstyle ':completion:*' use-cache true
zstyle ':completion' cache-path $ZCACHEDIR
autoload -Uz compinit && compinit -i -C -d $ZCACHEDIR/zcompdump

# Completion options.
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose true
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format '%F{yellow}Completing %d%f'
zstyle ':completion:*' warnings '%F{red}No matches for: %d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' users ajh root
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors no=00 fi=00 di=01\;34 pi=33 so=01\;35 bd=00\;35 cd=00\;34 or=00\;41 mi=00\;45 ex=01\;32
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:manuals' separate-sections true
zstyle -e ':completion:*' hosts 'reply=()'
zstyle -e ':completion:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# Source externals {{{1
source ~/.zsh/aliases
source ~/.bin/iterm2_shell_integration.zsh

# Fasd {{{1
fasd_cache="$HOME/.cache/.fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook >| "$fasd_cache"
fi
source "$fasd_cache" && unset fasd_cache

# Settings {{{1
setopt completeinword menucomplete chaselinks rmstarwait autocd \
    cdablevars autopushd pushdsilent interactivecomments \
    promptsubst transientrprompt extendedglob globdots \
    incappendhistory histignoredups banghist
unsetopt flowcontrol clobber nomatch

# History {{{1
HISTFILE=$HOME/.cache/.zhistory
HISTSIZE=20000
SAVEHIST=20000

# Functions {{{1
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

# Go to the open Finder window's path
function cdf {
    target=`osascript -e 'tell application "Finder" to get POSIX path of (target of front Finder window as text)'`
    if [[ "$target" != "" ]]; then
        cd "$target"; echo "Going to $target"
    else
        echo -e 'There are no Finder windows!' >$2
    fi
}

# Create a directory and cd into it
function mkcd {
    mkdir -p $1 && cd $1
}

# Full screen Vim help page.
function :h () {
    vim +"h $1" +only;
}

function zman() {
  PAGER="less -g -s '+/^       "$1"'" man zshall
}

# Copy current git commit sha1 to the clipboard.
function gcopy() {
    git rev-parse --short @ | tr -d '\n' | pbcopy && echo "Copied `pbpaste`"
}

# Open origin remote URL in a browser
function gopen() {
    local url
    url=$(git remote show origin | sed -n 2p | awk '{sub(/\.git/, ""); print $3}')
    open $url
}

# Fetch the pull request on a local branch for easy diffing
function pull_github_request {
    if [[ -z "$1" ]]; then
        echo "You forgot to specify the Pull Request id number!"
    elif [[ -z "$2" ]]; then
        echo "You forgot to specify a local branch!"
    else
        git fetch origin pull/$1/head:$2
    fi
}

# Clear out completion caches and rebuild.
function remove_compl_cache() {
    rm -rf ~/.zcomp* ~/.cache/zcomp* && compinit
}

# Shows the most used shell commands.
function history_stat() {
    history 0 | awk '{print $2}' | sort | uniq -c | sort -n -r | head
}

# Run brew update and upgrade
function upgrade_pkgs() {
    brew update --verbose && brew outdated && brew upgrade --all && brew cleanup
}

# Key Remappings (Vi-mode) {{{1
bindkey -v
autoload -Uz edit-command-line
zle -N edit-command-line

bindkey -M vicmd "/" history-incremental-pattern-search-forward
bindkey -M vicmd "?" history-incremental-pattern-search-backward
bindkey -M vicmd '^g' what-cursor-position
bindkey -M vicmd '^r' redo
bindkey -M vicmd 'G' end-of-buffer-or-history
bindkey -M vicmd 'gg' beginning-of-buffer-or-history
bindkey -M vicmd 'u' undo
bindkey -M vicmd '~' vi-swap-case
bindkey '^b' edit-command-line
bindkey '^?' backward-delete-char
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[Z' reverse-menu-complete
bindkey '^a' vi-insert-bol
bindkey '^_' run-help
bindkey '^e' vi-add-eol
bindkey '^k' kill-line
bindkey '^l' clear-screen
bindkey '^n' insert-last-word
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward
bindkey '^u' vi-change-whole-line

# Prompt {{{1
function zle-line-init zle-keymap-select {
    vi_mode="${${KEYMAP/vicmd/%%}/(main|viins)/$}"
    zle reset-prompt
}

autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zle -N zle-line-init
zle -N zle-keymap-select
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats '%F{239}»%f %F{yellow}%b%f%c%u'
zstyle ':vcs_info:*' actionformats '%F{239}»%f %F{yellow}%b%f|%F{red}%a%f%c%u'
zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}!%f'
zstyle ':vcs_info:git+set-message:*' hooks git-untracked
function +vi-git-untracked() {
    [[ -n $(git ls-files --exclude-standard --others 2>/dev/null) ]] && \
        hook_com[unstaged]+="%F{red}?%f"
}
PROMPT=$'\n%(#.%F{1}.%f)%n%f@%m%f %F{239}»%f %F{green}%~%f $vcs_info_msg_0_ %f'$'${vi_mode}%f '
RPROMPT=$'%(0?,,%F{red}<%?>%f)'
