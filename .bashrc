# ~/.bashrc: executed by bash(1) for non-login shells.
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

# ==============================================================================
# Prompt with GIT info
# ==============================================================================

function prompt_setup {
    # Some colors
    local TXT_WHITE="\e[97m"
    local TXT_GREY="\e[90m"
    local TXT_BLUE="\e[34m"
    local TXT_BLACK="\e[30m"
    local TXT_YELLOW="\e[93m"
    local TXT_DEFAULT="\e[39m"
    local TXT_BOLD="\e[1m"
    local TXT_BOLD_RESET="\e[0m"
    local BG_WHITE="\e[107m"
    local BG_GREEN="\e[100m"
    local BG_BLUE="\e[44m"
    local BG_DEFAULT="\e[49m"
    local INFO_USER="\u"
    local INFO_PATH="\w\a"
    local INFO_GIT=


    local __git_info="$(__git_ps1)"
    local __git_branch="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
    local __git_icon=

    # colour branch name depending on state
    if [[ "$__git_info" =~ "*" ]]; then     # if repository is dirty
        __git_icon="⚡"
    elif [[ "$__git_info" =~ "$" ]]; then   # if there is something stashed
        __git_icon="stashed"
    elif [[ "$__git_info" =~ "%" ]]; then   # if there are only untracked files
        __git_icon="untracked"
    elif [[ "$__git_info" =~ "+" ]]; then   # if there are staged files
        __git_icon="*"
    else                                    # nothing to commit
        __git_icon=
    fi

    local BLOCK_GIT=
    # We only show the git block if we are in a git repository
    if [ "$__git_branch" != "" ]; then
        INFO_GIT="$__git_branch $TXT_YELLOW$__git_icon"
        BLOCK_GIT="$TXT_BOLD$BG_BLUE$TXT_WHITE  $INFO_GIT $TXT_BOLD_RESET$TXT_BLUE"
    else
        BLOCK_GIT=
    fi

    BLOCK_USER="$BG_WHITE$TXT_BOLD$TXT_BLACK $INFO_USER $TXT_BOLD_RESET$TXT_WHITE"
    BLOCK_PATH="$BG_GREEN$TXT_WHITE $INFO_PATH$TXT_GREY"
    BLOCK_END="$BG_DEFAULT$TXT_DEFAULT$TXT_BOLD_RESET \n$ "
    PS1="$BLOCK_USER$BLOCK_PATH $BLOCK_GIT$BLOCK_END"
}

# configure PROMPT_COMMAND which is executed each time the prompt is rendered
export PROMPT_COMMAND=prompt_setup

# ==============================================================================

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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

# Configure __git_ps1 to show branch and status
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_HIDE_IF_PWD_IGNORED=true
GIT_PS1_SHOWCOLORHINTS=true

# Disable Ctrl-S binding so I can use it in Vim
bind -r '\C-s'
stty -ixon

export NVM_DIR="/home/marcelo/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
