export PATH=".:${HOME}/bin:/usr/local/bin:${PATH}"
export ZSH="$HOME/.oh-my-zsh"

fpath+=("$(brew --prefix)/share/zsh/site-functions")

alias fman="compgen -c | fzf | xargs man"
alias cpwd="pwd | awk '{printf \"%s\", \$0}' | pbcopy"

plugins=(colored-man-pages fzf git python)

source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
prompt pure

alias python="python3"
