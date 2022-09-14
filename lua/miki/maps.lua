local map = vim.keymap

map.set("i", "kj", "<Esc>", {})
map.set("n", "<leader>w", "<Cmd>w<CR>", {})
map.set("n", "<leader>q", "<Cmd>q<CR>", {})
map.set("n", "<leader>wq", "<Cmd>wq<CR>", {})
map.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", {})
map.set("n", "<leader>f", "<Cmd>lua vim.lsp.buf.format()<CR>", {})
