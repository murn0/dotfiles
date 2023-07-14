# fzfのオプション設定
set -Ux _ZO_FZF_OPTS '
    --cycle 
    --layout=reverse 
    --border 
    --height=90% 
    --preview-window=wrap 
    --marker="*" 
    --color=border:#605f5f 
    --color=fg+:#ffaf00,bg+:#434C5E 
    --preview=\'exa -la {2..}\'
'

# zoxideのDB保存場所
set -gx _ZO_DATA_DIR "$HOME/.local/share/zoxide"

if command -v zoxide &>/dev/null
    zoxide init fish | source
end