require("remaps.code.utils")

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  callback = function()
    Register_jump()
    Register_jump(1)
  end,
})

local jump_keys = {
  ["/"] = "",
  ["?"] = "",
  ["#"] = "",
  ["*"] = "",
  ["gg"] = "gg^",
  ["G"] = "G$",
  ["<c-r>"] = "",
  ["u"] = "",
  ["U"] = "",
}

for key, map in pairs(jump_keys) do
  if string.len(map) == 0 then
    map = key
  end
  vim.keymap.set({ "n" }, key, function()
    Register_jump()
    if vim.v.count > 0 then
      Nvim_feedkeys(vim.v.count .. map)
    else
      Nvim_feedkeys(map)
    end
  end)
end
