# Custom Oh My Zsh theme — converted from Oh My Posh config
# Replicates: @user in <white> path <white>on</> branch ›
#

# Git prompt configuration
WHITE="%F{15}"
GRAY="%F{254}"
RESET="%{$reset_color%}"

# git_prompt_colored: shows branch in red if dirty, gray if clean
function git_prompt_colored() {
  local branch
  branch=$(git_current_branch 2>/dev/null)
  if [[ -z "$branch" ]]; then
    return
  fi

  echo "${WHITE}on ${GRAY}$branch${RESET} "
}

PROMPT='${WHITE}@%n in ${GRAY}%c ${$(git_prompt_colored)}${GRAY}›${RESET} '