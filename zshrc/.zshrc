
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kirill/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kirill/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/kirill/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kirill/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


. "$HOME/.local/bin/env"

[ -f ~/.nvim_secrets ] && source ~/.nvim_secrets
