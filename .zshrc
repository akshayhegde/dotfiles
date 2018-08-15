# ajh17's ~/.zshrc

# Path {{{1
fpath=(~/.zsh/Completion ~/build/share/zsh/site-functions $fpath)
path=(~/build/bin ~/build/sbin /usr/local/sbin ~/.bin $path)
manpath=(~/build/share/man $manpath)

typeset -U PATH
typeset -U FPATH
typeset -U MANPATH

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
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors no=00 fi=00 di=01\;34 pi=33 so=01\;35 bd=00\;35 cd=00\;34 or=00\;41 mi=00\;45 ex=01\;32
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:manuals' separate-sections true
zstyle -e ':completion:*' hosts 'reply=()'
zstyle -e ':completion:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# Aliases {{{1
alias grep="grep -EI --color=auto --exclude-dir=backup --exclude-dir=*.{xcodeproj,git,svn,hg} --exclude={tags,Session.vim}"
alias ggrep="git grep --break --heading --line-number"
alias head='head -n $(( $LINES - 10 ))'
alias pgrep="pgrep -l"
alias gs="git status -sb"
alias cp="cp -vip"
alias rcp="rsync -av --info=progress2"
alias ls="ls -GAp"
alias mv="mv -vi"
alias rm="rm -vi"

# Settings {{{1
setopt completeinword menucomplete chaselinks rmstarwait \
    cdablevars autopushd pushdsilent interactivecomments \
    promptsubst transientrprompt extendedglob globdots globstarshort \
    incappendhistory histignoredups histignorealldups histreduceblanks \
    histignorespace banghist
unsetopt flowcontrol clobber nomatch

# History {{{1
export HISTFILE=$HOME/.cache/.zhistory
export HISTSIZE=6000000
export SAVEHIST=$HISTSIZE

# Functions {{{1
# Go to the open Finder window's path
function cdf {
    target=$(osascript -e 'tell application "Finder" to get POSIX path of (target of front Finder window as text)')
    if [[ "$target" != "" ]]; then
        cd "$target" || exit 1
    else
        echo -e 'There are no Finder windows!' >"$2"
    fi
}

# Redirect info to vim to use vim keybindings, rather than emacs
function info {
    command info "$@" | vim -u NONE -N -RM -
}

# Create a directory and cd into it
function mkcd {
    mkdir -p "$1" && cd "$1"
}

function vim {
    if [[ $# -gt 0 ]]; then
        local -a args=()
        for arg in $@; do
            [[ -h "$arg" ]] && args+="$(readlink $arg)" || args+="$arg"
        done
        env vim "${args[@]}"
    elif [[ -f "Session.vim" ]]; then
        env vim -S
    else
        env vim
    fi
}

# Fetch the pull request on a local branch for easy diffing
function pull_github_request {
    if [[ -z "$1" ]]; then
        echo "You forgot to specify the Pull Request id number!"
    elif [[ -z "$2" ]]; then
        echo "You forgot to specify a local branch!"
    else
        git fetch origin pull/"$1"/head:"$2"
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
bindkey -M vicmd '^x^e' edit-command-line
bindkey '^x^e' edit-command-line
bindkey '^?' backward-delete-char
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
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
    prompt_char="${${KEYMAP/vicmd/%%}/(main|viins)/$}"
    zle reset-prompt
}

autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zle -N zle-line-init
zle -N zle-keymap-select
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats '%F{yellow}%b%f%c%u'
zstyle ':vcs_info:*' stagedstr '%F{blue}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}.%f'
zstyle ':vcs_info:*' actionformats '%F{yellow}%b%f|%F{red}%a%f%c%u'
zstyle ':vcs_info:git+set-message:*' hooks git-untracked
function +vi-git-untracked() {
    [[ -n $(git ls-files --exclude-standard --others 2>/dev/null) ]] && \
        hook_com[unstaged]+="%F{red}?%f"
}

PROMPT=$'%(0?,,%F{red}%? )%(#.%F{1}.%f)%n%f@%m %F{green}%~%f %(#.#.$prompt_char) '
RPROMPT=$'$vcs_info_msg_0_'
