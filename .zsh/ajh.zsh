# ajh.zsh
function zle-line-init zle-keymap-select {
    vi_mode="${${KEYMAP/vicmd/%%}/(main|viins)/$}"
    zle reset-prompt
}

prompt_ajh_setup() {
    export PROMPT_EOL_MARK=''
    prompt_opts=(cr subst percent)

    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    zle -N zle-line-init
    zle -N zle-keymap-select
    add-zsh-hook precmd vcs_info

    zstyle ':vcs_info:*' enable git hg svn
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' formats '(%F{yellow}%b%f:%.8i%f%c%u)'
    zstyle ':vcs_info:*' actionformats '%b%c%u [%a]'
    zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
    zstyle ':vcs_info:*' unstagedstr '%F{red}!%f'

    PROMPT=$'\n''%F{green}%~%f$vcs_info_msg_0_ %(?.%F{247}.%F{red})${vi_mode}%f '
    RPROMPT=''
}
prompt_ajh_setup "$@"
