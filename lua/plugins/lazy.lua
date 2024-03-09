local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VimEnter",
    },
    {
        "gbprod/substitute.nvim",
        version = "*",
        event = "VimEnter",
        opts = {},
    },
})
