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

-- For example, changing the color scheme:
config.color_scheme = 'AdventureTime'

-- and finally, return the configuration to wezterm

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
    -- ⌘ + でフォントサイズを大きくする
    {
      key = "+",
      mods = "CMD|SHIFT",
      action = wezterm.action.IncreaseFontSize,
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
  -- ⌘  { }でタブの移動
  { key = 'LeftArrow', mods = 'CMD|SHIFT', action = act.MoveTabRelative(-1) },
  { key = 'RightArrow', mods = 'CMD|SHIFT', action = act.MoveTabRelative(1) },


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

return config
