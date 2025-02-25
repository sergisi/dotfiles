-- Remaps and my own configuration.
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
