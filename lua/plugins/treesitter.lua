-- execute in x64 dev shell on windows!

return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = false,
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "bash",
        "csv",
        "go",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "powershell",
        "python",
        "toml",
        "regex",
        "vimdoc",
        "xml",
        "yaml",
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
