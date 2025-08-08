-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

-- Set colorscheme
vim.cmd("colorscheme gruvbox")
vim.g.gruvbox_transparent_bg = 1
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NonText guibg=NONE ctermbg=NONE")

-- Leader key
vim.g.mapleader = " "

-- Key mappings
local keymap = vim.keymap.set

-- File navigation
keymap("n", "<leader>pf", "<cmd>Telescope find_files<cr>")
keymap("n", "<leader>ps", "<cmd>Telescope live_grep<cr>")
keymap("n", "<leader>pb", "<cmd>Telescope buffers<cr>")
keymap("n", "<leader>ph", "<cmd>Telescope help_tags<cr>")
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

-- Window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")  
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Buffer navigation
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")

-- Setup plugins (only if they exist)
local function safe_setup(module_name)
  local ok, module = pcall(require, module_name)
  if ok then
    if module_name == 'nvim-tree' then
      module.setup{}
    elseif module_name == 'lualine' then
      module.setup{}
    elseif module_name == 'gitsigns' then
      module.setup{}
    elseif module_name == 'Comment' then
      module.setup{}
    elseif module_name == 'nvim-autopairs' then
      module.setup{}
    end
  end
end

safe_setup('nvim-tree')
safe_setup('lualine')
safe_setup('gitsigns')
safe_setup('Comment')
safe_setup('nvim-autopairs')

-- Treesitter configuration
local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if ok then
  treesitter.setup {
    highlight = { enable = true },
    indent = { enable = true },
  }
end

-- LSP configuration
local ok, lspconfig = pcall(require, 'lspconfig')
if ok then
  local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  local capabilities = cmp_ok and cmp_nvim_lsp.default_capabilities() or {}
  
  -- Clojure LSP
  if lspconfig.clojure_lsp then lspconfig.clojure_lsp.setup{ capabilities = capabilities } end
  if lspconfig.nil_ls then lspconfig.nil_ls.setup{ capabilities = capabilities } end
  if lspconfig.rust_analyzer then lspconfig.rust_analyzer.setup{ capabilities = capabilities } end
  if lspconfig.ts_ls then lspconfig.ts_ls.setup{ capabilities = capabilities } end
end

-- Completion setup
local cmp_ok, cmp = pcall(require, 'cmp')
local luasnip_ok, luasnip = pcall(require, 'luasnip')

if cmp_ok and luasnip_ok then
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    })
  })
end

-- Clojure-specific settings
vim.g.conjure_mapping_prefix = "<localleader>"
vim.g.conjure_client_clojure_nrepl_connection_auto_repl_cmd = "lein"
