# ajh.zsh
# Slightly modeled after pure zsh prompt.

# Helpers {{{1
# Git Dirty {{{2
# Fastest way possible to check dirtyness (From pure.zsh)
prompt_ajh_git_dirty() {
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    [[ "$AJH_GIT_UNTRACKED_DIRTY" == 0 ]] && local umode="-uno" || local unmode="-unormal"
    command test -n "$(git status --porcelain --ignore-submodules ${umode})"

    (($? == 0)) && echo '❉'
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
    (($elapsed > ${AJH_CMD_MAX_EXEC_TIME:=3})) && prompt_ajh_human_time $elapsed
}

# String length {{{2
prompt_ajh_string_length() {
    echo ${#${(S%%)1//(\%([KF1]|)\{*\}|\%[Bbkf])}}
}


# Preexec {{{1
# shows current directory and executed command time in the title
prompt_ajh_preexec() {
    cmd_timestamp=$EPOCHSECONDS
    print -Pn "\e]0;"
    echo -nE "$PWD:t: $2"
    print -Pn "\a"
}

# Precmd {{{1
prompt_ajh_precmd() {
    vcs_info

    local prompt_ajh_preprompt="\n%F{242}$vcs_info_msg_0_`prompt_ajh_git_dirty`%f %F{red}`prompt_ajh_cmd_exec_time`%f"
    print -P $prompt_ajh_preprompt

    # Asynchronously checks if there is anything to pull
    (( ${AJH_GIT_PULL:-1} )) && {
        command git rev-parse --is-inside-work-tree &>/dev/null &&
        [[ "$(command git rev-parse --show-toplevel)" != "$HOME" ]] &&
        command git fetch &>/dev/null &&
        command git rev-parse --abbrev-reg @'{u}' &>/dev/null && {
            local arrows=''
            (( $(command git rev-list --right-only --count @...@'{u}' 2>/dev/null) > 0 )) && arrows='⇣'
            (( $(command git rev-list --left-only --count @...@'{u}' 2>/dev/null) > 0 )) && arrows+='⇡'
            print -Pn "\e7\e[A\e[1G\e[`prompt_ajh_string_length $prompt_ajh_preprompt`C%F{cyan}${arrows}%f\e8"
        }
    } &!
    unset cmd_timestamp
}

# Prompt setup {{{1
prompt_ajh_setup() {
    export PROMPT_EOL_MARK='.'
    prompt_opts=(cr subst percent)

    zmodload zsh/datetime
    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    add-zsh-hook precmd prompt_ajh_precmd
    add-zsh-hook preexec prompt_ajh_preexec

    # Git formats
    # %b => Branch
    # %c => staged changed
    # %u => unstaged changes
    # %m => stashed
    zstyle '' enable git
    zstyle ':vcs_info:git*' formats '%b %m%u%c'
    zstyle ':vcs_info:git*'  actionformats ' %b (%a) %m%u%c'

    PROMPT='%F{yellow}%n%(?.%F{magenta}.%F{red}) ❯%f '
}
prompt_ajh_setup "$@"
