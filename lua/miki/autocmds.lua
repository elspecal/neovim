local au = vim.api.nvim_create_autocmd

au("TextYankPost", {
  callback = function()
    vim.highlight.on_yank {}
  end,
})

au("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end,
})
