return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        ["*"] = { "trim_newlines", "trim_whitespace" },
        json = { "prettier", "jq" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "isort", "black" },
        toml = { "taplo" },
        yaml = { "prettier" },
        xml = { "xmlformatter" },
      },
      formatters = {
        isort = {
          command = "isort",
          args = {
            "--profile",
            "black",
            "--stdout",
            "--filename",
            "$FILENAME",
            "-",
          },
        },
        taplo = {
          append_args = {
            "--option",
            "indent_string=    ",
          },
        },
      },
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf, timeout_ms = 2000 })
      end,
    })
  end,
}
