local map = vim.keymap.set

local dapok, dap = pcall(require, "dap")
if not dapok then
  print("failed to load dap")
  return
end

local duiok, dapui = pcall(require, "dapui")
if not duiok then
  print("failed to load dap-ui")
  return
end

local widgets = require("dap.ui.widgets")

map("i", "kj", "<Esc>", {})
map("n", "<leader>w", "<Cmd>w<CR>", {})
map("n", "<leader>q", "<Cmd>q<CR>", {})
map("n", "<leader>wq", "<Cmd>wq<CR>", {})
map("n", "<leader>ws", "<Cmd>w<CR><Cmd>so%<CR>", {})
map("n", "<leader>e", "<Cmd>Neotree toggle<CR>", {})

map("n", "<leader>ff", "<Cmd>Telescope find_files<CR>", {})
map("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>", {})
map({ "n", "v" }, "<leader>fG", "<Cmd>Telescope grep_string<CR>", {})
map("n", "<leader>fb", "<Cmd>Telescope buffers<CR>", {})
map("n", "<leader>fh", "<Cmd>Telescope help_tags<CR>", {})

map("n", "<leader>tt", "<Cmd>ToggleTerm<CR>", {})
map("n", "<leader>to", "<Cmd>Lspsaga open_floaterm<CR>", {})
map("n", "<leader>tc", "<Cmd>Lspsaga close_floaterm<CR>", {})
map("t", "kj", [[<C-\><C-n>]], {})

-- debugging
map("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, {})
map("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, {})
map("n", "<leader>dc", function()
  dap.continue()
end, {})
map("n", "<leader>dj", function()
  dap.step_into()
end, {})
map("n", "<leader>dk", function()
  dap.step_out()
end, {})
map("n", "<leader>dl", function()
  dap.step_over()
end, {})
map("n", "<leader>du", function()
  dapui.toggle({})
end)
map("n", "<leader>dd", function()
  widgets.hover()
end)
