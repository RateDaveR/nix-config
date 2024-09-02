{ pkgs, lib, ... }:

let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = rose-pine;
        config = "colorscheme rose-pine";
      }
      {
        plugin = nvim-treesitter.withPlugins (treesitter-plugins: 
            with treesitter-plugins; [
                bash
                lua
                nix
                python
                go
                typescript
            ]
        );
        config = toLuaFile ./config/plugins/treesitter.lua;
      }
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./config/plugins/lsp.lua;
      }
      telescope-nvim
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./config/options.lua}
    '';
  };
}

