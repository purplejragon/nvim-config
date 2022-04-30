require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'ishan9299/nvim-solarized-lua'
  use 'marko-cerovac/material.nvim'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use 'windwp/nvim-ts-autotag'
  use 'jiangmiao/auto-pairs'
  use 'sbdchd/neoformat'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)

-- treesitter config
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
}

-- nvim-ts-autotag config
require('nvim-ts-autotag').setup()

-- theme config
vim.opt.termguicolors = true
vim.g.material_style = 'darker'
vim.cmd([[colorscheme material]])

-- nvim-cmp/luasnip config
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }
  })
})

-- lsp config
local lspconfig = require('lspconfig')
local c = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.clangd.setup { capabilities = c }
lspconfig.rls.setup { capabilities = c }
lspconfig.html.setup { capabilities = c }
lspconfig.cssls.setup { capabilities = c }
lspconfig.tsserver.setup { capabilities = c }
lspconfig.emmet_ls.setup { capabilities = c }
lspconfig.gopls.setup { capabilities = c }
lspconfig.tailwindcss.setup { capabilities = c }
lspconfig.volar.setup { capabilities = c }
lspconfig.jsonls.setup { capabilities = c }
lspconfig.ocamllsp.setup { capabilities = c }
-- telescope config
require('telescope').setup()
