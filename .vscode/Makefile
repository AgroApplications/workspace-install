SHELL := /bin/bash

EXTENSIONS_FILE := extensions.json

EXTENSIONS := $(shell python3 -c "\
import json, pathlib; \
data = json.loads(pathlib.Path('$(EXTENSIONS_FILE)').read_text()); \
print(' '.join(data.get('recommendations', [])))")

CODE_CMD := $(shell command -v cursor 2>/dev/null || command -v code 2>/dev/null)

.PHONY: install-extensions list-extensions check-cmd

install-extensions: check-cmd
	@echo "Installing $(words $(EXTENSIONS)) extensions from $(EXTENSIONS_FILE)..."
	@for ext in $(EXTENSIONS); do \
		echo "  -> Installing $$ext"; \
		$(CODE_CMD) --install-extension $$ext --force; \
	done
	@echo "Done."

list-extensions:
	@echo "Recommended extensions ($(EXTENSIONS_FILE)):"
	@for ext in $(EXTENSIONS); do \
		echo "  - $$ext"; \
	done

check-cmd:
	@if [ -z "$(CODE_CMD)" ]; then \
		echo "Error: neither 'cursor' nor 'code' CLI found in PATH."; \
		echo "Install the CLI: Cmd/Ctrl+Shift+P -> 'Shell Command: Install'"; \
		exit 1; \
	fi
	@echo "Using CLI: $(CODE_CMD)"

# --- VS Code extensions ---
VSCODE_CMD := /Applications/Visual Studio Code.app/Contents/Resources/app/bin/code

.PHONY: install-ext

install-ext:
	@if [ ! -f "$(VSCODE_CMD)" ]; then \
		echo "Error: VS Code not found at $(VSCODE_CMD)"; \
		exit 1; \
	fi
	@echo "Installing $(words $(EXTENSIONS)) VS Code extensions from $(EXTENSIONS_FILE)..."
	@for ext in $(EXTENSIONS); do \
		echo "  -> $$ext"; \
		"$(VSCODE_CMD)" --install-extension $$ext --force; \
	done
	@echo "Done. $(words $(EXTENSIONS)) extensions installed."
