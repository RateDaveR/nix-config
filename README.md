<p align="center">
  <a href="https://https://github.com/DaveVED/nix-config">
    <picture>
      <img src="https://raw.githubusercontent.com/DaveVED/nix-config/main/assets/screenshot.jpg" alt="OpenAuth logo">
    </picture>
  </a>
</p>

---

These are my personal [NixOS](https://nixos.org/) configuration files.
Currently, they support my home lab with a shared Nix configuration. I’m
migrating to a multi-host setup. While tailored to my needs, this project can
serve as a reference for others or enable me to quickly set up a new Nix box
using curl.

For a good starting point for your own NixOS configurations, check out
[nix-starter-configs](https://github.com/Misterio77/nix-starter-configs).

## ⇁ TOC

- [Setting Up a New Box](#-setting-up-a-new-box)
  - [Using my CDN](#using-my-cdn)
  - [Using Github](#using-github)
- [Development Environment](#-development-environment)
  - [Real-Time Changes](#real-time-changes)
  - [Make Commands](#make-commands)

## ⇁ Setting Up a New Box

There are two main ways to set up a new box:

- Download the bootstrap.sh script from my CDN using curl.
- Clone the repository and manually update the flake, then switch to Home
  Manager.

### Using my CDN

This is the target state, and it works (well it's a little flakey, get it haha)
for the most part. You just do this.

```bash
curl -L https://cdn.davedennis.dev/bootstrap.sh | bash
```

### Using Github

Follow these steps to configure a new NixOS system. Ensure your box has git
available. These commands are tested in this exact order:

```bash
nix-shell -p git
git clone https://github.com/DaveVED/nix-config.git && cd "$(basename "$_" .git)"
exit # optional exit the github shell.
nix flake update
sudo nixos-rebuild switch --flake .#dev
```

This minimal setup provides everything needed to get started with my Nix
configurations. Note: This is not an extreme or overly complex setup.

## ⇁ Development Environment

You can actively develop your Nix environment as needed. Utilities are provided
in a `Makefile` to streamline common tasks. For example, run `make format` to
format files or `make help` to see all available commands.

**Note:** Ensure you run `nix-shell` to have `gnumake` installed for the
`Makefile` to work.

### Real-Time Changes

If you make changes to your `home-manager` configs, rebuild your workspace with:

```bash
make rebuild
```

### Make Commands

| Command                | Description                                          |
| ---------------------- | ---------------------------------------------------- |
| `make format`          | Formats files using Prettier.                        |
| `make garbage-collect` | Cleans up the Nix store and removes old generations. |
| `make rebuild`         | Rebuilds the NixOS configuration.                    |
| `make set-background`  | Sets the desktop background using feh.               |
| `make link-config`     | Creates symlinks for `.config` files.                |
| `make help`            | Displays the list of available commands.             |
