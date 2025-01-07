{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "DaveVED";
    userEmail = "dave.dennis@gs.com";
    extraConfig = {
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };
  };
}
