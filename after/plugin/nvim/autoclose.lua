require("autoclose").setup({
	keys = {
		["`"] = { escape = false, close = false, pair = "``" },
	},
	options = {
		disable_when_touch = true,
		touch_regex = "[^%s]",
	},
})
