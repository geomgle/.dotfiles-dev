override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Custom"


  #Overrides the prompt_callback function used by bash-git-prompt
  function prompt_callback {
    GIT_CONTAINER_FOLDER_FULLPATH=$(git rev-parse --show-toplevel 2> /dev/null)
    GIT_CONTAINER_FOLDER=$(basename $GIT_CONTAINER_FOLDER_FULLPATH 2> /dev/null)
    CURRENT_FULLPATH=$(pwd)
    local PS1=$GIT_CONTAINER_FOLDER${CURRENT_FULLPATH#$GIT_CONTAINER_FOLDER_FULLPATH}
    gp_set_window_title "$PS1"
    echo "${BoldBlue}${PS1}${ResetColor}"
  }

  Time12a="\$(date +%H:%M)"
  GIT_PROMPT_BRANCH="${Magenta}"        # the git branch that is active in the current directory
  GIT_PROMPT_MASTER_BRANCH="${White}" # used if the git branch that is active in the current directory is $GIT_PROMPT_MASTER_BRANCHES

  GIT_PROMPT_PREFIX="["
  GIT_PROMPT_SUFFIX="]"
  GIT_PROMPT_SEPARATOR=""              # separates each item
  GIT_PROMPT_STAGED=" ${Green}●"           # the number of staged files/directories
  GIT_PROMPT_CONFLICTS=" ${Red}❮❮"       # the number of files in conflict
  GIT_PROMPT_CHANGED=" ${Yellow}✚."        # the number of changed files

  GIT_PROMPT_REMOTE=" "                 # the remote branch name (if any) and the symbols for ahead and behind
  GIT_PROMPT_UNTRACKED=" ${Cyan}…"       # the number of untracked files/dirs
  GIT_PROMPT_STASHED=" ${Cyan}⚑"    # the number of stashed files/dir
  GIT_PROMPT_CLEAN=" ${Green}❯❯"      # a colored flag indicating a "clean" repo
  GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING="${Red}✭"

  GIT_PROMPT_COMMAND_OK="${Green}❯❯"    # indicator if the last command returned with an exit code of 0
  GIT_PROMPT_COMMAND_FAIL="${Red}❮❮ _LAST_COMMAND_STATE_"    # indicator if the last command returned with an exit code of other than 0
  
  local gp_start="${Green}\u@\h${ResetColor} _LAST_COMMAND_INDICATOR_"
  local gp_end="\n${White}${Time12a}${ResetColor} ❯❯"

  GIT_PROMPT_START_USER="\n${gp_start} "
  GIT_PROMPT_END_USER="${gp_end} "
  
  #GIT_PROMPT_SYMBOLS_AHEAD="↑·"
  GIT_PROMPT_SYMBOLS_AHEAD="↑⬆."
  #GIT_PROMPT_SYMBOLS_BEHIND="↓·"
  GIT_PROMPT_SYMBOLS_BEHIND="↓⬇."
}

reload_git_prompt_colors "Custom" 
