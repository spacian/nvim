---@param str string
---@param char string | nil
---@return string
local function trim(str, char)
  char = char or " "
  local l = 1
  while str:sub(l, l) == char do
    l = l + 1
  end
  local r = #str
  while str:sub(r, r) == char do
    r = r - 1
  end
  return str:sub(l, r)
end

return {
  {
    "spacian/lsp_signature.nvim",
    enabled = not vim.g.vscode,
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = {
          border = "rounded",
        },
        hint_prefix = "",
        always_trigger = true,
        max_width = function()
          return vim.api.nvim_win_get_width(0)
        end,
        hint_inline = function()
          return false
        end,
        hint_customization = function(hint)
          hint = trim(hint)
          if vim.endswith(hint, ":") then
            return hint:sub(1, #hint - 1)
          end
          return hint
        end,
        floating_window = false,
        max_height = 1,
        toggle_key = "<c-s>",
      })
    end,
  },
}
