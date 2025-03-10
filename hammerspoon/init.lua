-- 画面分割の設定（ShiftItの代替）
hs.window.animationDuration = 0
units = {
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  top65         = { x = 0.00, y = 0.00, w = 1.00, h = 0.65 },
  bot75         = { x = 0.00, y = 0.75, w = 1.00, h = 0.75 },
  center        = { x = 0.25, y = 0.25, w = 1.00, h = 0.50 }  -- 中央寄せ
}

mash = { 'option', 'ctrl' }
hs.hotkey.bind(mash, 'right', function() hs.window.focusedWindow():move(units.right50, nil, true) end)
hs.hotkey.bind(mash, 'left', function() hs.window.focusedWindow():move(units.left50, nil, true) end)
hs.hotkey.bind(mash, 'up', function() hs.window.focusedWindow():move(units.top65, nil, true) end)
hs.hotkey.bind(mash, 'down', function() hs.window.focusedWindow():move(units.bot75, nil, true) end)
-- 中央寄せのホットキー設定
hs.hotkey.bind(mash, 'c', function() hs.window.focusedWindow():move(units.center, nil, true) end)

-- Reload Confingの設定（これをしないと設定が反映されない）
-- アプリからReload Confingを押しても良い

hs.hotkey.bind({"cmd", "alt"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")