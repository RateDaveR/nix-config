{pkgs, lib, ... }:

{
    programs.zed-editor = {
        enable = true;
        extensions = ["nix"];
        userSettings = {
            hour_format = "hour24";
            auto_update = false;

            vim_mode = true;
            ## tell zed to use direnv and direnv can use a flake.nix enviroment.
            load_direnv = "shell_hook";
            base_keymap = "VSCode";
            theme = {
                mode = "system";
                light = "One Light";
                dark = "One Dark";
            };
            show_whitespaces = "all" ;
            ui_font_size = 16;
            buffer_font_size = 16;
        };
    };
}
