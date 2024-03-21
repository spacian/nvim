if not vim.g.vscode then
    require('kanagawa').setup({
        commentStyle = { italic = false },
        functionStyle = {},
        keywordStyle = { italic = false},
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)
            return {
                ["@variable.builtin"] = { italic = false },
            }
        end,
        theme = "wave",
        background = {
            dark = "wave",
            light = "lotus"
        },
    })
    require("solarized-osaka").setup({
        transparent = false,
        terminal_colors = true,
        styles = {
            comments = { italic = false },
            keywords = { italic = false },
            functions = {},
            variables = {},
            sidebars = "dark",
            floats = "dark",
        },
        sidebars = { "qf", "help" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
        on_colors = function(colors) end,
        on_highlights = function(highlights, colors) end,
    })
    -- vim.cmd("colorscheme solarized-osaka")
    vim.cmd("colorscheme kanagawa")
end
