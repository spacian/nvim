return {
  "windwp/nvim-autopairs",
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      ignored_next_char = [=[[^%)^%}^%]]]=],
    })
    autopairs.remove_rule("'")
    autopairs.remove_rule("`")
  end,
}
