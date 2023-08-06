local wezterm = require('wezterm')
local act = wezterm.action
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

config.color_scheme = 'Ayu Mirage'
config.font_size = 14
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.80
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.audible_bell  = "Disabled"

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "pwsh.exe" }
  config.win32_system_backdrop = 'Acrylic'
end

-- keybinds
config.leader = {
  key = 't',
  mods = 'CTRL',
  timeout_milliseconds = 1000
}

config.keys = {
  { key = "h", mods = "LEADER", action=act({ActivatePaneDirection="Left"})},
  { key = "j", mods = "LEADER", action=act({ActivatePaneDirection="Down"})},
  { key = "k", mods = "LEADER", action=act({ActivatePaneDirection="Up"})},
  { key = "l", mods = "LEADER", action=act({ActivatePaneDirection="Right"})},
  { key = '=', mods = 'LEADER', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' })},
  { key = '-', mods = 'LEADER', action = act.SplitVertical({ domain = 'CurrentPaneDomain' })},
  { key = "]", mods="LEADER", action="TogglePaneZoomState" },
  { key = "p", mods="LEADER", action=act({PasteFrom='Clipboard'})},
  { key = "y", mods="LEADER", action=act({CopyTo="Clipboard"})},
  { key = 'o', mods = 'LEADER', action =act.PaneSelect },
  { key = 'f', mods = 'SHIFT|CTRL', action = act.Search({ CaseInSensitiveString = '' })},
  -- activate copy mode shift ctrl x
}

return config
