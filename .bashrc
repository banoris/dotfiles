# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

# fuzzy bash completion {
#source ~/fuzzy_bash_completion/fuzzy_bash_completion
#fuzzy_replace_filedir_xspec
# }

# OpenGrok setting
export CATALINA_HOME=/usr/share/tomcat8/
export OPENGROK_TOMCAT_BASE=$CATALINA_HOME
export OPENGROK_INSTANCE_BASE=/home/biskhand/opengrok/test/local_src
#export OPENGROK_INSTANCE_BASE=/home/biskhand/opengrok/test/android_src
export PATH=$PATH:/home/biskhand/opengrok/opengrok-1.0/bin

# android setting
export PATH=$PATH:$HOME/bin
export USE_CCACHE=1
export CCACHE_DIR=$HOME/.cache
export ANDROID_ADB_SERVER_PORT=5038  # 5037 prob when reflashing

# my alias
alias v='vim'
alias gvr='gvim --remote-tab'
alias noti='notify-send -t 0'
alias gl='git log --name-status'
alias gst='git status'
alias install='sudo apt install'
alias k='konsole'
alias grep='grep --color=auto'
alias cdsdb='cd /media/biskhand/9ff82023-a237-4dbe-8ce6-7dda14da6e11/home/biskhand'
alias sshped='ssh biskhand@ped-gms'
alias noti='notify-send -t 0'
alias dl='wget --no-check-certificate --user=biskhand --ask-password'
alias sbashrc='source ~/.bashrc'
alias dirs='dirs -v'
alias h='history | cut -c 8- | v -' # cut is to remove the numbers in history
alias less='less -i'
alias gsr='grep -srn'

# my variables
SDB='/media/biskhand/9ff82023-a237-4dbe-8ce6-7dda14da6e11/home/biskhand'

### BEGIN mysetting {

# check these two in ~/.inputrc
#set completion-ignore-case on  # ignorecase tab completion
#set show-all-if-ambiguous on   # 
export PS1='\[\e[1;96m\][\u@\h \w] \D{%a %H:%M}\n\$\[\e[m\] '

# less setting
#export LESS='-i'

### END mysetting }

### BEGIN bashfunction ### {

# Download and unzip flashfile
function dluz {
	dl $1;
	unzip $(basename $1);
	noti DL_UNZIP_COMPLETE;
}

# cp and unzip $1 to $2
function cpuz {
	cp $1 $2;
    echo 'cp done, unzipping...'
	unzip "$2/$(basename $1)" -d $2;
	noti CP_UNZIP_COMPLETE;
}

# save cd history, type `dirs` to show directories
# cd ~2  --> will cd to second directory in `dirs` output
# TODO: fix `cd -` not working
function c () {
	if [ -e $1 ]
	then 
		pushd $1 &> /dev/null   #dont display current stack 
	fi
}

### END bashfunction ### }

# enable autojump -- https://github.com/wting/autojump
if [ -e /usr/share/autojump/autojump.sh ]; then
	. /usr/share/autojump/autojump.sh
fi

# enable forward search in bash  https://stackoverflow.com/questions/791765/unable-to-forward-search-bash-history-similarly-as-with-ctrl-r
stty -ixon



