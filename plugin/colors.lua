vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

local ok_catppuccin, catppuccin = pcall(require, "catppuccin")
if not ok_catppuccin then
  print "failed to run catppuccin color scheme"
  return
end
catppuccin.setup {}

local set_scheme = function(scheme)
  vim.cmd("colorscheme " .. scheme)
end
set_scheme "catppuccin"

local ok_autodark, auto_dark_mode = pcall(require, "auto-dark-mode")
if not ok_autodark then
  print "failed to run auto-dark-mode"
  return
end
auto_dark_mode.setup {
  set_dark_mode = function()
    vim.api.nvim_set_option("background", "dark")
    vim.g.catppuccin_flavour = "macchiato"
    set_scheme "catppuccin"
  end,
  set_light_mode = function()
    vim.api.nvim_set_option("background", "light")
    vim.g.catppuccin_flavour = "latte"
    set_scheme "catppuccin"
  end,
}
auto_dark_mode.init {}
