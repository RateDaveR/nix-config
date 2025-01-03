{ pkgs, lib, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "python-lsp" "tmux"];
    userSettings = {
      hour_format = "hour24";
      auto_update = false;
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      theme = {
        mode = "dark";
        light = "One Light";
        dark = "One Dark";
      };
      show_whitespaces = "all";
      ui_font_size = 14;
      buffer_font_size = 14;

      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };

      terminal = {
        dock = "bottom";
        font_family = "FiraCode Nerd Font";
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        toolbar = {
          title = true;
          breadcrumbs = true;
        };
         detect_venv = {
                    on = {
                        directories = [".env" "env" ".venv" "venv"];
                        activate_script = "default";
                    };
                };
      };

      lsp = {
        typescript = {
          binary = {
            path = "/run/current-system/sw/bin/tsserver";
          };
        };
        nix = {
          binary = {
            path_lookup = true;
          };
        };
      };
    };
  };
}
