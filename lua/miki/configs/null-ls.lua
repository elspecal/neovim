local ok, nls = pcall(require, "null-ls")
if not ok then
  print("failed to load null-ls")
  return
end

nls.setup({
  sources = {
    nls.builtins.code_actions.gitsigns,
    nls.builtins.diagnostics.eslint_d,
    nls.builtins.diagnostics.flake8,
    nls.builtins.diagnostics.golangci_lint,
    nls.builtins.diagnostics.yamllint,
    nls.builtins.formatting.black,
    nls.builtins.formatting.gofumpt,
    nls.builtins.formatting.goimports,
    nls.builtins.formatting.prettierd,
    nls.builtins.formatting.eslint_d,
    nls.builtins.formatting.stylua,
    nls.builtins.formatting.beautysh,
    nls.builtins.formatting.yamlfmt,
  },
})
