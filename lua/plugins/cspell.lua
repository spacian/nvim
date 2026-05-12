return {
  {
    "spacian/cspell.nvim",
    enabled = not vim.g.vscode,
    lazy = false,
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    config = function()
      local cspell_last_session = ""
      local force_cspell_reload = false
      vim.api.nvim_create_user_command("CSpellReload", function()
        if BufIsSpecial() then
          print("cannot reload from special buffer")
          return
        end
        force_cspell_reload = true
        vim.cmd("noa w|e")
      end, {})

      local null_ls = require("null-ls")
      null_ls.setup({
        fallback_severity = vim.diagnostic.severity.HINT,
        sources = {
          require("cspell").diagnostics.with({
            config = {
              cspell_import_files = function(_)
                return {
                  vim.fn.expand("$APPDATA")
                    .. "/npm/node_modules/@cspell/dict-de-de/cspell-ext.json",
                }
              end,
              cwd = function(_)
                return vim.fn.getcwd()
              end,
              reset_cspell = function(params)
                if
                  params ~= nil
                  and params.cwd ~= nil
                  and (vim.v.this_session ~= cspell_last_session or force_cspell_reload)
                then
                  cspell_last_session = vim.v.this_session
                  force_cspell_reload = false
                  return true
                else
                  return false
                end
              end,
            },
          }),
        },
      })
    end,
  },
}
