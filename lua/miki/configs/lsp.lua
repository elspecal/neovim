local ok_luadev, neodev = pcall(require, "neodev")
if not ok_luadev then
	print("failed to load lua-dev")
end
neodev.setup({})

local ok_lspconf, lspconf = pcall(require, "lspconfig")
if not ok_lspconf then
	print("failed to start lsp configuraiton")
	return
end

local ok_cmp, cmp = pcall(require, "cmp")
if not ok_cmp then
	print("failed to load cmp")
	return
end

local ok_cmplsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not ok_cmplsp then
	print("failed to load cmp-lsp")
	return
end

local servers = {
	cssls = {},
	golangci_lint_ls = {},
	gopls = {},
	html = {},
	jsonls = {},
	prismals = {},
	pylsp = {},
	-- pyright = {},
	sumneko_lua = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
	tsserver = {},
	yamlls = {},
}

local ok_schemastore, schemastore = pcall(require, "schemastore")
if not ok_schemastore then
	print("failed to load schema store")
else
	servers.jsonls.settings = {
		json = {
			schemas = schemastore.json.schemas(),
			validate = { enable = true },
		},
	}
end

local with_snippet_support = {
	cssls = true,
	html = true,
	jsonls = true,
}

local format = function()
	vim.lsp.buf.format({
		filter = function(_client)
			return _client.name == "null-ls"
		end,
	})
end

local on_attach = function(client, _)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", { callback = format })
	end

	local map = vim.keymap.set

	map("n", "gD", vim.lsp.buf.declaration, {})
	map("n", "gi", vim.lsp.buf.implementation, {})
	map("n", "gr", vim.lsp.buf.references, {})
	map({ "n", "v" }, "<leader>fm", format, {})
	map("n", "gd", "<Cmd>Lspsaga peek_definition<CR>", {})
	map("n", "<leader>fc", "<Cmd>Lspsaga lsp_finder<CR>", {})
	map("n", "<leader>c", "<Cmd>Lspsaga code_action<CR>", {})
	map("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", {})
	map("n", "<leader>dl", "<Cmd>Lspsaga show_line_diagnostics<CR>", {})
	map("n", "<leader>dc", "<Cmd>Lspsaga show_cursor_diagnostics<CR>", {})
	map("n", "<leader>dp", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", {})
	map("n", "<leader>dn", "<Cmd>Lspsaga diagnostic_jump_next<CR>", {})
	map("n", "K", "<Cmd>Lspsaga hover_doc<CR>", {})

	--[[ vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, opts)
		end,
		command = "Lspsaga show_cursor_diagnostics",
	}) ]]
end

local capabilities = cmp_lsp.default_capabilities()
local options = {
	on_attach = on_attach,
	capabilities = capabilities,
}

for server, opts in pairs(servers) do
	opts = vim.tbl_deep_extend("force", {}, options, opts or {})

	if with_snippet_support[server] ~= nil then
		opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
	end
	if server == "tsserver" then
		local ok_ts, typescript = pcall(require, "typescript")
		if not ok_ts then
			print("failed to load the typescript plugin")
		else
			typescript.setup({ server = opts })
		end
	else
		lspconf[server].setup(opts)
	end
end

local ok_luasnip, luasnip = pcall(require, "luasnip")
if not ok_luasnip then
	print("failed to load luasnip")
	return
end

require("luasnip.loaders.from_vscode").lazy_load()

local ok_lspkind, lspkind = pcall(require, "lspkind")
if not ok_lspkind then
	print("failed to load the lspkind plugin")
	return
end

local ok_autopairs, autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not ok_autopairs then
	print("failed to load nvim-autopairs.completion.cmp")
else
	cmp.event:on("confirm_done", autopairs.on_confirm_done())
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "path" },
	}),
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			--[[ menu = {
        buffer = "[buf]",
        cmdline = "[cmd]",
        luasnip = "[snip]",
        nvim_lsp = "[lsp]",
        nvim_lua = "[lua]",
        path = "[path]",
      }, ]]
		}),
	},
})
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

local signs = {
	Error = " ",
	Warn = " ",
	Info = " ",
	Hint = "ﴞ ",
}
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	virtual_text = false,
})
