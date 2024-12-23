{pkgs, lib, ... }:
{
    programs.zed-editor = {
        enable = true;
        extensions = ["nix"];
        userSettings = {
            lsp = {
                nix = { 
                    binary = { 
                        path_lookup = true; 
                    }; 
                };


            };
            vim_mode = true;
        };

    };
}