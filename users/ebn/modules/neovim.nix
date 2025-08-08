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
    extraLuaConfig = builtins.readFile ../dotfiles/nvim/init.lua;
    
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
