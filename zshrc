# If you come from bash you might have to change your $PATH.
export PATH=".:${HOME}/bin:/usr/local/bin:${PATH}"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Aliases
alias fman="compgen -c | fzf | xargs man"
alias cpwd="pwd | awk '{printf \"%s\", \$0}' | pbcopy"
alias uvt="source .venv/bin/activate"

# 100M lines / 2Gb
HISTSIZE=100000000
HISTFILESIZE=2000000000

plugins=(colored-man-pages fzf git python)

source $ZSH/oh-my-zsh.sh

# Change GOPATH to hidden directory
GOPATH=$HOME/.go
