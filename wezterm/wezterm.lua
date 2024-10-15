-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'AdventureTime'

-- and finally, return the configuration to wezterm

-- colors
config.color_scheme = "nord"
config.window_background_opacity = 0.85


-- ショートカットキー設定
local act = wezterm.action
config.keys = {
  -- Cmd+dで新しいペインを作成(画面を分割)
  {
    key = "d",
    mods = "CMD",
    action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } },
  },
  -- Cmd+dで新しいペインを作成(画面を分割)
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } },
  },
}

return config
