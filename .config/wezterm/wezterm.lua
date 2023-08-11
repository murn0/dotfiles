local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(window:active_workspace())
end)

-- 起動時の設定
wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})

    -- ペインの分割設定
    pane:split { direction = 'Left', size = 0.95 }
    pane:split { direction = 'Bottom', size = 0.5 }
end)

-- 起動時にfishシェルをログインシェルの様に起動する(fish -l)
config.default_prog = { '/opt/homebrew/bin/fish', '-l' }
-- カラースキーム
config.color_scheme = 'Dark+'
-- IMEの使用
config.use_ime = true
-- タブバーを下に表示
config.tab_bar_at_bottom = true
-- 非アクティブなペインの色
config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.1,
}
-- フォント
config.font = wezterm.font('HackGen35 Console NF', { weight = 'Regular' })
config.font_size = 13.3
-- 背景透過
config.window_background_opacity = 0.9
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
        mods = 'CMD',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    -- 縦にペインを追加
    {
        key = '-',
        mods = 'CMD|SHIFT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    -- ペインを閉じる
    {
        key = 'w',
        mods = 'CMD',
        action = act.CloseCurrentPane { confirm = false },
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