return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup({ signs = false })

    local set = vim.keymap.set

    set({ "n" }, "<up>", function()
      mc.lineAddCursor(-1)
    end)

    set({ "n" }, "<down>", function()
      mc.lineAddCursor(1)
    end)

    set({ "n" }, "<leader><up>", function()
      mc.lineSkipCursor(-1)
    end)

    set({ "n" }, "<leader><down>", function()
      mc.lineSkipCursor(1)
    end)

    set({ "n" }, "<c-q>", mc.toggleCursor)
    set("n", "<leader>cr", mc.restoreCursors)

    mc.addKeymapLayer(function(layerSet)
      layerSet({ "n" }, "<left>", mc.prevCursor)
      layerSet({ "n" }, "<right>", mc.nextCursor)

      layerSet("n", "<leader>t", function()
        mc.action(function(ctx)
          if ctx:cursorsEnabled() then
            ctx:setCursorsEnabled(false)
          else
            ctx:setCursorsEnabled(true)
          end
        end)
      end)

      layerSet("n", "<esc>", function()
        mc.action(function(ctx)
          if not ctx:cursorsEnabled() then
            ctx:setCursorsEnabled(true)
          else
            ctx:clear()
          end
        end)
      end)
    end)
  end,
}
