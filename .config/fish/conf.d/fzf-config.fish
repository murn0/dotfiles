# fd検索結果から.gitディレクトリを除外
set fzf_fd_opts --hidden --exclude=.git
# ディレクトリのプレビューにexaを使用
set fzf_preview_dir_cmd exa -la --icons --header --group --time-style=long-iso --all --color=always
# fzfオプションの指定
set -gx FZF_DEFAULT_OPTS '
    --cycle 
    --layout=reverse 
    --border 
    --height=90% 
    --preview-window=wrap 
    --marker="*" 
    --color=border:#605f5f 
    --color=fg+:#ffaf00,bg+:#434C5E
'