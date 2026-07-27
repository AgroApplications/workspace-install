# mac-setup

Modułowy zestaw skryptów Homebrew do automatyzacji instalacji i konfiguracji środowiska deweloperskiego na macOS. Wzorowany na `ubuntu-setup`, zachowuje tę samą architekturę (config → modules → scripts → install.sh), lecz wykorzystuje `brew` zamiast `apt`.

## Struktura

```text
mac-setup/
├── config/
│   ├── packages.conf       # Grupy pakietów Homebrew (~300 formuł)
│   └── settings.conf       # Ustawienia konfigurowalne
├── modules/
│   ├── mac-system/         # System: update, utilities, terminal tools, editors, cleanup
│   ├── mac-python/         # Python: interpretery, menedżery, narzędzia, biblioteki
│   ├── mac-devops/         # DevOps: git, vcs, docker, kubernetes
│   └── mac-infra/          # Infra: build, libs, network, monitoring, db, lang,
│                           #        docs, crypto, multimedia, cloud, data, misc
├── scripts/
│   └── helpers.sh          # Funkcje logowania i install_package_group (brew)
├── install.sh              # Główny punkt wejścia
├── Makefile                # Skróty: install, full, clean, list
└── README.md
```

## Wymagania wstępne

- **Homebrew** zainstalowany i dostępny w `PATH` (`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`)
- **Xcode Command Line Tools** (`xcode-select --install`)
- macOS 13+ (Ventura lub nowszy)

## Profile instalacyjne

### Profil bazowy (domyślny)

Szybki bootstrap z podstawowymi narzędziami:

1. `brew update && brew upgrade`
2. Narzędzia systemowe (coreutils, tmux, tree, grep, ...)
3. Python 3.11-3.14, pyenv
4. Menedżery: uv, pipx, Poetry
5. Git, git-lfs, GitHub CLI (`gh`), lazygit
6. Docker, docker-compose, podman
7. Weryfikacja i cleanup

### Profil pełny

Pełny stack deweloperski — wszystko z profilu bazowego plus:

- Nowoczesne CLI: bat, eza, lsd, broot, fastfetch, ...
- Edytory: vim, neovim, nano
- Python dev tools: ruff, pre-commit, ipython, cffi, cryptography, ...
- VCS: GitHub CLI (`gh`), subversion, mercurial
- Kubernetes: kubectl, k9s, kubectx, kdash, ktop, kompose, kubescape
- Build: make, cmake, ninja, just, autoconf, automake, bison, flex, ccache, ...
- Biblioteki dev + kompresja (readline, libyaml, lz4, zstd, ...)
- Sieć: curl, wget, openssh + biblioteki (libssh, c-ares, ...)
- Monitoring: htop, iperf3, gperftools
- Bazy danych: PostgreSQL, MySQL, MariaDB, SQLite, unixODBC
- Języki: Node.js, OpenJDK, ICU
- Dokumentacja: pandoc, graphviz, tesseract, doxygen, asciidoc
- Kryptografia: gnupg, openssl, gnutls, ...
- Multimedia: ffmpeg, imagemagick, gifsicle, optipng, gstreamer + kodeki + grafika
- Cloud/IaC: azure-cli, terraform, ansible, astro
- Data tools: jq, qsv, sq, simdjson, ...
- Task management: task, taskwarrior-tui
- Misc: shellcheck, croc

## Uruchamianie

```bash
# Profil bazowy
./mac-setup/install.sh

# Profil pełny
MAC_SETUP_PROFILE=full ./mac-setup/install.sh

# Przez Makefile
make -C mac-setup install     # profil bazowy
make -C mac-setup full        # profil pełny
make -C mac-setup clean       # czyszczenie cache brew
make -C mac-setup list        # wyświetlenie brew list
```

## Rozszerzanie

1. **Nowy pakiet** — dodaj nazwę formuły do odpowiedniej grupy w `config/packages.conf`.
2. **Nowa grupa** — zdefiniuj tablicę w `packages.conf`, utwórz moduł w `modules/` i dodaj `source` + wywołanie w `install.sh`.
3. **Nowa domena** — utwórz katalog `modules/mac-<domain>/` i postępuj jak powyżej.

## Notatki

- Skrypty nie wymagają `sudo` — Homebrew instaluje do przestrzeni użytkownika.
- Docker wymaga Docker Desktop (lub `podman machine init && podman machine start`).
- Wiele pakietów z `brew list` to automatyczne zależności (np. `libpng` jest zależnością `imagemagick`). Są uwzględnione w `packages.conf` dla pełnej odtwarzalności.
- `install.sh` można też sourcing'ować z innych skryptów — wtedy nie wykonuje profilu, tylko udostępnia funkcje.
