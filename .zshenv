# Set user variables based on XDG Base Directory Specification.
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# zshの設定ファイルパスを定義
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZSETTINGS=$ZDOTDIR/settings
# .lesshstを作成しない
export LESSHISTFILE=-