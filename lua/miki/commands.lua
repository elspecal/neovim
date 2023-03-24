local au = vim.api.nvim_create_autocmd
local usrcmd = vim.api.nvim_create_user_command

au("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({})
	end,
})

local wremote = function()
	local current = vim.fn.expand("%:p")
	local user = "mcsepella"
	local hostname = "mcsepella.dev.hearsaylabs.com"
	local remotepath = string.gsub(current or "/Users/mcsepella/", "^/Users", "/home")
	local command = string.format("scp -Cpq %s %s", current, user .. "@" .. hostname .. ":" .. remotepath)

	io.popen(command)
	vim.api.nvim_input("<CR>")
	print(command)
end

au("BufWritePost", {
	pattern = os.getenv("HOME") .. "/projects/HearsayLabs*",
	callback = wremote,
})

local set_indent = function(opts)
	local indent = tonumber(opts.args)

	vim.o.shiftwidth = indent
	vim.o.tabstop = indent
end

usrcmd("SetIndent", set_indent, { nargs = 1 })

au("FileType", {
	pattern = { "lua" },
	command = "SetIndent 2",
})
