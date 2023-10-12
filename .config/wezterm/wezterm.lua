local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

wezterm.on('update-right-status', function(window)
    window:set_right_status(window:active_workspace())
end)

-- タブのタイトル設定
wezterm.on('format-tab-title', function(tab)
    -- Ctrl+Shift+Zでズームしたペインのタイトルに🔎を付ける
    local zoomed = tab.active_pane.is_zoomed and '🔎 ' or ' '

    return {
        { Text = zoomed .. tab.active_pane.title},
    }
end)

-- 背景の透過
wezterm.on('toggle-opacity', function(window)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.9
  else
    overrides.window_background_opacity = nil
  end
  window:set_config_overrides(overrides)
end)

-- 起動時にfishシェルをログインシェルの様に起動する(fish -l)
config.default_prog = { '/opt/homebrew/bin/fish', '-l' }
-- カラースキーム
config.color_scheme = 'Dark+'
-- IMEの使用
config.use_ime = true
-- タブが1つしかない場合は非表示
config.hide_tab_bar_if_only_one_tab = true
-- タイトルバーを非表示
config.window_decorations = "RESIZE"
config.front_end = "WebGpu"
-- 非アクティブなペインの色
config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.1,
}
config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 0,
}
-- フォント
config.font = wezterm.font_with_fallback {
  {
    family = "HackGen35 Console NF",
    weight = "Regular"
  },
  {
    family = "HackGen35 Console NF",
    weight = "Bold"
  },
}
config.font_size = 14
config.bold_brightens_ansi_colors = true
-- ベル
config.audible_bell = 'Disabled'
config.visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 100,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 100,
}
-- ショートカットキー
config.keys = {
    -- バックスラッシュが入力できない問題の対処
    { key = "¥", mods = "ALT", action = wezterm.action({ SendString = "\\" }) },
    -- 一つ前のプロンプトに移動
    { key = 'UpArrow', mods = 'CMD|SHIFT', action = act.ScrollToPrompt(-1) },
    -- 一つ後のプロンプトに移動
    { key = 'DownArrow', mods = 'CMD|SHIFT', action = act.ScrollToPrompt(1) },
    -- 横にペインを追加
    {
        key = '|',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    -- 縦にペインを追加
    {
        key = '=',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    -- ペインを閉じる
    {
        key = 'w',
        mods = 'CMD',
        action = act.CloseCurrentPane { confirm = false },
    },
    -- ペインをズーム
    {
        key = 'z',
        mods = 'CTRL|SHIFT',
        action = act.TogglePaneZoomState,
    },
    -- ペインのサイズ変更
    {
        key = 'LeftArrow',
        mods = 'CMD',
        action = act.AdjustPaneSize { 'Left', 2 }
    },
    {
        key = 'DownArrow',
        mods = 'CMD',
        action = act.AdjustPaneSize { 'Down', 2 }
    },
    {
        key = 'UpArrow',
        mods = 'CMD',
        action = act.AdjustPaneSize { 'Up', 2 }
    },
    {
        key = 'RightArrow',
        mods = 'CMD',
        action = act.AdjustPaneSize { 'Right', 2 }
    },
    -- ペインの移動
    {
      key = 'LeftArrow',
      mods = 'CMD|SHIFT',
      action = act.RotatePanes 'CounterClockwise',
    },
    {
      key = 'RightArrow',
      mods = 'CMD|SHIFT',
      action = act.RotatePanes 'Clockwise',
    },
    {
      key = 'k',
      mods = 'CTRL|SHIFT',
      action = act.ScrollByLine(-1)
    },
    {
      key = 'j',
      mods = 'CTRL|SHIFT',
      action = act.ScrollByLine(1)
    },
    -- ワークスペースの一覧を表示
    {
        key = '9',
        mods = 'ALT',
        action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
    -- ワークスペースの名前を入力して作成
    {
        key = 'W',
        mods = 'CTRL|SHIFT',
        action = act.PromptInputLine {
            description = wezterm.format {
            { Attribute = { Intensity = 'Bold' } },
            { Foreground = { AnsiColor = 'Fuchsia' } },
            { Text = 'Enter name for new workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
            -- lineは何も入力せずにEscapedした場合はnilになり、Enterした場合は空文字列になる
            if line then
                window:perform_action(
                act.SwitchToWorkspace {
                    name = line,
                },
                pane
                )
            end
            end),
        },
    },
    -- 背景色の透明化のトグル
    {
      key = 'B',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.EmitEvent 'toggle-opacity',
    },
}

--- 3クリックでコマンド全体を選択する
config.mouse_bindings = {
    {
        event = { Down = { streak = 3, button = 'Left' } },
        action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
        mods = 'NONE',
    },
}


return config
