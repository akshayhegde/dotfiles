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


# Preexec {{{1
prompt_ajh_preexec() {

}

# Precmd {{{1
prompt_ajh_precmd() {
    vcs_info

    local prompt_ajh_preprompt="\n%F{242}$vcs_info_msg_0_"
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
