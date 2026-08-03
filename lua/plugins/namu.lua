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
            window = {
              title_prefix = "/ ",
            },
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
              prefix_icon = " ",
            },
          },
        },
        ui_select = { enable = false },
        colorscheme = { enable = false },
      })

      vim.keymap.set("n", "<leader>os", function()
        Jumplist.register()
        vim.cmd("Namu symbols")
      end, { silent = true })
    end,
  },
}
