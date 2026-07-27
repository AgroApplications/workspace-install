# Workspace

Python 3.12 development environment template optimized for Cursor IDE with full AI configuration, MCP Protocol, Docker, uv, and CI/CD.

## Quick Start

### Prerequisites

- Python 3.12
- [uv](https://docs.astral.sh/uv/) (fast Python package and project manager)
- [Docker](https://docs.docker.com/get-docker/) (optional)

### Local Development

```bash
# Install dependencies
make install
# or directly:
uv sync

# Run the application
uv run uvicorn src.main:app --reload --host 0.0.0.0 --port 8000

# Run tests
make test-local

# Run linter
make lint

# Run type checker
make type-check

# Run all checks
make check-all
```

### Docker Development

```bash
# Build images
make build

# Start development environment
make dev

# Start full stack (dev + PostgreSQL + Redis)
make stack-up

# Run tests in container
make test

# Start Jupyter Lab
make jupyter
```

## Project Structure

```
CursorTemplate/
├── .cursor/              # Cursor IDE configuration
├── .devcontainer/        # Dev Container configuration
├── .vscode/              # VSCode fallback configuration
├── docker/               # Docker build scripts
├── docs/                 # Documentation
├── mac-setup/            # macOS setup automation
├── ubuntu-setup/         # Ubuntu setup automation
├── src/                  # Source code
│   ├── __init__.py
│   └── main.py           # FastAPI application
├── tests/                # Test suite
│   └── test_main.py
├── Dockerfile            # Multi-stage Docker build (uses uv)
├── docker-compose.yml    # Service orchestration
├── pyproject.toml        # PEP 621 project config + all tool settings
├── uv.lock               # Universal lockfile (uv)
├── Makefile              # Project commands
└── .pre-commit-config.yaml
```

## Tech Stack

| Layer | Tools |
|-------|-------|
| **Language** | Python 3.12 |
| **Framework** | FastAPI + Pydantic v2 |
| **Package Manager** | [uv](https://docs.astral.sh/uv/) (replaces pip, poetry, virtualenv) |
| **Linter/Formatter** | Ruff (40+ rule categories) |
| **Type Checker** | MyPy (strict) + Pyright (strict) |
| **Testing** | pytest + pytest-cov + pytest-asyncio |
| **Containerization** | Docker (multi-stage with uv) + Docker Compose |
| **IDE** | Cursor IDE with AI + MCP Protocol |
| **CI/CD** | Makefile-driven pipeline |

## Available Make Commands

| Command | Description |
|---------|-------------|
| `make help` | Show all available commands |
| `make install` | Install dependencies with uv |
| `make format` | Format code with Ruff |
| `make lint` | Lint code with Ruff |
| `make type-check` | Type check with MyPy |
| `make test-local` | Run tests locally |
| `make test-local-cov` | Run tests with coverage |
| `make check-all` | Run all quality checks |
| `make build` | Build Docker images |
| `make dev` | Start dev environment |
| `make stack-up` | Start full dev stack |
| `make security-scan` | Run security scan |
| `make ci-pipeline` | Run full CI pipeline locally |

## Machine Setup

Automated setup scripts for development machines:

- **macOS**: `cd mac-setup && make install`
- **Ubuntu**: `cd ubuntu-setup && make install`

## Why uv?

[uv](https://docs.astral.sh/uv/) is an extremely fast Python package and project manager written in Rust by Astral (creators of Ruff). It replaces `pip`, `pip-tools`, `pipx`, `poetry`, `pyenv`, `virtualenv`, and more in a single tool that is 10-100x faster.

Key benefits:
- **Speed**: 10-100x faster than pip for dependency resolution and installation
- **Universal lockfile**: Platform-independent `uv.lock` for reproducible builds
- **PEP 621**: Standard `pyproject.toml` format (no vendor lock-in)
- **Docker optimized**: Single binary copy, cached installs, minimal layers

## Configuration

### Cursor IDE

- AI model: GPT-4 (temperature 0.1)
- Python analysis: strict mode
- Ruff: enabled for linting + formatting
- pytest: enabled as test framework
- Format on save: enabled

### Quality Gates

- Ruff: zero violations
- MyPy: strict mode, zero errors
- pytest: 80% minimum coverage
- Bandit: zero critical security issues

## License

MIT

## Author

NonSenseVision

### Install mac-setup / ubuntu-setup

1.  bat mac-setup / ubuntu-setup https://github.com/sharkdp/bat
2.  eza mac-setup / ubuntu-setup https://github.com/eza-community/eza
3.  ruff mac-setup / ubuntu-setup https://docs.astral.sh/ruff/installation/
4.  pre-commit mac-setup / ubuntu-setup https://pre-commit.com/
5.  lazygit mac-setup / ubuntu-setup https://github.com/jesseduffield
6.  tailspin mac-setup / ubuntu-setup https://github.com/bensadeh/tailspin
7.  just mac-setup / ubuntu-setup https://github.com/casey/just
8.  dua-cli mac-setup / ubuntu-setup https://github.com/Byron/dua-cli
9.  lazydocker mac-setup / ubuntu-setup https://github.com/jesseduffield/lazydocker
10. taskwarrior-tui mac-setup / ubuntu-setup https://github.com/kdheepak/taskwarrior-tui
11. tokei mac-setup / ubuntu-setup https://github.com/XAMPPRocky/tokei
12. fx mac-setup / ubuntu-setup https://github.com/antonmedv/fx
13. lsd mac-setup / ubuntu-setup https://github.com/lsd-rs/lsd
14. resterm mac-setup / ubuntu-setup https://github.com/unkn0wn-root/resterm
15. mockoon mac-setup / ubuntu-setup https://github.com/mockoon/mockoon
16. fig mac-setup / ubuntu-setup https://github.com/withfig/fig
17. broot mac-setup / ubuntu-setup https://github.com/Canop/broot
18. surge mac-setup / ubuntu-setup https://github.com/surge-downloader/Surge
19. dasel mac-setup / ubuntu-setup https://github.com/TomWright/dasel
20. qsv mac-setup / ubuntu-setup https://github.com/dathere/qsv
21. sq mac-setup / ubuntu-setup https://github.com/neilotoole/sq
22. croc mac-setup / ubuntu-setup https://github.com/schollz/croc
23. fastfetch mac-setup / ubuntu-setup https://github.com/fastfetch-cli/fastfetch
24. k9s mac-setup / ubuntu-setup https://github.com/derailed/k9s
25. ktop mac-setup / ubuntu-setup https://github.com/vladimirvivien/ktop
26. kubectx mac-setup / ubuntu-setup https://github.com/ahmetb/kubectx
27. kdash mac-setup / ubuntu-setup https://github.com/kdash-rs/kdash
28. kubescape mac-setup / ubuntu-setup https://github.com/kubescape/kubescape
29. ctop mac-setup / ubuntu-setup https://github.com/bcicen/ctop
