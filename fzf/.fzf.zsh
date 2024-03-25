# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/jon.duarte/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/jon.duarte/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/jon.duarte/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/Users/jon.duarte/.fzf/shell/key-bindings.zsh"
