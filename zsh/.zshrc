# Custom Variables
EDITOR=nvim

# vi mode
bindkey -v
bindkey '^R' history-incremental-search-backward

# for go bineries
export PATH=$PATH:$(go env GOPATH)/bin
#Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

#https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fzf
#https://github.com/junegunn/fzf?tab=readme-ov-file#installation
#export FZF_COMPLETION_TRIGGER=''
#export FZF_DEFAULT_OPTS='--height 40%'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse' 

#---- asdf ----#
export ASDF_HASHICORP_OVERWRITE_ARCH_TERRAFORM=amd64


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

#brew install of curl
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

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

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000000000
HISTSIZE=1000000000
#setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
#setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
#setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

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

# https://github.com/ajeetdsouza/zoxide#environment-variables
_ZO_ECHO=1

#----------------- evals ---------------------#
eval "$(gh copilot alias -- zsh)"

# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

#starship
eval "$(starship init zsh)"

# https://developer.1password.com/docs/cli/reference/commands/completion/#load-shell-completion-information-for-zsh
eval "$(op completion zsh)"; compdef _op op

# https://direnv.net/docs/hook.html
eval "$(direnv hook zsh)"

# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#homebrew
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load ; should be last.
#https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/#enable-shell-autocompletion
# NOTE: This needed to go after the autoload compinit for some reason
source <(kubectl completion zsh)

#----------------- fzf -----------------------#
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# AWSCLI
complete -C '/usr/local/bin/aws_completer' aws

source /Users/jon.duarte/.config/broot/launcher/bash/br

complete -o nospace -C /Users/jon.duarte/.asdf/installs/terramate/0.5.3/bin/terramate terramate
