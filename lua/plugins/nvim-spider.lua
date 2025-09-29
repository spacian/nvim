return {
	{
		"chrisgrieser/nvim-spider",
		enabled = true,
		lazy = false,
		config = function()
			require("spider").setup()
			local opening = {
				customPatterns = { "[%wäöüÄÖÜß_]+", "[%{%[%(]+" },
				overrideDefault = true,
			}
			local closing = {
				customPatterns = { "[%wäöüÄÖÜß_]+", "[%}%]%)]+" },
				overrideDefault = true,
			}
			vim.keymap.set({ "n", "v" }, "w", function()
				require("spider").motion("w", opening)
			end)
			vim.keymap.set({ "n", "v" }, "e", function()
				require("spider").motion("e", closing)
			end)
			vim.keymap.set({ "n", "v" }, "b", function()
				require("spider").motion("b", opening)
			end)
			vim.keymap.set({ "n", "v" }, "ge", function()
				require("spider").motion("ge", closing)
			end)
		end,
	},
}
