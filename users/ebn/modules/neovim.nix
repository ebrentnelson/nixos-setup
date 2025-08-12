{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # Only the bare minimum - lazy.nvim and essential tools
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
    
    # Your init.lua configuration
    extraLuaConfig = builtins.readFile ../dotfiles/nvim/init.lua;
    
    # Keep the LSP servers and tools (these aren't plugins)
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
