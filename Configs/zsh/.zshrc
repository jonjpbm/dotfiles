#--------- Environment Variables ---------#

export NVIM_APPNAME=nvim-kickstart

# asdf
export ASDF_HASHICORP_OVERWRITE_ARCH_TERRAFORM=amd64
# For user bineries
export PATH=$PATH:${HOME}/bin

# for go bineries
#export PATH=$PATH:$(go env GOPATH)/bin

#Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

#kubectl
export KUBE_EDITOR="nvim"

# Added by Windsurf
export PATH="/Users/jon.duarte/.codeium/windsurf/bin:$PATH"

export EDITOR="nvim"

# Get list of gnubin directories
# brew install coreutils ed findutils gawk gnu-sed gnu-tar grep make binutils diffutils gnu-which watch wdiff wget make
export GNUBINS="$(find /opt/homebrew/opt -type d -follow -name gnubin -print)";

for bindir in ${GNUBINS[@]}; do
  export PATH=$bindir:$PATH;
done;

#--------- Custom Variables ---------#


#--------- Shell options ---------#
##https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

HISTFILE=~/.zsh_history  # Set the history file location.
HISTSIZE=10000           # Set the number of commands to store in memory.
SAVEHIST=10000           # Set the number of commands to save to the history file.
setopt inc_append_history # Append new history entries to the history file immediately, rather than overwriting the file at the end of a session. This prevents losing history if your shell crashes.
setopt share_history     # Share history between different zsh sessions.
setopt hist_ignore_dups  # Don't record duplicate commands in history.
setopt hist_ignore_space # Ignore commands that start with a space. This is useful for preventing sensitive commands from being recorded.
setopt hist_reduce_blanks # Remove extra blank spaces from commands in history.

# To source in aliases and functions
for file in ~/.*.zsh; do
    source $file
done

#--------- Completion System ---------#
# initialise completions with ZSH's compinit
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand_alias _complete _ignored
zstyle ':completion:*' regular true
zmodload zsh/complist
compinit -i
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

#ghcli completions
fpath=(${ZDOTDIR:-$HOME}/completions $fpath)

# AWSCLI
#complete -C '/usr/local/bin/aws_completer' aws

# Load ; should be last.
#https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/#enable-shell-autocompletion
# NOTE: This needed to go after the autoload compinit for some reason
[[ $commands[kubectl] ]] && source <(kubectl completion zsh) # add autocomplete permanently to your zsh shell

# https://developer.1password.com/docs/cli/reference/commands/completion/#load-shell-completion-information-for-zsh
eval "$(op completion zsh)"; compdef _op op

#--------- Plugin Managers ---------#

## Theme and Prompt
## https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#homebrew
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
##https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
##https://github.com/jeffreytse/zsh-vi-mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh


#--------- External Tool Configurations ---------#
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

eval "$(${HOME}/.local/bin/mise activate zsh)"

#starship
eval "$(starship init zsh)"

#pipx
eval "$(register-python-argcomplete pipx)"

# you need this if you want kubectl code completion to
# work with kubecolor
# https://github.com/hidetatz/kubecolor/issues/32
compdef kubecolor=kubectl

# Added by Windsurf
export PATH="/Users/jon.duarte/.codeium/windsurf/bin:$PATH"

complete -o nospace -C /Users/jon.duarte/.local/share/mise/installs/terramate/0.8.4/terramate terramate

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jon.duarte/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jon.duarte/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jon.duarte/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jon.duarte/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
