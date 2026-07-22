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
          update_cadence = "manual",
        })

        vim.api.nvim_create_autocmd("FileType", {
          pattern = "text",
          callback = function(args)
            vim.treesitter.start(args.buf, "markdown")
          end,
        })

        vim.keymap.set(
          { "x" },
          "v",
          function()
            if vim.treesitter.get_parser(nil, nil, { error = false }) then
              require("vim.treesitter._select").select_parent(vim.v.count1)
            else
              vim.lsp.buf.selection_range(vim.v.count1)
            end
          end,
          { desc = "Select parent treesitter node or outer incremental lsp selections" }
        )

        vim.keymap.set(
          { "x" },
          "V",
          function()
            if vim.treesitter.get_parser(nil, nil, { error = false }) then
              require("vim.treesitter._select").select_child(vim.v.count1)
            else
              vim.lsp.buf.selection_range(-vim.v.count1)
            end
          end,
          { desc = "Select child treesitter node or inner incremental lsp selections" }
        )

        vim.api.nvim_exec_autocmds("User", { pattern = "TreesitterSetupDone" })
      end,
    })
  end,
}
