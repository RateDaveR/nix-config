<p align="center">
  <a href="https://github.com/DaveVED/nix-config">
    <picture>
      <img src="https://raw.githubusercontent.com/DaveVED/nix-config/main/assets/screenshot.jpg" alt="OpenAuth logo">
    </picture>
  </a>
</p>

# My NixOS Configurations

These are my personal [NixOS](https://nixos.org/) configuration files. They support my home lab and are evolving into a multi-host setup. While tailored to my needs, this project serves as a reference for others or enables rapid setup of a new Nix box using curl.

For a great starting point for your own NixOS configurations, check out [nix-starter-configs](https://github.com/Misterio77/nix-starter-configs).

## Table of Contents

- [Setting Up a New Box](#setting-up-a-new-box)
  - [Using My CDN](#using-my-cdn)
  - [Using GitHub](#using-github)
- [Development Environment](#development-environment)
  - [Real-Time Changes](#real-time-changes)
  - [Make Commands](#make-commands)
- [Tooling and Applications](#tooling-and-applications)
  - [Core Tools](#core-tools)
  - [Additional Configurations](#additional-configurations)
  - [Dotfile Management with Home Manager](#dotfile-management-with-home-manager)
- [TODO](#todo)

## Setting Up a New Box

There are two main ways to set up a new box:

### Using My CDN

This is the target state (though still slightly experimental). Run:

```bash
curl -L https://cdn.davedennis.dev/bootstrap.sh | bash
```

### Using GitHub

1. Ensure `git` is available:

```bash
nix-shell -p git
```

2. Clone the repository:

```bash
git clone https://github.com/DaveVED/nix-config.git && cd "$(basename "$_" .git)"
exit # Exit the nix-shell if needed.
```

3. For new setups, copy the `hardware-configuration.nix` from `/etc/nixos` to your configuration folder:

```bash
cp /etc/nixos/hardware-configuration.nix ~/etc/nixos/
```

4. Update and rebuild:

```bash
nix flake update
sudo nixos-rebuild switch --flake .#dev
```

This minimal setup provides a ready-to-use Nix environment.

## Development Environment

You can actively develop your Nix configurations using utilities provided in the `Makefile`. For example:

- `make format` formats files.
- `make rebuild` rebuilds the configuration.

**Note:** Run `nix-shell` to install `gnumake` for the `Makefile` to work.

### Real-Time Changes

Rebuild your workspace after updating `home-manager` configs:

```bash
make rebuild
```

### Make Commands

| Command                | Description                                          |
|------------------------|------------------------------------------------------|
| `make format`          | Formats files using Prettier.                        |
| `make garbage-collect` | Cleans up the Nix store and removes old generations. |
| `make rebuild`         | Rebuilds the NixOS configuration.                    |
| `make set-background`  | Sets the desktop background using `feh`.             |
| `make link-config`     | Creates symlinks for `.config` files.                |
| `make help`            | Displays the list of available commands.             |

## Tooling and Applications

### Core Tools

The configuration includes:

- **Neovim**: A hyperextensible text editor with custom configurations. Aliases `vi` and `vim` to Neovim.
- **Tmux**: A terminal multiplexer for managing persistent sessions.
- **Zsh & Oh My Zsh**: An interactive shell with theming and ease of use.
- **Git**: Basic setup with keyring integration.
- **VSCode**: For cases where a GUI editor is needed.

### Additional Configurations

- **Home-Manager Integration**: Sets up `home-manager` alongside NixOS.

```nix
{ inputs, outputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      your-username = import ../home-manager/home.nix;
    };
  };
}
```

### Dotfile Management with Home Manager

Manage dotfiles declaratively with `home-manager`, enabling reproducible environments. Example configurations include:

- `home-manager/zsh/default.nix`: Minimal Zsh configuration.
- `home-manager/nvim/default.nix`: Advanced Neovim setup.

Run `man home-configuration.nix` for more `home-manager` options.

## TODO

- [ ] Bind Firefox to a key combination or explore `nohup` to prevent closure when the terminal is closed.
- [ ] Explore persistence options for home lab setups.
- [ ] Add more hosts and users to the configuration.
- [ ] Integrate advanced secret management tools like `sops-nix` or `pass`.
- [ ] Investigate Hydra for CI/CD and binary caching.
- [ ] Research opt-in persistence setups for fully reproducible systems.
- [ ] Improve documentation and modularize configurations further.

