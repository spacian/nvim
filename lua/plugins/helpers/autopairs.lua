return {
  "windwp/nvim-autopairs",
  config = function()
    local autopairs = require("nvim-autopairs")
    local strings = {
      "string",
      "string_literal",
      "template_string",
      "raw_string_literal",
    }
    autopairs.setup({
      check_ts = true,
      ts_config = {
        lua = strings,
        python = strings,
      },
      ignored_next_char = [=[[^%)^%}^%]]]=],
      disable_in_visualblock = true,
      enable_bracket_in_quote = false,
      enable_afterquote = false,
    })
    autopairs.remove_rule("'")
    autopairs.remove_rule("`")
    autopairs.remove_rule('"""')
    autopairs.remove_rule('"')
  end,
}
