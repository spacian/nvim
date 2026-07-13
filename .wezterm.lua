local wezterm = require("wezterm")

wezterm.on("format-window-title", function()
  return ""
end)

local config = wezterm.config_builder()
local act = wezterm.action

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
  -- split panes
  {
    key = "+",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitHorizontal({}),
  },
  {
    key = "-",
    mods = "LEADER",
    action = wezterm.action.SplitVertical({}),
  },

  -- navigate panes
  {
    key = "h",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    key = "j",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },

  -- new tab
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },

  -- close pane
  {
    key = "x",
    mods = "LEADER",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },

  -- rename tab
  {
    key = "r",
    mods = "LEADER",
    action = wezterm.action.PromptInputLine({
      description = "Rename tab:",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },

  -- cycle tabs
  {
    key = "n",
    mods = "LEADER",
    action = act.ActivateTabRelative(1),
  },
  {
    key = "p",
    mods = "LEADER",
    action = act.ActivateTabRelative(-1),
  },
}

-- jump to id
for i = 0, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i),
  })
end

config.hide_tab_bar_if_only_one_tab = true
config.default_prog = { "pwsh.exe", "-NoLogo" }
config.font = wezterm.font("CommitMono Nerd Font Mono")
config.font_size = 18.0
config.window_close_confirmation = "NeverPrompt"
config.exit_behavior = "Close"

return config
