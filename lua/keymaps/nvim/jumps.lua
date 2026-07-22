local jumplist = require("keymaps.nvim.jumplist")

vim.keymap.set("n", "<leader>oj", function()
  ---@param positions Position[]
  local get_items = function(positions)
    return vim
      .iter(positions)
      :map(
        ---@param position Position
        function(position)
          local bufname = vim.fn.bufname(position.bufnr)
          return {
            text = bufname,
            file = bufname,
            pos = { position.lnum, position.col },
          }
        end
      )
      :totable()
  end
  jumplist.insert()
  require("snacks").picker.pick({
    title = "jumps",
    items = get_items(jumplist.get_positions()),
  })
end, {})
