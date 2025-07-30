# neovim.nix - Your complete Neovim configuration
{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # Install plugins declaratively
    plugins = with pkgs.vimPlugins; [
      # Essential plugins
      vim-sensible
      
      # Theme
      gruvbox-nvim
      
      # File navigation
      telescope-nvim
      telescope-fzf-native-nvim
      nvim-tree-lua
      
      # LSP and completion
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      
      # Treesitter for syntax highlighting
      (nvim-treesitter.withPlugins (p: [
        p.nix
        p.lua
        p.clojure
        p.javascript
        p.typescript
        p.python
        p.rust
        p.go
        p.bash
      ]))
      
      # Git integration
      gitsigns-nvim
      vim-fugitive
      
      # Status line
      lualine-nvim
      
      # Clojure specific (since you code in Clojure!)
      vim-fireplace
      conjure
      
      # Additional useful plugins
      comment-nvim
      nvim-autopairs
      indent-blankline-nvim
    ];
    
    # Your init.lua configuration
    extraLuaConfig = ''
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
      
      -- Setup plugins
      require('nvim-tree').setup{}
      require('lualine').setup{}
      require('gitsigns').setup{}
      require('Comment').setup{}
      require('nvim-autopairs').setup{}
      
      -- Treesitter configuration
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
      }
      
      -- LSP configuration
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Clojure LSP
      lspconfig.clojure_lsp.setup{ capabilities = capabilities }
      
      -- Other LSPs you might want
      lspconfig.nil_ls.setup{ capabilities = capabilities }  -- Nix LSP
      lspconfig.rust_analyzer.setup{ capabilities = capabilities }
      lspconfig.tsserver.setup{ capabilities = capabilities }
      
      -- Completion setup
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
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
      
      -- Clojure-specific settings
      vim.g.conjure_mapping_prefix = "<localleader>"
      vim.g.conjure_client_clojure_nrepl_connection_auto_repl_cmd = "lein"
    '';
    
    # Extra packages needed for LSPs and tools
    extraPackages = with pkgs; [
      # LSP servers
      clojure-lsp
      nil  # Nix LSP
      nodePackages.typescript-language-server
      rust-analyzer
      
      # Additional tools
      ripgrep  # For telescope grep
      fd       # For telescope file search
      clojure  # Clojure runtime
      leiningen # Clojure build tool
    ];
  };
}