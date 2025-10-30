return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function parent(path)
        return path:match("^.+[/\\](.-)[/\\]?$")
      end
      local function telescope_smart_path()
        if BufIsSpecial() then
          return parent(vim.fn.getcwd())
        end
        local filepath = vim.fn.expand("%:p")
        local home = vim.fn.getcwd():lower():gsub("\\", "/")
        if filepath:sub(1, #home):lower():gsub("\\", "/") == home then
          filepath = "~" .. filepath:sub(#home + 1):gsub("\\", "/")
        end
        local max_length = 32
        if #filepath > max_length then
          local rep = "..."
          filepath = rep .. filepath:sub(#filepath - max_length + #rep, #filepath)
          filepath = filepath:gsub(rep:gsub("%.", "%.") .. ".-/", rep .. "/", 1)
        end
        local dir, filename = filepath:match("^(.-)([^/]+)$")
        if dir and filename then
          return dir .. " " .. filename
        else
          return filepath
        end
      end
      local function diagnostic(level)
        if (vim.diagnostic.count(0)[level] or 0) > 0 then
          return "●"
        else
          -- return "◌"
          return "○"
        end
      end
      local function error_ind()
        return diagnostic(vim.diagnostic.severity.ERROR)
      end
      local function warn_ind()
        return diagnostic(vim.diagnostic.severity.WARN)
      end
      local function info_ind()
        return diagnostic(vim.diagnostic.severity.INFO)
      end
      local function note_hint()
        return diagnostic(vim.diagnostic.severity.HINT)
      end
      local theme = require("lualine.themes.auto")
      theme.insert.c = theme.normal.c
      theme.visual.c = theme.normal.c
      theme.replace.c = theme.normal.c
      theme.command = theme.normal
      theme.terminal = theme.command
      theme.inactive = theme.normal
      require("lualine").setup({
        options = {
          theme = theme,
          globalstatus = true,
          component_separators = "",
          always_divide_middle = false,
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              error_ind,
              color = {
                fg = string.format(
                  "#%06X",
                  vim.api.nvim_get_hl(0, { name = "DiagnosticError", link = false }).fg
                    or vim.api.nvim_get_hl(
                      0,
                      { name = "DiagnosticError", link = false }
                    ).sp
                ),
              },
            },
            {
              warn_ind,
              color = {
                fg = string.format(
                  "#%06X",
                  vim.api.nvim_get_hl(0, { name = "DiagnosticWarn", link = false }).fg
                    or vim.api.nvim_get_hl(0, { name = "DiagnosticWarn", link = false }).sp
                ),
              },
            },
            {
              info_ind,
              color = {
                fg = string.format(
                  "#%06X",
                  vim.api.nvim_get_hl(0, { name = "DiagnosticInfo", link = false }).fg
                    or vim.api.nvim_get_hl(0, { name = "DiagnosticInfo", link = false }).sp
                ),
              },
            },
            {
              note_hint,
              color = {
                fg = string.format(
                  "#%06X",
                  vim.api.nvim_get_hl(0, { name = "DiagnosticHint", link = false }).fg
                    or vim.api.nvim_get_hl(0, { name = "DiagnosticHint", link = false }).sp
                ),
              },
            },
          },
          lualine_x = {
            { telescope_smart_path },
            { "location" },
          },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}
