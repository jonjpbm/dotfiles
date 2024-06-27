# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/jon.duarte/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/${USER}/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/${USER}/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/Users/${USER}/.fzf/shell/key-bindings.zsh"
