return {
  {
    "bassamsdata/namu.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    config = function()
      require("namu").setup({
        namu_symbols = {
          enable = true,
          options = {
            multiselect = {
              enabled = false,
            },
            movement = {
              next = { "<c-j>" },
              previous = { "<c-k>" },
            },
            current_highlight = {
              enabled = true,
              hl_group = "PmenuSel",
              prefix_icon = " ", -- ▎ 󰇙 ┆
            },
          },
        },
        ui_select = { enable = false },
        colorscheme = { enable = false },
      })

      local jumplist = require("remaps.nvim.jumplist")
      vim.keymap.set("n", "<leader>os", function()
        jumplist.register(1)
        vim.cmd("Namu symbols")
      end, { silent = true })
    end,
  },
}
