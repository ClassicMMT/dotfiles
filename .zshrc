# Prompt character
#export PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '
#export PS1="$ " # "%~" gives the directory
export PS1="~ "

# Basic aliases
alias nv="nvim"
alias vmr2="ssh -L 8787:localhost:8787 porl557@fosstatsprd02.its.auckland.ac.nz"
alias vmr3="ssh -L 8787:localhost:8787 porl557@fosstatsprd03.its.auckland.ac.nz"
alias vmr4="ssh -L 8787:localhost:8787 porl557@fosstatsprd02.its.auckland.ac.nz"

export VISUAL="nvim"
export EDITOR="nvim"

# Terminal theme
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Theme -- to configure, run: "p10k configure"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi





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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# history bindings
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# autosuggestions -- install by running: brew install zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# silence homebrew
HOMEBREW_NO_AUTO_UPDATE=1

# Syntax highlighting -- install by running: brew install zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Better ls -- install by running: brew install eza
alias lse="eza --color=always -l"
