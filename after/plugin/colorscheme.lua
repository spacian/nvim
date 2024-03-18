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
    vim.cmd("colorscheme kanagawa")
end
