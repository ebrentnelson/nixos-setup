# NixOS Management Makefile

# Get the current hostname dynamically
HOSTNAME := $(shell hostname)

.PHONY: update rebuild switch history gc clean rebuild-host test-host build-host test build check maintenance help

# Update flake inputs to latest versions
update:
	nix flake update

# Rebuild current system (uses current hostname)
rebuild:
	sudo nixos-rebuild switch --flake '.#$(HOSTNAME)'

# Alias for rebuild (more explicit)
switch: rebuild

# Show system generation history
history:
	nix profile history --profile /nix/var/nix/profiles/system

# Garbage collection - remove old generations and unused packages
gc:
	@echo "Removing system generations older than 7 days..."
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
	@echo "Cleaning up unused nix store entries..."
	sudo nix store gc --debug

# More aggressive cleanup - remove generations older than 3 days
clean:
	@echo "Removing system generations older than 3 days..."
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 3d
	@echo "Cleaning up unused nix store entries..."
	sudo nix store gc --debug

# Parameterized host rebuilds (usage: make rebuild-host HOST=moroni)
rebuild-host:
ifndef HOST
	@echo "Error: HOST parameter required. Usage: make rebuild-host HOST=moroni"
	@exit 1
endif
	sudo nixos-rebuild switch --flake '.#$(HOST)'

test-host:
ifndef HOST
	@echo "Error: HOST parameter required. Usage: make test-host HOST=moroni"
	@exit 1
endif
	sudo nixos-rebuild test --flake '.#$(HOST)'

build-host:
ifndef HOST
	@echo "Error: HOST parameter required. Usage: make build-host HOST=moroni"
	@exit 1
endif
	sudo nixos-rebuild build --flake '.#$(HOST)'

# Test configuration without switching
test:
	sudo nixos-rebuild test --flake '.#$(HOSTNAME)'

# Build configuration without activating
build:
	sudo nixos-rebuild build --flake '.#$(HOSTNAME)'

# Show what packages would be updated
check:
	nix flake check

# Full maintenance routine
maintenance: update rebuild gc
	@echo "Full maintenance complete!"

# Collect files for Claude project
collect-for-claude:
	@mkdir -p ./generated/claude
	@find . -type f -not -path "*/.git/*" | while read file; do \
		relative_path=$${file#./}; \
		target_name=$$(echo "$$relative_path" | sed 's|/|_|g'); \
		cp "$$file" "./generated/claude/$$target_name"; \
	done
	@echo "Files collected in ./generated/claude/"	

# Show available targets
help:
	@echo "Available targets:"
	@echo "  update             - Update flake inputs"
	@echo "  rebuild            - Rebuild current system (hostname: $(HOSTNAME))"
	@echo "  switch             - Alias for rebuild"
	@echo "  test               - Test configuration without switching"
	@echo "  build              - Build configuration without activating"
	@echo "  history            - Show system generation history"
	@echo "  gc                 - Garbage collect (remove 7+ day old generations)"
	@echo "  clean              - More aggressive cleanup (3+ day old generations)"
	@echo "  rebuild-host       - Rebuild specific host (usage: make rebuild-host HOST=lehi)"
	@echo "  test-host          - Test specific host config (usage: make test-host HOST=lehi)"
	@echo "  build-host         - Build specific host config (usage: make build-host HOST=lehi)"
	@echo "  check              - Check flake configuration"
	@echo "  maintenance        - Full update + rebuild + garbage collection"
	@echo "  collect-for-claude - Puts all files in a directory so they can be added to a Claude project easily"
	@echo "  help               - Show this help message"
