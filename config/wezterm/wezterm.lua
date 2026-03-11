local wezterm = require "wezterm"

local config = {}
local home = os.getenv("HOME")
local theme_file = home .. "/.config/omarchy/current/theme/wezterm.lua"
local ok, theme = pcall(dofile, theme_file)

wezterm.add_to_config_reload_watch_list(theme_file)

if ok and type(theme) == "table" then
  for key, value in pairs(theme) do
    config[key] = value
  end
end

config.term = "xterm-256color"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 9.0
config.window_padding = {
  left = 14,
  right = 14,
  top = 14,
  bottom = 14,
}
config.window_decorations = "NONE"
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.audible_bell = "Disabled"
config.cursor_blink_rate = 0
config.default_cursor_style = "SteadyBlock"
config.keys = {
  { key = "Insert", mods = "CTRL", action = wezterm.action.CopyTo("Clipboard") },
  { key = "Insert", mods = "SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
  { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\x1b\r") },
}

return config
