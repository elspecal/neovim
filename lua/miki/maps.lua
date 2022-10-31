local map = vim.keymap.set




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
