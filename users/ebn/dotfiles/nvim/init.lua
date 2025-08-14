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

-- Leader key
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup all plugins with lazy.nvim
require("lazy").setup({
  -- Theme
  {
    "jesseleite/nvim-noirbuddy",
    dependencies = { "tjdevries/colorbuddy.nvim" },
    lazy = false,
    priority = 1000,
    config = function()
      require('noirbuddy').setup {
        colors = {
          primary = '#fe386e',
          secondary = '#38dff2',
        }
      }
    end,
  },

  -- File navigation
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Telescope config will go here
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup {}
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "nix", "clojure", "javascript", "typescript", "python", "rust", "bash", "html", "css", "json", "yaml" },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
      }
    end,
  },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.nixfmt,
        },
      })
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {}
    end,
  },
  { "tpope/vim-fugitive" },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {}
    end,
  },

  -- Clojure
  { "tpope/vim-fireplace" },
  { "Olical/conjure" },

  -- Utilities
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {}
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
  { "lukas-reineke/indent-blankline.nvim" },
  { "tpope/vim-sensible" },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]], -- Ctrl+\ to toggle
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        direction = 'float', -- 'horizontal', 'vertical', or 'float'
        float_opts = {
          border = 'curved',
          winblend = 10,
        },
      })
    end,
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    config = function()
      -- Copilot settings
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true

      -- Custom keymaps for Copilot
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.keymap.set('i', '<C-H>', '<Plug>(copilot-dismiss)')
      vim.keymap.set('i', '<C-K>', '<Plug>(copilot-previous)')
      vim.keymap.set('i', '<C-L>', '<Plug>(copilot-next)')
    end,
  }
})

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

-- Terminal navigation
keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float terminal" })
keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal terminal" })
keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Vertical terminal" })
keymap("t", "<esc>", [[<C-\><C-n>]], { desc = "Escape terminal mode" })
keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Go to left window" })
keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Go to down window" })
keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Go to up window" })
keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Go to right window" })
keymap("n", "<leader>1", "<cmd>1ToggleTerm direction=float<cr>", { desc = "Terminal 1" })
keymap("n", "<leader>2", "<cmd>2ToggleTerm direction=float<cr>", { desc = "Terminal 2" })
keymap("n", "<leader>3", "<cmd>3ToggleTerm direction=float<cr>", { desc = "Terminal 3" })
keymap("n", "<leader>4", "<cmd>4ToggleTerm direction=float<cr>", { desc = "Terminal 4" })
keymap("t", "<C-1>", "<cmd>1ToggleTerm<cr>", { desc = "Switch to terminal 1" })
keymap("t", "<C-2>", "<cmd>2ToggleTerm<cr>", { desc = "Switch to terminal 2" })
keymap("t", "<C-3>", "<cmd>3ToggleTerm<cr>", { desc = "Switch to terminal 3" })
keymap("t", "<C-4>", "<cmd>4ToggleTerm<cr>", { desc = "Switch to terminal 4" })

-- LSP configuration
local ok, lspconfig = pcall(require, 'lspconfig')
if ok then
  local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  local capabilities = cmp_ok and cmp_nvim_lsp.default_capabilities() or {}

  -- Setup LSPs
  if lspconfig.clojure_lsp then lspconfig.clojure_lsp.setup { capabilities = capabilities } end
  if lspconfig.nil_ls then lspconfig.nil_ls.setup { capabilities = capabilities } end
  if lspconfig.rust_analyzer then lspconfig.rust_analyzer.setup { capabilities = capabilities } end
  if lspconfig.ts_ls then lspconfig.ts_ls.setup { capabilities = capabilities } end
  if lspconfig.lua_ls then lspconfig.lua_ls.setup { capabilities = capabilities } end
  if lspconfig.pyright then lspconfig.pyright.setup { capabilities = capabilities } end
  if lspconfig.html then lspconfig.html.setup { capabilities = capabilities } end
  if lspconfig.cssls then lspconfig.cssls.setup { capabilities = capabilities } end
  if lspconfig.jsonls then lspconfig.jsonls.setup { capabilities = capabilities } end
  if lspconfig.yamlls then lspconfig.yamlls.setup { capabilities = capabilities } end
  if lspconfig.bashls then lspconfig.bashls.setup { capabilities = capabilities } end
  if lspconfig.terraformls then lspconfig.terraformls.setup { capabilities = capabilities } end
end

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

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
