vim.g.mapleader = ' '

vim.keymap.set('n', ' ', '', { silent = true })
-- clear search highlight
vim.keymap.set('n', '<esc>', '<cmd>let @/ = ""<cr>', { silent = true })
-- window jump
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
-- split window
vim.keymap.set('n', 's', '', { silent = true })
vim.keymap.set('n', 'sv', '<cmd>vsp<CR>', { silent = true })
vim.keymap.set('n', 'sh', '<cmd>sp<CR>', { silent = true })
vim.keymap.set('n', 'sc', '<C-w>c', { silent = true })
-- j k
vim.keymap.set('n', 'j', 'gj', { silent = true })
vim.keymap.set('n', 'k', 'gk', { silent = true })

vim.keymap.set('i', '<C-h>', '<Bs>', { silent = true })
vim.keymap.set('i', '<C-e>', '<End>', { silent = true })
vim.keymap.set('i', '<C-a>', '<Home>', { silent = true })
vim.keymap.set('i', '<C-f>', '<Right>', { silent = true })
vim.keymap.set('i', '<C-b>', '<Left>', { silent = true })
vim.keymap.set('i', '<C-d>', '<Del>', { silent = true })
vim.keymap.set('i', '<C-p>', '<Up>', { silent = true })
vim.keymap.set('i', '<C-n>', '<Down>', { silent = true })

vim.keymap.set('v', 'j', 'gj', { silent = true })
vim.keymap.set('v', 'k', 'gk', { silent = true })
