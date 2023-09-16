#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

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
    PS1='[${debian_chroot:+($debian_chroot)}\[\033[m\]|\[\033[00;37m\]\A\[\033[m\]| \[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]]$ '
else
    PS1='[${debian_chroot:+($debian_chroot)}\A \u:\w]$ '
fi
unset color_prompt force_color_prompt

# enable bash-git-prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=0
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Vi mode
set  -o vi
bind -m vi-command '"v":""'
bind -m vi-insert  "\C-w":backward-kill-word
bind -m vi-command '"\C-y": "\C-z\ec\C-z"'
bind -m vi-insert '"\C-y": "\C-z\ec\C-z"'

# disable Ctrl-s
stty -ixon 

# preserve bash history across multiple sessions
export HISTCONTROL=ignoreboth:erasedups # no duplicate entries
export HISTSIZE=100000                  # big big history
export HISTFILESIZE=100000              # big big history
shopt -s histappend                     # append to history, don't overwrite it
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

source ~/.aliases

# Fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND="fd -uu -H -i -a -E '.git' -E '*cache*' -E '.rustup' -E '.trash' -E '.virtualenv'"
export RG_DEFAULT_COMMAND="rg --hidden --line-number --no-heading --color=always --smart-case --max-columns=80 --"
export FZF_DEFAULT_OPTS="-m --height 50% --border --ansi --prompt 'File> '       --bind 'start:unbind(change)+enable-search'     --bind 'change:reload($RG_DEFAULT_COMMAND {q} {} || true)'     --bind 'backward-eof:change-prompt(File> )+reload($FZF_DEFAULT_COMMAND . ../)'     --bind 'ctrl-y:change-prompt(File> )+reload($FZF_DEFAULT_COMMAND . ~)'     --bind 'ctrl-t:change-prompt(File> )+reload($FZF_DEFAULT_COMMAND . /)'     --bind 'ctrl-c:execute(echo -ne {+} | yank)+close'     --bind 'ctrl-o:execute($EDITOR {+} > /dev/tty)+abort'     --bind 'ctrl-e:execute(lfr {} > /dev/tty)+clear-query'     --bind 'ctrl-g:rebind(change)+clear-query+change-prompt(Grep> )+reload($RG_DEFAULT_COMMAND {q} {})+unbind(change)'     --bind 'del:execute(mv {+} ~/.trash/)'     --bind 'ctrl-b:page-up'     --bind 'space:page-down'     --bind 'ctrl-w:select-all'     --bind 'ctrl-d:close'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
