local jumplist = require("remaps.nvim.jumplist")
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.schedule(function()
      if BufIsSpecial() then
        return
      end
      jumplist.register(2)
    end)
  end,
})

vim.keymap.set({ "n" }, "<leader>jd", jumplist.delete)
