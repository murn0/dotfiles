# tmux使用時にもSHELL統合を使用出来る様に設定
set -xg ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX YES

# SHELL統合ファイルの読み込み
set ITERM_SHELL_INTEGRATION $XDG_CONFIG_HOME/iterm2/.iterm2_shell_integration.fish
if test -f $ITERM_SHELL_INTEGRATION
  source $ITERM_SHELL_INTEGRATION
end