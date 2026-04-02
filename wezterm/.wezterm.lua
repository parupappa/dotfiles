-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {
}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Default Font Size
config.font_size = 11.0

-- This is where you actually apply your config choices
config.use_ime = true
config.automatically_reload_config = true

-- colors
config.color_scheme = "nord"
config.window_background_opacity = 0.85
config.macos_window_background_blur = 10

-- 現在有効なtabに色をつける
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"

  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
  end

  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
  }
end)

-- キーバインド
local act = wezterm.action
config.keys = {
  -- ⌘ n で新しいウィンドウを画面右半分に配置して開く
  {
    key = 'n',
    mods = 'CMD',
    action = wezterm.action_callback(function(win, pane)
      local screen = wezterm.gui.screens().active
      local tab, _, new_win = wezterm.mux.spawn_window({})
      local gui_win = new_win:gui_window()
      gui_win:set_position(screen.x + math.floor(screen.width / 2), screen.y)
      gui_win:set_inner_size(math.floor(screen.width / 2), screen.height)
    end),
  },
  -- ⌘ + でフォントサイズを大きくする
  {
    key = "+",
    mods = "CMD|SHIFT",
    action = wezterm.action.IncreaseFontSize,
  },
  -- Shift+Enterで改行を送信
  {
    key = "Enter",
    mods = "SHIFT",
    action = wezterm.action.SendString('\n'),
  },
  -- ⌘ w でペインを閉じる（デフォルトではタブが閉じる）
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  -- ⌘ dで新しいペインを作成(画面を分割)
  {
    key = "d",
    mods = "CMD",
    action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } },
  },
  -- ⌘ ⇧ dで新しいペインを作成(画面を分割)
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } },
  },
  -- ⌘ { } でタブの切り替え（Cmd+Shift+[ / Cmd+Shift+]）
  { key = '[', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(1) },
  -- ⌘ ⌥ 左右矢印でタブの切り替え
  { key = 'LeftArrow',  mods = 'CMD|OPT', action = act.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CMD|OPT', action = act.ActivateTabRelative(1) },

  -- ⌘ 矢印でペインの移動
  {
    key = 'LeftArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'DownArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'UpArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'RightArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
}

-- 起動時に画面右半分のサイズ・位置で表示
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  local gui_win = window:gui_window()
  local screen = wezterm.gui.screens().active
  gui_win:set_position(screen.x + screen.width / 2, screen.y)
  gui_win:set_inner_size(screen.width / 2, screen.height)
end)

-- システムベル音を有効化（Claude Codeのタスク完了通知用）
config.audible_bell = "SystemBeep"

return config
