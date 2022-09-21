local au = vim.api.nvim_create_autocmd
local usrcmd = vim.api.nvim_create_user_command

au("TextYankPost", {
  callback = function()
    vim.highlight.on_yank {}
  end,
})

local set_indent = function(opts)
  local indent = tonumber(opts.args)

  vim.o.shiftwidth = indent
  vim.o.tabstop = indent
end

usrcmd("SetIndent", set_indent, { nargs = 1 })
