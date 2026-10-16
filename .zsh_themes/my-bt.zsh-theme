# My own ooverrides for bullet-train
export BULLETTRAIN_DIR_FG=black
export BULLETTRAIN_GIT_PROMPT_CMD='$(git status --porcelain=v2 --branch | awk -f ~/gitstatus.awk)'
export BULLETTRAIN_GIT_EXTENDED=0
export BULLETTRAIN_PROMPT_ORDER=(
  time
  status
  custom
  context
  dir
  screen
  perl
  ruby
  virtualenv
  aws
  go
  rust
  elixir
  git
  hg
  cmd_exec_time
)
export BULLETTRAIN_VIRTUALENV_FG=black


source $HOME/.zsh_themes/bullet_train.zsh-theme
