require("general")
require("remaps")
require("config.lazy")
if not vim.g.vscode then
  require("autocmd")
  require("highlights")
end
