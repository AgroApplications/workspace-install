SHELL := /bin/bash

.PHONY: install full clean

install:
	@echo "Running base Ubuntu setup..."
	@./install.sh

full:
	@echo "Running full Ubuntu setup..."
	@DEV_SETUP_PROFILE=full ./install.sh

clean:
	@echo "Cleaning up APT cache..."
	@sudo apt-get clean
