local function buffer_in_float(buf)
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      return true
    end
  end
  return false
end

---@param bufnr number|nil
---@return boolean
function BufIsSpecial(bufnr)
  bufnr = bufnr or 0
  return not vim.api.nvim_buf_is_valid(bufnr) and not buffer_in_float(bufnr)
    or vim.api.nvim_buf_get_name(bufnr) == ""
    or vim.bo[bufnr].buftype ~= ""
end

function Feedkeys(keys)
  local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(feedable_keys, "n", false)
end

function MergeHL(group, opts)
  opts = opts or {}
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, {
    name = group,
    link = false,
  })
  if not ok then
    return {}
  end
  while hl and hl.link do
    local next = vim.api.nvim_get_hl(0, { name = hl.link, link = false })
    hl = vim.tbl_extend("force", hl, next or {})
  end
  hl.link = nil
  return vim.tbl_extend("force", hl, opts)
end

vim.opt.shortmess:append("I")
vim.o.wrap = true
vim.o.signcolumn = "yes:1"
vim.o.foldcolumn = "0"
vim.o.number = true
vim.o.statuscolumn = "%l%s"
vim.opt.numberwidth = 3
vim.opt.fillchars = { eob = " " }
vim.opt.formatoptions:remove("t")
vim.o.textwidth = 0
vim.o.cursorline = true
vim.o.cmdheight = 1
vim.o.showcmd = false
vim.o.ruler = false
vim.o.showmode = false
vim.o.jumpoptions = "stack,view"
vim.opt.sessionoptions:remove("terminal")
vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "hiddenoff",
  "algorithm:histogram",
  "indent-heuristic",
  "linematch:200",
  "context:99999",
}

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.cmd("language en_US")
else
  vim.o.wildignorecase = true
end

vim.o.shada = ""
vim.o.splitright = true
vim.o.timeoutlen = 2250
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.bo.softtabstop = 4
