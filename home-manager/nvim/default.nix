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
      {
        plugin = nvim-tree-lua;
        config = toLuaFile ./config/plugins/nvim_tree.lua;
      }
      telescope-nvim
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-buffer
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./config/options.lua}
    '';
  };
}

