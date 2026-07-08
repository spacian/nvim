local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.colorschemes" },
    { import = "plugins.helpers" },
    { import = "plugins.setup" },
  },
  install = {
    missing = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    cache = {
      enabled = false,
    },
  },
  readme = {
    enabled = false,
  },
})
