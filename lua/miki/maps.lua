local map = vim.keymap

map.set("i", "kj", "<Esc>", {})
map.set("n", "<leader>w", "<Cmd>w<CR>", {})
map.set("n", "<leader>q", "<Cmd>q<CR>", {})
map.set("n", "<leader>wq", "<Cmd>wq<CR>", {})
map.set("n", "<leader>ws", "<Cmd>w<CR><Cmd>so%<CR>", {})
map.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", {})
map.set("n", "<leader>f", "<Cmd>lua vim.lsp.buf.format()<CR>", {})

map.set("n", "<leader>ff", "<Cmd>Telescope find_files<CR>", {})
map.set("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>", {})
map.set("n", "<leader>fb", "<Cmd>Telescope buffers<CR>", {})
map.set("n", "<leader>fh", "<Cmd>Telescope help_tags<CR>", {})

map.set("n", "<leader>tt", "<Cmd>ToggleTerm<CR>", {})
map.set("t", "kj", [[<C-\><C-n>]], {})
