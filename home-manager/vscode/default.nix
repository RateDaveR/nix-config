{ pkgs, ...}:
{
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            ms-python.python
            ms-python.vscode-pylance
            bbenoist.nix
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
                name = "tokyo-night";
                publisher = "enkia";
                version = "1.0.6";
                sha256 = "sha256-VWdUAU6SC7/dNDIOJmSGuIeffbwmcfeGhuSDmUE7Dig=";
            }
            {
                name = "line-length-checker-vscode";
                publisher = "SUPERTSY5";
                version = "1.0.0";
                sha256 = "sha256-yPgWWqaoYDXxj5sQuME5g3P+YVAt4iZEx0azRoiPZBg=";
            }
            {
                name = "copilot";
                publisher = "GitHub";
                version = "1.130.518";
                sha256 = "sha256-kHUk9Ap90MAZVyp+avhrgKE8luE+5NekVGZfSwDyzXU=";
            }
            {
                name = "remote-containers";
                publisher = "ms-vscode-remote";
                version = "0.320.0";
                sha256 = "sha256-432TLuzHuXK9DmJlOpFFGlZqbWTsAWnGA8zk7/FarQw=";
            }
            {
                name = "cpptools-extension-pack";
                publisher = "ms-vscode";
                version = "1.3.0";
                sha256 = "sha256-rHST7CYCVins3fqXC+FYiS5Xgcjmi7QW7M4yFrUR04U=";
            }
        ];
        userSettings = {
            "workbench.colorTheme" = "Tokyo Night nv";
            "line-length-checker.lineLength" = 95;
            "git.ignoreMissingGitWarning" = true;
        };
    };
}
