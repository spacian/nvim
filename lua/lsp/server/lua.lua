vim.lsp.config("lua_ls", {
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.semanticTokensProvider = false
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        vim.loop.fs_stat(path .. "/.luarc.json")
        or vim.loop.fs_stat(path .. "/.luarc.jsonc")
      then
        return
      end
    end
    client.config.settings.Lua =
      vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
      })
  end,
  settings = {
    Lua = {
      format = { enable = false },
    },
  },
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
vim.lsp.enable("lua_ls")
