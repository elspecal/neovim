local ok, dap = pcall(require, "dap")
if not ok then
	print("failed to load dap plugin")
end

local duiok, dapui = pcall(require, "dapui")
if not duiok then
	print("failed to load dap-ui")
	return
end

local dvjok, dap_vscode_js = pcall(require, "dap-vscode-js")
if not dvjok then
	print("failed to load dap-vscode-js")
end

local jesterok, jester = pcall(require, "jester")
if not jesterok then
	print("failed to load jester")
end

dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = {
		os.getenv("HOME") .. "/.config/local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js",
	}, -- TODO adjust
}

dap_vscode_js.setup({
	adapters = { "pwa-node", "pwa-chrome" }, -- further adapters: pwa-msedge, node-terminal, pwa-extensionHost
})

local jestconf = {
	type = "pwa-node",
	request = "launch",
	name = "debug jest tests",
	-- trace = true, -- include debugger info
	runtimeExecutable = "node",
	runtimeArgs = {
		"./node_modules/jest/bin/jest.js",
		"--runInBand",
	},
	rootPath = "${workspaceFolder}",
	cwd = "${workspaceFolder}",
	console = "integratedTerminal",
	internalConsoleOptions = "neverOpen",
}

local vscodejsconf = {
	type = "pwa-node",
	request = "launch",
	name = "Launch pwa-node",
	program = "${file}",
	cwd = "${workspaceFolder}",
	skipFiles = { "<node_internals>/**" },
}

for _, lng in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
	require("dap").configurations[lng] = {
		vscodejsconf,
		{
			type = "pwa-node",
			request = "attach",
			name = "attach pwa-node",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		jestconf,
		{
			name = "Attach chrome",
			type = "pwa-chrome",
			request = "attach",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			port = 9222,
			webRoot = "${workspaceFolder}",
		},
	}
end

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

dapui.setup({})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({})
end

local jestpath = "./node_modules/.bin/jest"
jester.setup({
	path_to_jest_run = jestpath,
	path_to_jest_debug = jestpath,
	dap = vscodejsconf,
})
