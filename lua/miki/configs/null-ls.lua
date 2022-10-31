local ok, nullls = pcall(require, "null-ls")
if not ok then
  print("failed to load null-ls")
  return
end

nullls.setup({
  sources = {
    nullls.builtins.code_actions.gitsigns,
    nullls.builtins.diagnostics.eslint_d,
    nullls.builtins.diagnostics.flake8,
    nullls.builtins.diagnostics.golangci_lint,
    nullls.builtins.diagnostics.yamllint,
    nullls.builtins.formatting.black,
    nullls.builtins.formatting.gofumpt,
    nullls.builtins.formatting.goimports,
    nullls.builtins.formatting.prettierd,
    nullls.builtins.formatting.eslint_d,
    nullls.builtins.formatting.stylua,
    nullls.builtins.formatting.beautysh,
    nullls.builtins.formatting.yamlfmt,
  },
})
