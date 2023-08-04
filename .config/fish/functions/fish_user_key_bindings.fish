function fish_user_key_bindings

  # Ctrl+z : Zのディレクトリ移動履歴をfzfで表示
  bind \cz zi
  # fzf.fishのキーバインド
  # Ctrl+r : コマンド履歴検索, Ctrl+f : ファイル、ディレクトリパス検索, Ctrl+v : 変数検索, Ctrl+l : git log検索
  fzf_configure_bindings --history=\cr --directory=\cf --variables=\cv --git_log=\cl --git_status --processes

end