# Custom Variables
EDITOR=nvim

# vi mode
bindkey -v

# for go bineries
export PATH=$PATH:$(go env GOPATH)/bin
#Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

#https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#brew install of curl
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

#---- TFENV ----#
export TFENV_ARCH=amd64

#---- asdf ----#
export ASDF_HASHICORP_OVERWRITE_ARCH_TERRAFORM=amd64

# fzf
#https://github.com/junegunn/fzf?tab=readme-ov-file#installation
#export FZF_COMPLETION_TRIGGER=''
export FZF_DEFAULT_OPTS='--height 40%'

#Mcfly
export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=1
export MCFLY_RESULTS=20
export MCFLY_RESULTS_SORT=LAST_RUN

# Options to fzf command
# export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

#brew install coreutils
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

#brew install gawk
PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"

#brew install gsed
PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

#brew install grep
PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jon.duarte/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jon.duarte/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jon.duarte/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jon.duarte/google-cloud-sdk/completion.zsh.inc'; fi

# To source in aliases and functions
for file in ~/.*.zsh; do
    source $file
done

#ghcli completions
fpath=(${ZDOTDIR:-$HOME}/completions $fpath)

# https://asdf-vm.com/guide/getting-started.html
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

. "$HOME/.asdf/asdf.sh"

# initialise completions with ZSH's compinit
autoload -U +X bashcompinit && bashcompinit
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand_alias _complete _ignored
zstyle ':completion:*' regular true
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# https://github.com/cantino/mcfly
eval "$(mcfly init zsh)"


eval "$(gh copilot alias -- zsh)"

# https://github.com/ajeetdsouza/zoxide#environment-variables
_ZO_ECHO=1
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

#starship
eval "$(starship init zsh)"

# Change cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select

# Load ; should be last.
#https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/#enable-shell-autocompletion
# NOTE: This needed to go after the autoload compinit for some reason
source <(kubectl completion zsh)

# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#homebrew
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# AWSCLI
complete -C '/usr/local/bin/aws_completer' aws
