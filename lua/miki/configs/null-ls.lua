local ok, nls = pcall(require, "null-ls")
if not ok then
	print("failed to load null-ls")
	return
end

nls.setup({
	sources = {
		nls.builtins.code_actions.eslint_d,
		nls.builtins.code_actions.gitsigns,
		nls.builtins.diagnostics.djlint,
		nls.builtins.diagnostics.djlint,
		nls.builtins.diagnostics.eslint_d,
		nls.builtins.diagnostics.golangci_lint,
		-- nls.builtins.diagnostics.pylint.with({ prefer_local = true }),
		nls.builtins.diagnostics.flake8,
		nls.builtins.diagnostics.yamllint,
		nls.builtins.formatting.beautysh,
		nls.builtins.formatting.black,
		nls.builtins.formatting.eslint_d,
		nls.builtins.formatting.gofumpt,
		nls.builtins.formatting.goimports,
		nls.builtins.formatting.jq,
		nls.builtins.formatting.stylua,
		nls.builtins.formatting.yamlfmt,
	},
})
