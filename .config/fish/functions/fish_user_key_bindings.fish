function fish_user_key_bindings

  # Ctrl+c : Zのディレクトリ移動履歴をfzfで表示
  bind \cc zi
  # fzf.fishのキーバインド
  # Ctrl+r : コマンド履歴検索, Ctrl+s : ファイル、ディレクトリパス検索, Ctrl+v : 変数検索, Ctrl+g : git log検索
  fzf_configure_bindings --history=\cr --directory=\cs --variables=\cv --git_log=\cg --git_status --processes
  
end