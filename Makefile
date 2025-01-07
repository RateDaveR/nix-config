# Define variables for Prettier options
PRETTIER_OPTIONS=\
  --write "**/*.{md,mdx,yaml,yml}" \
  --print-width 80 \
  --prose-wrap always \
  --tab-width 2 \
  --use-tabs false \
  --single-quote true \
  --trailing-comma none

# Default target
.PHONY: all
all: format garbage-collect rebuild set-background link-config help

# Target for formatting files with Prettier
.PHONY: format
format:
	bunx prettier $(PRETTIER_OPTIONS)

# Target for Nix garbage collection
.PHONY: garbage-collect
garbage-collect:
	sudo nix-collect-garbage -d
	nix-env --delete-generations old
	sudo nix-store --gc

# Target for rebuilding NixOS configuration
.PHONY: rebuild
rebuild:
	sudo nixos-rebuild switch --flake .#dev

# Target for setting the background using feh
.PHONY: set-background
set-background:
	@echo "Usage: make set-background IMAGE=<path_to_image>"
	@if [ -z "$(IMAGE)" ]; then \
	  echo "Error: IMAGE parameter is required"; \
	  exit 1; \
	fi
	feh --bg-scale $(IMAGE)

# Target for creating symlinks for .config files
.PHONY: link-config
link-config:
	@echo "Creating symlinks for .config files..."
	ln -sf $(PWD)/.config ~/.config
	@echo "Symlinks created for .config files."

.PHONY: fmt
fmt:
	alejandra . -q

# Help target to display available commands
.PHONY: help
help:
	@echo "Available make commands:"
	@echo "  make format          - Format files with Prettier"
	@echo "  make garbage-collect - Run Nix garbage collection"
	@echo "  make rebuild         - Rebuild NixOS configuration"
	@echo "  make set-background IMAGE=<path> - Set desktop background using feh"
	@echo "  make link-config     - Create symlinks for .config files"
	@echo "  make help            - Show this help message"

