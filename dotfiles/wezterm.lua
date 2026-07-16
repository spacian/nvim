local wezterm = require("wezterm")

wezterm.on("format-window-title", function()
  return "$"
end)

wezterm.on("format-tab-title", function(tab)
  return "        " .. tostring(tab.tab_index) .. "        "
end)

local activate_venv = wezterm.action_callback(function(window, pane)
  local cwd = pane:get_current_working_dir()

  if not cwd or not cwd.file_path then
    return
  end

  local activate = wezterm.target_triple:find("windows")
      and cwd.file_path:sub(2) .. "/.venv/Scripts/activate"
    or cwd.file_path .. "/.venv/bin/activate"

  if #wezterm.glob(activate) == 0 then
    return
  end
  if wezterm.target_triple:find("windows") then
    window:perform_action(
      wezterm.action.SendString("./.venv/Scripts/activate" .. "\r"),
      pane
    )
  else
    window:perform_action(
      wezterm.action.SendString("./.venv/bin/activate" .. "\r"),
      pane
    )
  end
end)

local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.default_prog = { "pwsh.exe", "-NoLogo" }
config.font = wezterm.font("CommitMono Nerd Font Mono")
config.warn_about_missing_glyphs = false
config.font_size = 17
config.window_close_confirmation = "NeverPrompt"
config.exit_behavior = "Close"
config.default_cursor_style = "SteadyBlock"
config.cursor_blink_rate = 0

local act = wezterm.action

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
  {
    key = "e",
    mods = "LEADER",
    action = activate_venv,
  },
  {
    key = "d",
    mods = "LEADER",
    action = wezterm.action_callback(function(window, pane)
      window:perform_action(wezterm.action.SendString("deactivate\r"), pane)
    end),
  },
  -- split panes
  {
    key = "J",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitPane({
      direction = "Down",
      command = {
        domain = "CurrentPaneDomain",
      },
    }),
  },
  {
    key = "K",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitPane({
      direction = "Up",
      command = {
        domain = "CurrentPaneDomain",
      },
    }),
  },
  {
    key = "H",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitPane({
      direction = "Left",
      command = {
        domain = "CurrentPaneDomain",
      },
    }),
  },
  {
    key = "L",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitPane({
      direction = "Right",
      command = {
        domain = "CurrentPaneDomain",
      },
    }),
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
    action = wezterm.action.SpawnCommandInNewTab({
      domain = "CurrentPaneDomain",
    }),
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

return config
