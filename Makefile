# Makefile for Python 3.12 Development Environment with uv

.PHONY: help build dev prod test jupyter clean stop logs shell install format lint type-check docs

# Default target
.DEFAULT_GOAL := help

# Colors
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Docker compose command
DOCKER_COMPOSE := $(shell command -v docker-compose 2> /dev/null || echo "docker compose")

help: ## Show this help message
	@echo "$(BLUE)Python 3.12 Development Environment with uv$(NC)"
	@echo "$(BLUE)================================================$(NC)"
	@echo ""
	@echo "$(GREEN)Available commands:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "} {printf "  $(YELLOW)%-15s$(NC) %s\n", $$1, $$2}'
	@echo ""

build: ## Build all Docker images
	@echo "$(GREEN)🔨 Building Docker images...$(NC)"
	$(DOCKER_COMPOSE) build

dev: ## Start development environment
	@echo "$(GREEN)🚀 Starting development environment...$(NC)"
	$(DOCKER_COMPOSE) up dev

dev-bg: ## Start development environment in background
	@echo "$(GREEN)🚀 Starting development environment in background...$(NC)"
	$(DOCKER_COMPOSE) up -d dev

prod: ## Start production environment
	@echo "$(GREEN)🚀 Starting production environment...$(NC)"
	$(DOCKER_COMPOSE) up prod

prod-bg: ## Start production environment in background
	@echo "$(GREEN)🚀 Starting production environment in background...$(NC)"
	$(DOCKER_COMPOSE) up -d prod

test: ## Run tests in Docker
	@echo "$(YELLOW)🧪 Running tests...$(NC)"
	$(DOCKER_COMPOSE) run --rm test

test-cov: ## Run tests with coverage report in Docker
	@echo "$(YELLOW)🧪 Running tests with coverage...$(NC)"
	$(DOCKER_COMPOSE) run --rm test uv run pytest -v --cov=src --cov-report=html --cov-report=term

jupyter: ## Start Jupyter Lab
	@echo "$(GREEN)📊 Starting Jupyter Lab...$(NC)"
	$(DOCKER_COMPOSE) up jupyter

jupyter-bg: ## Start Jupyter Lab in background
	@echo "$(GREEN)📊 Starting Jupyter Lab in background...$(NC)"
	$(DOCKER_COMPOSE) up -d jupyter

shell: ## Access development container shell
	@echo "$(GREEN)🐚 Accessing development container...$(NC)"
	docker exec -it python-dev-env zsh || echo "$(RED)Container not running. Start with 'make dev' first.$(NC)"

logs: ## View logs from all services
	@echo "$(GREEN)📋 Viewing logs...$(NC)"
	$(DOCKER_COMPOSE) logs -f

stop: ## Stop all services
	@echo "$(YELLOW)⏹️  Stopping all services...$(NC)"
	$(DOCKER_COMPOSE) down

clean: ## Clean up containers, images, and volumes
	@echo "$(RED)🧹 Cleaning up Docker resources...$(NC)"
	$(DOCKER_COMPOSE) down -v --rmi all
	docker system prune -f

restart: stop dev ## Restart development environment

# Local development commands (without Docker)
install: ## Install dependencies locally with uv
	@echo "$(GREEN)📦 Installing dependencies with uv...$(NC)"
	uv sync

format: ## Format code with ruff
	@echo "$(GREEN)✨ Formatting code...$(NC)"
	uv run ruff format .

lint: ## Lint code with ruff
	@echo "$(YELLOW)🔍 Linting code...$(NC)"
	uv run ruff check .

lint-fix: ## Lint and fix code with ruff
	@echo "$(GREEN)🔧 Linting and fixing code...$(NC)"
	uv run ruff check . --fix

type-check: ## Type check with mypy
	@echo "$(YELLOW)🔍 Type checking...$(NC)"
	uv run mypy src/

test-local: ## Run tests locally
	@echo "$(YELLOW)🧪 Running tests locally...$(NC)"
	uv run pytest -v

test-local-cov: ## Run tests locally with coverage
	@echo "$(YELLOW)🧪 Running tests locally with coverage...$(NC)"
	uv run pytest -v --cov=src --cov-report=html --cov-report=term

docs: ## Generate documentation
	@echo "$(GREEN)📚 Generating documentation...$(NC)"
	uv run sphinx-build -b html docs/ docs/_build/

docs-serve: ## Serve documentation locally
	@echo "$(GREEN)📚 Serving documentation...$(NC)"
	cd docs/_build && python -m http.server 8080

# Database commands (if using PostgreSQL)
db-up: ## Start database
	@echo "$(GREEN)🗄️  Starting database...$(NC)"
	$(DOCKER_COMPOSE) up -d db

db-down: ## Stop database
	@echo "$(YELLOW)🗄️  Stopping database...$(NC)"
	$(DOCKER_COMPOSE) stop db

db-reset: ## Reset database
	@echo "$(RED)🗄️  Resetting database...$(NC)"
	$(DOCKER_COMPOSE) down db
	docker volume rm pythonenv-nsv_postgres-data || true
	$(DOCKER_COMPOSE) up -d db

# Redis commands
redis-up: ## Start Redis
	@echo "$(GREEN)🔴 Starting Redis...$(NC)"
	$(DOCKER_COMPOSE) up -d redis

redis-down: ## Stop Redis
	@echo "$(YELLOW)🔴 Stopping Redis...$(NC)"
	$(DOCKER_COMPOSE) stop redis

# Full stack commands
stack-up: ## Start full development stack
	@echo "$(GREEN)🚀 Starting full development stack...$(NC)"
	$(DOCKER_COMPOSE) up -d dev db redis

stack-down: ## Stop full development stack
	@echo "$(YELLOW)⏹️  Stopping full development stack...$(NC)"
	$(DOCKER_COMPOSE) down

# Health checks
health: ## Check health of running services
	@echo "$(GREEN)🏥 Checking service health...$(NC)"
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Security scanning
security-scan: ## Run security scan on dependencies
	@echo "$(YELLOW)🔒 Running security scan...$(NC)"
	uv run safety check
	uv run bandit -r src/

pre-commit-install: ## Install pre-commit hooks
	@echo "$(GREEN)🪝 Installing pre-commit hooks...$(NC)"
	uv run pre-commit install

pre-commit-run: ## Run pre-commit on all files
	@echo "$(GREEN)🪝 Running pre-commit on all files...$(NC)"
	uv run pre-commit run --all-files

bump-version: ## Bump version (patch) — edit pyproject.toml version field
	@echo "$(GREEN)🔖 Bumping version...$(NC)"
	@VERSION=$$(grep 'version' pyproject.toml | head -1 | sed 's/.*"\(.*\)".*/\1/'); \
	MAJOR=$$(echo $$VERSION | cut -d. -f1); \
	MINOR=$$(echo $$VERSION | cut -d. -f2); \
	PATCH=$$(echo $$VERSION | cut -d. -f3); \
	NEW_PATCH=$$((PATCH + 1)); \
	NEW_VERSION="$$MAJOR.$$MINOR.$$NEW_PATCH"; \
	sed -i.bak "s/version = \"$$VERSION\"/version = \"$$NEW_VERSION\"/" pyproject.toml && rm -f pyproject.toml.bak; \
	echo "New version: $$NEW_VERSION"

bump-minor: ## Bump minor version
	@echo "$(GREEN)🔖 Bumping minor version...$(NC)"
	@VERSION=$$(grep 'version' pyproject.toml | head -1 | sed 's/.*"\(.*\)".*/\1/'); \
	MAJOR=$$(echo $$VERSION | cut -d. -f1); \
	MINOR=$$(echo $$VERSION | cut -d. -f2); \
	NEW_MINOR=$$((MINOR + 1)); \
	NEW_VERSION="$$MAJOR.$$NEW_MINOR.0"; \
	sed -i.bak "s/version = \"$$VERSION\"/version = \"$$NEW_VERSION\"/" pyproject.toml && rm -f pyproject.toml.bak; \
	echo "New version: $$NEW_VERSION"

bump-major: ## Bump major version
	@echo "$(GREEN)🔖 Bumping major version...$(NC)"
	@VERSION=$$(grep 'version' pyproject.toml | head -1 | sed 's/.*"\(.*\)".*/\1/'); \
	MAJOR=$$(echo $$VERSION | cut -d. -f1); \
	NEW_MAJOR=$$((MAJOR + 1)); \
	NEW_VERSION="$$NEW_MAJOR.0.0"; \
	sed -i.bak "s/version = \"$$VERSION\"/version = \"$$NEW_VERSION\"/" pyproject.toml && rm -f pyproject.toml.bak; \
	echo "New version: $$NEW_VERSION"

build-package: ## Build package for distribution
	@echo "$(GREEN)📦 Building package...$(NC)"
	uv build

publish-test: ## Publish to TestPyPI
	@echo "$(YELLOW)📤 Publishing to TestPyPI...$(NC)"
	uv publish --index testpypi

publish: ## Publish to PyPI
	@echo "$(GREEN)📤 Publishing to PyPI...$(NC)"
	uv publish

check-all: lint type-check test-local security-scan ## Run all checks

ci-test: ## Run tests like in CI
	@echo "$(GREEN)🔄 Running CI tests...$(NC)"
	uv run pytest --cov=src --cov-report=xml --cov-report=term --cov-fail-under=80

# Complete CI/CD pipeline commands
ci-pipeline: install lint type-check test-local security-scan build-package ## Run complete CI pipeline locally
	@echo "$(GREEN)✅ Local CI pipeline completed successfully!$(NC)"

ci-full: ci-pipeline docs ## Run full CI including documentation
	@echo "$(GREEN)🎉 Full CI pipeline completed!$(NC)"

release-check: ## Check if ready for release
	@echo "$(YELLOW)🔍 Checking release readiness...$(NC)"
	@uv run pytest --cov=src --cov-fail-under=80
	@uv run ruff check .
	@uv run mypy src/
	@uv run safety check
	@echo "$(GREEN)✅ Ready for release!$(NC)"

auto-release: release-check bump-version build-package ## Automated release process
	@echo "$(GREEN)🚀 Starting automated release...$(NC)"
	@VERSION=$$(grep 'version' pyproject.toml | head -1 | sed 's/.*"\(.*\)".*/\1/'); \
	git add pyproject.toml; \
	git commit -m "Release version $$VERSION"; \
	git tag "v$$VERSION"; \
	echo "$(YELLOW)Created tag v$$VERSION$(NC)"; \
	echo "$(YELLOW)Push with: git push && git push --tags$(NC)"

nightly-build: ## Run nightly build process
	@echo "$(BLUE)🌙 Running nightly build...$(NC)"
	@$(MAKE) clean
	@$(MAKE) ci-full
	@$(MAKE) build-package
	@$(MAKE) build
	@echo "$(GREEN)✅ Nightly build completed!$(NC)"

# Performance profiling
profile: ## Run performance profiling
	@echo "$(YELLOW)⚡ Running performance profiling...$(NC)"
	uv run python -m cProfile -o profile.stats main.py

# Backup commands
backup-db: ## Backup database
	@echo "$(GREEN)💾 Backing up database...$(NC)"
	docker exec python-postgres pg_dump -U developer python_dev > backup_$(shell date +%Y%m%d_%H%M%S).sql

# Development utilities
watch-logs: ## Watch logs in real-time
	@echo "$(GREEN)👀 Watching logs...$(NC)"
	$(DOCKER_COMPOSE) logs -f --tail=100

ps: ## Show running containers
	@echo "$(GREEN)📋 Running containers:$(NC)"
	$(DOCKER_COMPOSE) ps

top: ## Show container resource usage
	@echo "$(GREEN)📊 Container resource usage:$(NC)"
	docker stats --no-stream
