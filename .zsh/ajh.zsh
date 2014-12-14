# My Zsh theme.
# Features => Indicators for git status, vim mode, last command execution time and backgrounded app.
setopt prompt_subst
autoload colors
autoload -Uz vcs_info
colors

orange="%F{166}"
purple="%F{135}"
limegreen="%F{118}"

# Version control
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' stagedstr '%F{28}●'
zstyle ':vcs_info:*' unstagedstr '%F{161}●'
zstyle ':vcs_info:*' check-for-changes true

preexec () {
   (( $#_elapsed > 1000 )) && set -A _elapsed $_elapsed[-1000,-1]
   typeset -ig _start=SECONDS
}

precmd () {
   (( _start >= 0 )) && set -A _elapsed $_elapsed $(( SECONDS-_start ))
   _start=-1
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '%F{blue}%F{green}%b%c%u%F{blue} '
    } else {
        zstyle ':vcs_info:*' formats '%F{blue}%F{green}%b%c%u%F{red}●%F{blue} '
    }
    vcs_info
}

vim_insert_mode="%B%F{green}❯%f%b"
vim_cmd_mode="%B%F{red}❮%f%b"
vim_mode=$vim_insert_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_insert_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_insert_mode
}
zle -N zle-line-finish
PROMPT=$'%{$orange%}%~ %f${vim_mode}%f '
RPROMPT='[${vcs_info_msg_0_}%F{blue}bg:%j%f %{$orange%}t:${_elapsed[-1]}s%f]'
# vim: ft=zsh
