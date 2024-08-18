
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


#export PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '
#export PS1="$ " # "%~" gives the directory
export PS1="~ "

alias nv="nvim"
alias vmr2="ssh -L 8787:localhost:8787 porl557@fosstatsprd02.its.auckland.ac.nz"
alias vmr3="ssh -L 8787:localhost:8787 porl557@fosstatsprd03.its.auckland.ac.nz"
alias vmr4="ssh -L 8787:localhost:8787 porl557@fosstatsprd02.its.auckland.ac.nz"

export VISUAL="nvim"
export EDITOR="nvim"
