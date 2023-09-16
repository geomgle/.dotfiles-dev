-- Leader and esc
vim.g.mapleader = ","
vim.keymap.set("n", ";", ":")
vim.keymap.set("x", ";", ":")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "ㅓㅓ", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "ㅓㅏ", "<Esc>")

-- File
vim.keymap.set("n", "<leader>vr", "<cmd>w|so|PackerSync<cr>")
vim.keymap.set({"n", "x", "i"}, "<F3>", '<Esc><cmd>lua require("utils").nvim_exec("w")<cr>', {noremap = true})
vim.keymap.set({"n", "x", "i"}, "<F4>", require("utils").quit_if_last_buffer)
vim.keymap.set({"n", "x", "i"}, "<C-d>", require("utils").quit_if_last_buffer)
vim.keymap.set("n", "<C-q>", "<cmd>confirm qall<cr>")
vim.keymap.set("n", "<leader>fo", "<cmd>copen<cr>")
vim.keymap.set("n", "[f", "<cmd>cprevious<cr>")
vim.keymap.set("n", "]f", "<cmd>cnext<cr>")

-- Movement
vim.keymap.set({"n", "x"}, "<left>", "<cmd>bp<cr>")
vim.keymap.set({"n", "x"}, "<right>", "<cmd>bn<cr>")
vim.keymap.set({"n", "x"}, "<space>", "<C-d>")
vim.keymap.set({"n", "x"}, "t", "<C-u>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<leader>j", "J")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "{", "{gezz", {noremap = true})
vim.keymap.set("n", "}", "}wzz", {noremap = true})

-- Edit
vim.keymap.set("i", "<C-v>", "<C-r>+")
vim.keymap.set("n", "Y", "yiW")
vim.keymap.set("n", "U", "<cmd>redo<cr>")
vim.keymap.set("n", "<F12>", "<cmd>set paste!<cr>")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("n", "@@", "@:")
vim.keymap.set("n", "gp", "`[v`]")
vim.keymap.set("n", "<leader>aa", "ggVG")

-- Visual
vim.keymap.set("x", "iu", "f_hoF_lo")
vim.keymap.set("x", "au", "f_oF_o")
vim.keymap.set("x", "i.", "t.oT.o")
vim.keymap.set("o", "i.", "<cmd><C-u>exec 'normal v' . v:count1 . 'i.'<cr>")

-- Use blackhole register for substituting with OSC52 system clipboard
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("x", "c", '"_c')
vim.keymap.set("n", "C", '"+c')
vim.keymap.set("x", "C", '"+c')

-- Remove highlight for search result
vim.keymap.set("n", "<leader><space>", '<cmd>let @/=""<cr><cmd>nohlsearch<cr>')

-- Trim all whitespaces away
vim.keymap.set("n", "<leader>W", "<cmd>%s/\\s\\+$//<cr>")

-- Delete all other buffers
vim.keymap.set("n", "gQ", "<cmd>%bd<bar>e#<bar>bd#<cr>")

-- Allow the . to execute once for each line of a visual selection
vim.keymap.set("v", ".", "<cmd>:normal .<cr>")
