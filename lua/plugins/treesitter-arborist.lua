return {

  "https://github.com/arborist-ts/arborist.nvim",
  enabled = true,
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "MasonToolsUpdateCompleted",
      callback = function()
        local languages = {
          "bash",
          "csv",
          "go",
          "json",
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
        }

        require("arborist").setup({
          ensure_installed = languages,
          prefer_wasm = false,
          install_popular = false,
          disable = { indent = languages },
        })

        vim.api.nvim_exec_autocmds("User", { pattern = "TreesitterSetupDone" })
      end,
    })
  end,
}
