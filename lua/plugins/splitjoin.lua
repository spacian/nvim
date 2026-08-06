return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local sj = require("treesj")
    sj.setup({ use_default_keymaps = false })
    vim.keymap.set("n", "<leader>l", sj.toggle)
  end,
}
