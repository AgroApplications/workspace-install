SHELL := /bin/bash

.PHONY: install full clean list

install:
	@echo "Running base macOS setup..."
	@./install.sh

full:
	@echo "Running full macOS setup..."
	@MAC_SETUP_PROFILE=full ./install.sh

clean:
	@echo "Cleaning up Brew cache..."
	@brew cleanup

list:
	@echo "Currently installed Homebrew formulae:"
	@brew list --formulae
