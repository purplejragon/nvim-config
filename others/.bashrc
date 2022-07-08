#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='exa --icons'
PS1='\W \$ '

export PATH="$PATH:$HOME/.cargo/bin"
