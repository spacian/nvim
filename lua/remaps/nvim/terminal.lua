if vim.loop.os_uname().sysname == "Windows_NT" then
	vim.keymap.set({ "t" }, "<c-e>", [[python -c "import sys; print(sys.executable)"<enter>]], { noremap = true })
else
	vim.keymap.set({ "t" }, "<c-e>", [[python3 -c "import sys; print(sys.executable)"<enter>]], { noremap = true })
end

vim.api.nvim_create_user_command("TW", function()
	local buffer_name = vim.api.nvim_buf_get_name(0)
	if string.find(buffer_name, "^oil://") ~= nil or string.find(buffer_name, "^replacer://") ~= nil then
		return
	end
	if vim.loop.os_uname().sysname == "Windows_NT" then
		vim.cmd("term powershell")
		vim.fn.feedkeys("a")
		vim.fn.feedkeys("cls" .. vim.api.nvim_replace_termcodes("<enter>", true, true, true))
	else
		vim.cmd("term")
		vim.fn.feedkeys("a")
	end
end, {})

vim.api.nvim_create_user_command("TF", function()
	local buffer_name = vim.api.nvim_buf_get_name(0)
	if string.find(buffer_name, "^oil://") ~= nil or string.find(buffer_name, "^replacer://") ~= nil then
		return
	end
	local path = vim.fn.expand("%:p:h")
	local enter = vim.api.nvim_replace_termcodes("<enter>", true, true, true)
	if vim.loop.os_uname().sysname == "Windows_NT" then
		vim.cmd("term powershell")
		vim.fn.feedkeys("a")
		vim.fn.feedkeys("cd " .. path:gsub("\\", "/") .. enter)
		vim.fn.feedkeys("cls" .. enter)
	else
		vim.cmd("term")
		vim.fn.feedkeys("a")
		vim.fn.feedkeys("cd " .. path .. enter)
		vim.fn.feedkeys("clear" .. enter)
	end
end, {})

vim.api.nvim_create_user_command("TE", function()
	if vim.loop.os_uname().sysname == "Windows_NT" then
		vim.cmd("term powershell")
		vim.fn.feedkeys("a")
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes(".venv/Scripts/activate<enter>cls<enter>", true, true, true))
	else
		vim.cmd("term")
		vim.fn.feedkeys("a")
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes(".venv/bin/activate<enter>", true, true, true))
	end
end, {})

if vim.loop.os_uname().sysname == "Windows_NT" then
	vim.api.nvim_create_user_command("TP", function()
		vim.cmd("term powershell")
		vim.fn.feedkeys("a")
	end, {})
end
