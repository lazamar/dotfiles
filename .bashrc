# ~/.bashrc: executed by bash(1) for non-login shells.
# This gets run every time bash starts
# =====================================
#       Marcelo Lazaroni
# =====================================

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


# ==================== USE PORWERLINE SHELL ======================

function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# =================================================================

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

color_prompt=yes

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
alias ls='ls -G'
# Make folders appear in cyan instead of blue
export LSCOLORS=gxfxcxdxbxegedabagacad
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# Make fzf use ag and show hidden files
FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -l -g \"\""
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Always use neovim and source .vimrc file
alias vim='nvim -u ~/.vimrc'
