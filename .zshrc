# Settings
setopt CHASE_LINKS
setopt AUTO_PUSHD
setopt PROMPT_SUBST
setopt INTERACTIVE_COMMENTS
setopt EXTENDED_GLOB GLOB_DOTS
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
unsetopt FLOW_CONTROL

# Aliases
unalias run-help 2>/dev/null
alias cp='cp -vip'
alias mv='mv -vi'
alias rm='rm -vi'
alias jobs='jobs -l'
alias pgrep='pgrep -l'
alias grep='grep -EI --color=auto'
alias head='head -n $(( $LINES - 10 ))'

# Modules
autoload -Uz compinit
autoload -Uz run-help
autoload -Uz edit-command-line && zle -N edit-command-line
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# Completions
compinit -C -d $HOME/.zcompdump

zstyle ':completion:*' menu selection
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-z\-}={A-Z\_}' 'r:|?=** m:{a-z\-}={A-Z\_}'
zstyle ':completion:*' list-colors no=00 fi=00 di=01\;34 pi=33 so=01\;35 bd=00\;35 cd=00\;34 or=00\;41 mi=00\;45 ex=01\;32
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,ppid,user,comm'
zstyle ':completion:*' users ''
zstyle -e ':completion:*' hosts 'reply=()'

# History
export HISTFILE=$HOME/.cache/.zhistory
export HISTSIZE=6000000
export SAVEHIST=$HISTSIZE

# Functions
PKG_PREFIX=/sw

ls() {
    if [[ -x "${PKG_PREFIX}/bin/gls" ]]; then
        "${PKG_PREFIX}/bin/gls" -hA --color=auto "$@"
    else
        command ls -hAG "$@"
    fi
}

rcp() {
    if [[ -x "${PKG_PREFIX}/bin/rsync" ]]; then
        "${PKG_PREFIX}/bin/rsync" -av --info=progress2 "$@"
    else
        command rsync -av --progress "$@"
    fi
}

ssh() {
    if [[ "$TERM" =~ "^tmux-256color" ]]; then
        TERM=screen-256color command ssh "$@"
    else
        command ssh "$@"
    fi
}

info() {
    command info "$@" | command vim -RMNu NONE -
}

pgi() {
    local process_list
    local matched
    process_list="$(ps ax -o pid,ppid,user,pcpu,rss,cputime,state,command)"
    matched="$(echo "$process_list" | grep -Ei "$1")"

    if [[ ! -z "$matched" ]]; then
        echo "$process_list" | head -n1
        if [[ -x "${PKG_PREFIX}/bin/gnumfmt" ]]; then
            echo "$matched" | gnumfmt --field 5 --from-unit=1024 --to=si
        else
            echo "$matched"
        fi
    else
        return 1
    fi
}

vim() {
    if [[ $# -gt 0 ]]; then
        local -a args=()
        for arg in $@; do
            [[ -h "$arg" ]] && args+="$(readlink $arg)" || args+="$arg"
        done
        command vim "${args[@]}"
    elif [[ -f "Session.vim" ]]; then
        command vim -S
    else
        command vim -c LoadSession
    fi
}

peek() {
    if (($# == 1)); then
        if [[ ! -z "$TMUX" ]]; then
            tmux split-window "exec command vim -RM $1"
        else
            command vim -RM "$1"
        fi
    else
        printf >&2 'Usage: peek <file>\n'
    fi
}

# Key Maps
bindkey -v
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
bindkey '^u' backward-kill-line
bindkey '^y' yank
bindkey '^w' backward-delete-word

# Prompt
zle -N zle-line-init
zle -N zle-keymap-select
zle-line-init zle-keymap-select() {
    prompt_char="${${KEYMAP/vicmd/%%}/(main|viins)/$}"
    zle reset-prompt
}

add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats ' %F{green}(%b%f%c%u%F{green})%f'
zstyle ':vcs_info:*' stagedstr '%F{blue}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}.%f'
zstyle ':vcs_info:*' actionformats ' %F{green}(%b%f:%F{red}%a%f%c%u%F{green})%f'
PROMPT=$'%(0?,,%F{red}%? )%(#.%F{1}.%f)%n%f@%m:%F{blue}%~%f${vcs_info_msg_0_} %(#.#.$prompt_char) '
