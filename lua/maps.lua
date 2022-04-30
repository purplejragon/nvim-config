vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<C-p>', ':bprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':bnext<CR>', { noremap = true, silent = true })

vim.cmd([[tnoremap <esc> <C-\><C-n>]])

vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', { noremap = true })

vim.api.nvim_set_keymap(
  'n',
  '<leader>hd',
  ':lua vim.lsp.buf.hover()<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>d',
  ':lua vim.diagnostic.open_float(nil, { scope = "line", })<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>f',
  ':Neoformat<CR>',
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>ca',
  ':lua vim.lsp.buf.code_action()<CR>',
  { noremap = true, silent = true }
)
