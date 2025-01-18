local vscode = require("vscode")

function Nvim_feedkeys(keys)
	local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(feedable_keys, "n", false)
end

function Call(arg)
	Nvim_feedkeys(string.format(":call %s<enter>", arg))
end

function Vsc_notify(arg, opt)
	vscode.action(arg, opt)
end

function Vsc_call(arg, opt)
	vscode.call(arg, opt)
end

function Center()
	Vsc_notify("center-editor-window.center")
end

function Register_jump(i)
	i = i or ""
	Vsc_call("jumplist.registerJump" .. i)
end

function Jump_back(i)
	i = i or ""
	Vsc_notify("jumplist.jumpBack" .. i)
end

function Jump_forw(i)
	i = i or ""
	Vsc_notify("jumplist.jumpForward" .. i)
end
