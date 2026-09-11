#--------- General Aliases ---------#
# List files
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# Safety nets
alias mv='mv -v'

# Shortcuts
alias cls='clear'
alias grep='grep --color=auto'

#--------- Editor Aliases ---------#
alias v='nvim'
alias vim='nvim'

#--------- Git Aliases ---------#
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

#--------- Directory Navigation ---------#
# Using zoxide if available
#alias cd='z'

#--------- System ---------#
alias reload='source ~/.zshrc'

#--------- Custom Aliases ---------#
# Add your custom aliases below
alias tree='tre'
alias tm='terramate'
alias tf='terraform'
