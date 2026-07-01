return {
  "NeogitOrg/neogit",
  dependencies = {
    "esmuellert/codediff.nvim",
    "m00qek/baleia.nvim",
    "folke/snacks.nvim",
  },
  config = function()
    local neogit = require("neogit")
    neogit.setup({
      mappings = {
        status = {
          ["<cr>"] = "Toggle",
          ["<tab>"] = "GoToFile",
        },
      },
      signs = {
        hunk = { "", "" },
        item = { "-", "-" },
        section = { ">", "v" },
      },
    })
    vim.keymap.set("n", "<leader>gG", function()
      neogit.open({ kind = "replace" })
    end)
  end,
}
