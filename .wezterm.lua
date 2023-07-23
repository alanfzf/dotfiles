local wezterm = require('wezterm')
local config = {}

config.color_schemes = {
  ['One Half Dark (Modded)'] = {
    background = '#001B26',
    foreground = "#DCDFE4",
    cursor_bg = '#FFFFFF',
    cursor_fg = '#001B26',
    ansi = {
      "#282C34",
      "#E06C75",
      "#98C379",
      "#E5C07B",
      "#61AFEF",
      "#C678DD",
      "#56B6C2",
      "#DCDFE4",
    },
    brights  = {
      "#5A6374",
      "#E06C75",
      "#98C379",
      "#E5C07B",
      "#61AFEF",
      "#C678DD",
      "#56B6C2",
      "#DCDFE4",
    }
  }
}

config.color_scheme = "One Half Dark (Modded)"
config.font_size = 14
config.hide_tab_bar_if_only_one_tab = true
config.win32_system_backdrop = 'Acrylic'
config.window_background_opacity = 0.55
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "pwsh.exe" }
  -- table.insert(config.launch_menu, { label = "PowerShell", args = {"powershell.exe", "-NoLogo"} })
end

-- keybinds
config.leader = { 
  key = 'a', 
  mods = 'CTRL', 
  timeout_milliseconds = 1000
}
config.keys = {
  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  { key = 'a', mods = 'LEADER|CTRL', action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' }},
  { key = "h", mods = "LEADER", action=wezterm.action({ActivatePaneDirection="Left"})},
  { key = "j", mods = "LEADER", action=wezterm.action({ActivatePaneDirection="Down"})},
  { key = "k", mods = "LEADER", action=wezterm.action({ActivatePaneDirection="Up"})},
  { key = "l", mods = "LEADER", action=wezterm.action({ActivatePaneDirection="Right"})},
  { key = '-', mods = 'LEADER', action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' })},
  { key = '=', mods = 'LEADER', action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' })},
  { key = "]", mods="LEADER", action="TogglePaneZoomState" },
}

return config
