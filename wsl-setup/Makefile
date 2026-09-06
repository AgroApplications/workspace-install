SHELL := /bin/bash

.PHONY: install full clean

install:
	@echo "Running base WSL setup..."
	@./install.sh

full:
	@echo "Running full WSL setup..."
	@WSL_SETUP_PROFILE=full ./install.sh

clean:
	@echo "Cleaning up APT cache..."
	@sudo apt-get clean
