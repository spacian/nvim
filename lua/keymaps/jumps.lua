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
  Jumplist.insert()
  require("snacks").picker.pick({
    title = "jumps",
    items = get_items(Jumplist.get_positions()),
  })
end, {})
