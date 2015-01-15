# ajh.zsh
# Slightly modeled after pure zsh prompt.

# Helpers {{{1
# Zle {{{2
function zle-keymap-select {
    vi_mode="${${KEYMAP/vicmd/${vi_cmd_mode}}/(main|viins)/${vi_insert_mode}}"
    zle reset-prompt
}
function zle-line-finish {
    vi_mode=$vi_insert_mode
}

# Git Dirty {{{2
# Fastest way possible to check dirtyness (From pure.zsh)
prompt_ajh_git_dirty() {
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    command test -n "$(git status --porcelain --ignore-submodules -unormal)"
    (($? == 0)) && echo ' ❉]' || echo ']'
}

# Human readable time {{{2
prompt_ajh_human_time() {
    local tmp=$1
    local hours=$(( tmp / 60 / 60 % 24 ))
    local minutes=$(( tmp / 60 % 60 ))
    local seconds=$(( tmp % 60 ))
    (( $hours > 0 )) && echo -n "${hours}h "
    (( $minutes > 0)) && echo -n "${minutes}m "
    echo "${seconds}s"
}

# Command execution time
# displays the execution time of the last command
prompt_ajh_cmd_exec_time() {
    local stop=$EPOCHSECONDS
    local start=${cmd_timestamp:-stop}
    integer elapsed=$stop-$start
    (($elapsed > 3)) && prompt_ajh_human_time $elapsed
}

# Preexec {{{1
prompt_ajh_preexec() {
    cmd_timestamp=$EPOCHSECONDS

    # Show current directory and command in the title if a process is active.
    print -Pn "\e]0;"
    echo -nE "$PWD:t: $1"
    print -Pn "\a"
}

# Precmd {{{1
prompt_ajh_precmd() {
    # Show full path in title:
    print -Pn '\e]0;%~\a'

    # Setup vi-mode variables
    vi_insert_mode="%B%F{green}❯%f%b"
    vi_cmd_mode="%B%F{red}❮%f%b"
    vi_mode=$vi_insert_mode

    vcs_info
}

# Prompt setup {{{1
prompt_ajh_setup() {
    export PROMPT_EOL_MARK=''
    prompt_opts=(cr subst percent)

    zmodload zsh/datetime
    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    zle -N zle-keymap-select
    zle -N zle-line-finish
    add-zsh-hook precmd prompt_ajh_precmd
    add-zsh-hook preexec prompt_ajh_preexec

    zstyle ':vcs_info:*' enable git hg svn
    zstyle ':vcs_info:git*' formats '[%b'
    zstyle ':vcs_info:git*' actionformats '[%b (%a)'

    PROMPT='
%F{green}%~ %F{242}$vcs_info_msg_0_`prompt_ajh_git_dirty`%f %F{red}`prompt_ajh_cmd_exec_time`%f
%F{yellow}%n%(?.%F{magenta}.%F{red}) ${vi_mode}%f '
    unset cmd_timestamp
}
prompt_ajh_setup "$@"
