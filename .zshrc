# Settings
setopt COMBINING_CHARS
setopt CHASE_LINKS
setopt AUTO_PUSHD
setopt AUTO_RESUME
setopt PROMPT_SUBST
setopt INTERACTIVE_COMMENTS
setopt EXTENDED_GLOB GLOB_DOTS
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS SHARE_HISTORY
unsetopt FLOW_CONTROL BEEP

# Aliases
unalias run-help 2>/dev/null
alias ls='ls -hAG'
alias head='head -n $(( $LINES - 10 ))'
alias top='top -o -rsize -O -cpu'

# Widgets
autoload -Uz run-help
autoload -Uz edit-command-line
autoload -Uz add-zsh-hook
zle -N edit-command-line
zle -N zle-line-init
zle -N zle-keymap-select
autoload -Uz compinit

# Completions
compinit -C && { [[ ! -s "$HOME/.zcompdump.zwc" ]] && zcompile "$HOME/.zcompdump" }&!

zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' menu selection
zstyle ':completion:*' completer _complete _match
zstyle ':completion:*' auto-description '%d'
zstyle ':completion:*:descriptions' format '%F{yellow} > %B%d%b%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{a-z\-}={A-Z\_}' 'r:|?=** m:{a-z\-}={A-Z\_}'
zstyle ':completion:*' list-colors no=00 fi=00 di=34 pi=33 so=00\;35 bd=00\;35 cd=00\;34 or=00\;41 mi=00\;45 ex=31 ow=01
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,ppid,user,comm'
zstyle ':completion:*:*:-command-:*:*' ignored-patterns '(_*|VCS_*|XPC_*)'
zstyle ':completion:*:*:*:users' ignored-patterns daemon nobody '_*'
zstyle ':completion:*:*:*:groups' ignored-patterns 'com.*' '_*'
zstyle -e ':completion:*' hosts 'reply=()'

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=6000000
SAVEHIST=$HISTSIZE

# Functions
grep() {
    command grep -EI \
        --exclude-dir=.git \
        --exclude-dir=.build \
        --exclude-dir='*.xcodeproj' \
        --color=auto \
        "$@"
}

make() {
    command make -j"$(sysctl -n hw.logicalcpu_max)" "$@"
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
    (($# != 1)) && printf >&2 'pgi <pattern>\n' && return 1
    local process_list header matched mem_field
    process_list="$(ps ax -mo pid,ppid,pgid,pcpu,nice,vsz,rss,state,tty,user,command)"
    matched="$(echo "$process_list" | grep -Ei "$1")"

    if [[ ! -z "$matched" ]]; then
        header="$(echo "$process_list" | head -n1)"
        if whence numfmt &>/dev/null; then
            mem_field="$(echo "$header" | awk '{for (i = 1; i <= NF; i++) { if ($i ~ "RSS") print i }}')"
            vsz_field="$(echo "$header" | awk '{for (i = 1; i <= NF; i++) { if ($i ~ "VSZ") print i }}')"
            printf '%s\n%s\n' "$header" "$matched" |\
                numfmt --header --field "$mem_field" --from-unit=1024 --to=iec |\
                numfmt --header --field "$vsz_field" --from-unit=1024 --to=iec
        else
            printf '%s\n%s\n' "$header" "$matched"
        fi
    else
        return 2
    fi
}

vim() {
    if (($# > 0)); then
        local -a args=()
        for arg in "$@"; do
            [[ -h "$arg" ]] && args+="$arg:P" || args+="$arg"
        done
        command vim "${args[@]}"
    else
        command vim
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

ping() {
    local host="${@: -1}"
    local match

    if [[ ! -s "$HOME/.ssh/config" ]]; then
        command ping "$@"
    else
        match="$(grep -Ei "\<$host\>" -A3 ~/.ssh/config | awk 'tolower($0) ~ /hostname/ {print $2}')"
        if [[ -z "$match" ]]; then
            command ping "$@"
        else
            command ping "${@: 1:$(($# - 1))}" "$match"
        fi
    fi
}

mutt() {
    stty quit undef
    (cd "$HOME/.mail/fastmail" && command mutt "$@")
    stty quit '^\'
}

# Key Maps
bindkey -v
bindkey -M vicmd "/" history-incremental-pattern-search-forward
bindkey -M vicmd "?" history-incremental-pattern-search-backward
bindkey -M vicmd '^g' what-cursor-position
bindkey -M vicmd '^x^e' edit-command-line
bindkey -M viins '^p' up-line-or-history
bindkey -M viins '^n' down-line-or-history
bindkey '^x^e' edit-command-line
bindkey '^?' backward-delete-char
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^[[Z' reverse-menu-complete
bindkey '^a' vi-insert-bol
bindkey '^_' run-help
bindkey '^e' vi-add-eol
bindkey '^k' kill-line
bindkey '^[.' insert-last-word
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward
bindkey '^u' backward-kill-line
bindkey '^y' yank
bindkey '^w' backward-delete-word

# Prompt
zle-line-init zle-keymap-select() {
    prompt_char="${${KEYMAP/vicmd/>}/(main|viins)/%%}"
    zle reset-prompt
}
PROMPT=$'[%(0?,,%F{red}%? )%(#.%F{1}.%f)%n%f@%m:%F{blue}%~%f]%(#.#.$prompt_char) '
