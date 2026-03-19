echo "Add WezTerm as an alternative terminal option"

if [[ ! -f ~/.config/wezterm/wezterm.lua ]]; then
  mkdir -p ~/.config/wezterm
  cp -Rpf "$OMARCHY_PATH/config/wezterm/wezterm.lua" ~/.config/wezterm/wezterm.lua
fi

if omarchy-cmd-present wezterm; then
  mkdir -p ~/.local/share/applications
  cp "$OMARCHY_PATH/applications/WezTerm.desktop" ~/.local/share/applications/org.wezfurlong.wezterm.desktop
fi

TERMINALS_CONF=~/.config/hypr/apps/terminals.conf
if [[ -f $TERMINALS_CONF ]] && ! grep -q "org.wezfurlong.wezterm" "$TERMINALS_CONF"; then
  sed -i 's/(Alacritty|kitty|com.mitchellh.ghostty)/(Alacritty|kitty|com.mitchellh.ghostty|org.wezfurlong.wezterm)/' "$TERMINALS_CONF"
fi

INPUT_CONF=~/.config/hypr/input.conf
if [[ -f $INPUT_CONF ]] && ! grep -q "org.wezfurlong.wezterm" "$INPUT_CONF"; then
  sed -i 's/(Alacritty|kitty)/(Alacritty|kitty|org.wezfurlong.wezterm)/' "$INPUT_CONF"
fi

WAYBAR_CONFIG=~/.config/waybar/config.jsonc
if [[ -f $WAYBAR_CONFIG ]] && grep -q '"on-click-right": "alacritty"' "$WAYBAR_CONFIG"; then
  sed -i 's|"on-click-right": "alacritty"|"on-click-right": "xdg-terminal-exec"|' "$WAYBAR_CONFIG"
  omarchy-state set restart-waybar-required
fi
