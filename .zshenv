skip_global_compinit=1

fpath=(~/.zsh/Completion $fpath)
path=(/usr/local/bin /usr/local/sbin ~/.bin $path)

# Environmental Variables
export HOMEBREW_NO_ANALYTICS=1
export BROWSER='open'
export CORRECT_IGNORE='_*'
export EDITOR=vim
export GREP_COLOR='1;33'
export KEYTIMEOUT=1
export LESS='-FigXR'
export PAGER='less'

if [[ -f ~/.gnupg/.gpg-agent-info ]] && [[ -n "$(pgrep gpg-agent)" ]]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi
