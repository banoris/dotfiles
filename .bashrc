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
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

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

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


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
#export CATALINA_HOME=/usr/share/tomcat8/
#export OPENGROK_TOMCAT_BASE=$CATALINA_HOME
#export OPENGROK_INSTANCE_BASE=/home/biskhand/opengrok/test/local_src
##export OPENGROK_INSTANCE_BASE=/home/biskhand/opengrok/test/android_src
#export PATH=$PATH:/home/biskhand/opengrok/opengrok-1.0/bin

set -o ignoreeof # disable CTRL-D to close terminal

# Perforce setting
export PATH=$PATH:/opt/perforce/p4v-2017.3.1592764/bin
# android setting
export PATH=$PATH:$HOME/bin
export USE_CCACHE=1
export CCACHE_DIR=$HOME/.cache
export ANDROID_ADB_SERVER_PORT=5037  # 5037 prob when reflashing
export PATH=$PATH:$HOME/Android/Sdk/build-tools/27.0.1

# BEGIN alias {{{
# start with 'asd' for personal alias namespace
alias v='vim -p'
alias v-='vim -'
alias gvr='gvim --remote-tab'
alias asdnoti='notify-send -t 0'
alias install='sudo apt install'
alias k='konsole'
alias grep='grep --color=auto'
alias asdsshfast='ssh -XC -c blowfish-cbc,arcfour'
alias noti='notify-send -t 0'
alias dl='wget --no-check-certificate --user=biskhand --ask-password'
alias asdbashrc='source ~/.bashrc'
alias dirs='dirs -v'
alias h='history | cut -c 8- | v -' # cut is to remove the numbers in history
alias gr='grep -srnI'
alias datelog='date +"%Y_%b_%d_%H_%M"'
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."
alias cd5="cd ../../../../.."

alias adb1='adb -s R1J56L64e0f8df'
alias adb2='adb -s R1J56L68fb9966'
alias adb21='adb -s R1J56L32b70674'
alias parallel='parallel --will-cite'

# END alias }}}

### BEGIN variables {{{

# https://stackoverflow.com/questions/10517128/change-gnome-terminal-title-to-reflect-the-current-directory
PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD})\007"' # display only current dir as title
export SER1=R1J56L64e0f8df
export SER2=R1J56L68fb9966
export SER3=R1J56L2006cc32

### END variables }}}

### BEGIN mysetting {{{

# Aggregate history of all terminals in the same .history. https://cfenollosa.com/misc/tricks.txt
# shopt -s histappend
# export HISTSIZE=100000
# export HISTFILESIZE=100000
# export HISTCONTROL=ignoredups:erasedups
# export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"  # all terminal will be dirtied with other cmds from diff terminal

# check these two in ~/.inputrc
#set completion-ignore-case on
#set show-all-if-ambiguous on
if [ -f ~/.inputrc ]; then
    bind -f ~/.inputrc
fi
# TODO: check server or local machine, use diff color to remind that you are inside server's shell
export PS1="\[\e[1;36m\][\u@\h \w]\e[35m\$(parse_git_branch)\e[0m\e[1;36m \D{%a %H:%M:%S}\n\$\[\e[m\] "

# less setting
#export LESS='-XFR'
# -R: remove the ESC\ color thingy, set this so color shows up nicely. -i: case-insensitive search
# -S: no wrap
export LESS='-SiR'

### END mysetting }}}

### BEGIN bashfunction {{{

# e.g. mylog $SER1 -- get logcat from device $SER1
function mylog() {
    adb -s $1 logcat -G 5M
    adb -s $1 logcat -d RouteManager:S PFW:S MDL:S CFG:S AudioStreamOut:S AudioStreamIn:S AudioIntelHal:S _ENV:S CarPowerManagerNative:S PowerTestService:S AVB_CONFIG:S _AMN:S _ASH:S ioc_cbc:S ioc_cbcd:S CarDrivingState:S AudioStreamIn:S CBCProto:S _PTP:S chatty:S IOCDeviceCBC:S DPTF:S _TX1:S _TX2:S ConnectivityService:S wpa_supplicant:S ioc_slcand:S _RXE:S PhoneDoctor:S AudioIntelHal/AudioPlatformState/Pfw:S qtaguid:S NetworkManagementSocketTagger:S DG.WV:S GPTP:S IOC_COMM:S EvsApp:S PowerUI:S ioc_cbcd:S CarDrivingState:S AudioStreamIn:S CBCProto:S _PTP:S chatty:S IOCDeviceCBC:S DPTF:S _TX1:S _TX2:S ConnectivityService:S wpa_supplicant:S ioc_slcand:S _RXE:S PhoneDoctor:S AudioIntelHal/AudioPlatformState/Pfw:S qtaguid:S NetworkManagementSocketTagger:S DG.WV:S GPTP:S IOC_COMM:S EvsApp:S PowerUI:S SensorsHal:S ThermalHal:S RZN:S EVT:S ROU:S SMW:S SMJ:S SXP:S SXC:S BFT:S WifiHAL:S HvacModule:S | vim -
}

# Download and unzip flashfile
function dluz {
	dl $1;
	unzip $(basename $1);
	touch ./* # change the file timestamp to current timetouch * # change the file timestamp to current time
	noti DL_UNZIP_COMPLETE;
}

# cp and unzip $1 to $2
function cpuz {
	echo 'Copying........'
	cp $1 $2;
	echo 'cp done, unzipping...'
	unzip "$2/$(basename $1)" -d $2;
	touch $2/* # change the file timestamp to current time
	noti CP_UNZIP_COMPLETE;
}

# save cd history, type `dirs` to show directories
# cd ~2  --> will cd to second directory in `dirs` output
# TODO: fix `cd -` not working
function cd1() {
	if [ -e $1 ]
	then 
		pushd $1 &> /dev/null   #dont display current stack 
	fi
}

# function to set terminal title (gnome-terminal)
function set-title(){
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

### END bashfunction }}}

# enable autojump -- https://github.com/wting/autojump
if [ -e /usr/share/autojump/autojump.sh ]; then
	. /usr/share/autojump/autojump.sh
fi

# enable forward search in bash  https://stackoverflow.com/questions/791765/unable-to-forward-search-bash-history-similarly-as-with-ctrl-r
stty -ixon


if [ -f ~/.proxy.sh ]; then
    . ~/.proxy.sh
fi


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[[ -f ~/dotfiles/.grc/grc.bashrc ]] && source ~/dotfiles/.grc/grc.bashrc

