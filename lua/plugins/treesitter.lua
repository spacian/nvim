-- execute in x64 dev shell on windows!

return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
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

      require("nvim-treesitter").install(languages)

      local allowed = {}
      for _, lang in ipairs(languages) do
        local fts = vim.treesitter.language.get_filetypes(lang) or {}
        for _, ft in ipairs(fts) do
          allowed[ft] = lang
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = allowed[args.match]
          if lang == nil then
            return
          end

          local ok, err = pcall(vim.treesitter.start)

          if not ok then
            vim.notify(
              ("treesitter attach failed (%s): %s"):format(lang, err),
              vim.log.levels.WARN
            )
          end
        end,
      })
    end,
  },
}
