#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source ~/.aliases

export FZF_DEFAULT_COMMAND="fd -uu -H -i -a -E '.git' -E '*cache*' -E '.rustup' -E '.trash' -E '.virtualenv'"
export RG_DEFAULT_COMMAND="rg --hidden --line-number --no-heading --color=always --smart-case --max-columns=80 --"
export FZF_DEFAULT_OPTS="-m --height 50% --border --ansi --prompt 'File> '       --bind 'start:unbind(change)+enable-search'     --bind 'change:reload($RG_DEFAULT_COMMAND {q} {} || true)'     --bind 'backward-eof:change-prompt(File> )+reload($FZF_DEFAULT_COMMAND . ../)'     --bind 'ctrl-y:change-prompt(File> )+reload($FZF_DEFAULT_COMMAND . ~)'     --bind 'ctrl-t:change-prompt(File> )+reload($FZF_DEFAULT_COMMAND . /)'     --bind 'ctrl-c:execute(echo -ne {+} | yank)+close'     --bind 'ctrl-o:execute($EDITOR {+} > /dev/tty)+abort'     --bind 'ctrl-e:execute(lfr {} > /dev/tty)+clear-query'     --bind 'ctrl-g:rebind(change)+clear-query+change-prompt(Grep> )+reload($RG_DEFAULT_COMMAND {q} {})+unbind(change)'     --bind 'del:execute(mv {+} ~/.trash/)'     --bind 'ctrl-b:page-up'     --bind 'space:page-down'     --bind 'ctrl-w:select-all'     --bind 'ctrl-d:close'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
