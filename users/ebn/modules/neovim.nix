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
      nil
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      lua-language-server
      pyright
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      nodePackages.bash-language-server
      rust-analyzer
      terraform-ls
      nixfmt-rfc-style

      # Additional tools
      ripgrep # For telescope grep
      fd # For telescope file search
      clojure # Clojure runtime
      leiningen # Clojure build tool
    ];
  };
}
