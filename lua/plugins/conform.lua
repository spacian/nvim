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
      },
      formatters = {
        isort = {
          command = "isort",
          args = {
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
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 2000,
      },
    })
  end,
}
