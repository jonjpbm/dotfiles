# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/jon.duarte/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/Users/jon.duarte/.fzf/shell/key-bindings.zsh"

source <(fzf --zsh)
