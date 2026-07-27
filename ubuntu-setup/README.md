# ubuntu-setup

Modułowy zestaw skryptów apt do automatyzacji instalacji i konfiguracji środowiska deweloperskiego na Ubuntu. Zachowuje tę samą architekturę co `mac-setup` (config → modules → scripts → install.sh), wykorzystując `apt` zamiast `brew`.

## Struktura

```text
ubuntu-setup/
├── config/
│   ├── packages.conf       # Grupy pakietów APT
│   └── settings.conf       # Ustawienia konfigurowalne
├── modules/
│   ├── system/             # System: update, locale, cleanup
│   ├── python/             # Python: pakiety, menedżery, devtools
│   ├── devops/             # DevOps: git, vcs, docker, kubernetes
│   └── infrastructure/     # Infra: build, libs, compression, network,
│                           #        monitoring, db, lang, docs, profiling,
│                           #        crypto, multimedia, cloud, data,
│                           #        terminal-tools, editors, misc
├── scripts/
│   └── helpers.sh          # Funkcje logowania i install_package_group (apt)
├── install.sh              # Główny punkt wejścia
├── Makefile                # Skróty: install, full, clean
└── README.md
```

## Profile instalacyjne

### Profil bazowy (domyślny)

Szybki bootstrap z podstawowymi narzędziami:

1. Aktualizacja systemu
2. Podstawowe pakiety (BASIC_PACKAGES)
3. Git, git-lfs, GitHub CLI (`gh`), lazygit
4. Docker, docker-compose, podman
5. Pakiety Pythona + menedżery (uv, Poetry)
6. Weryfikacja i podsumowanie

### Profil pełny

Pełny stack deweloperski — wszystko z profilu bazowego plus:

- Nowoczesne CLI: bat, eza, lsd, fd-find, ripgrep, fzf, broot, fastfetch, tig, tokei
- Python devtools: ruff, pre-commit, copier, cffi, cryptography, pydantic
- VCS: GitHub CLI (`gh`), subversion, mercurial
- Kubernetes: kubectl, kubectx, k9s, kompose
- Cloud/IaC: ansible, azure-cli, terraform
- Build: gcc, cmake, ninja, just, autoconf, bison, flex, ccache
- Biblioteki dev + kompresja (libssl-dev, libyaml-dev, liblz4-dev, libzstd-dev, ...)
- Edytory/terminal: vim, neovim, emacs-nox, tmux, screen
- Sieć: openssh, net-tools, dnsutils
- Monitoring: htop, iotop, sysstat, strace, gdb, valgrind, iperf3
- Bazy danych: libpq-dev, libmysqlclient-dev, libmariadb-dev, libsqlite3-dev, unixodbc-dev
- Języki: Node.js, OpenJDK, ICU
- Dokumentacja: pandoc, graphviz, doxygen, tesseract-ocr, texlive
- Kryptografia: gnupg2, openssl, gnutls-bin, libsodium-dev
- Multimedia: ffmpeg, imagemagick, GStreamer, leptonica + narzędzia optymalizacji
- Data tools: jq, jo, miller
- Task management: taskwarrior
- Locale: en_US.UTF-8, pl_PL.UTF-8
- OpenSearch (informacyjnie)

## Uruchamianie

```bash
# Profil bazowy
./ubuntu-setup/install.sh

# Profil pełny
DEV_SETUP_PROFILE=full ./ubuntu-setup/install.sh

# Przez Makefile
make -C ubuntu-setup install     # profil bazowy
make -C ubuntu-setup full        # profil pełny
make -C ubuntu-setup clean       # czyszczenie cache APT
```

`install.sh` można też sourcing'ować z innych skryptów — wtedy nie wykonuje profilu, tylko udostępnia funkcje.

## Rozszerzanie

1. **Nowy pakiet** — dodaj nazwę do odpowiedniej grupy w `config/packages.conf`.
2. **Nowa grupa** — zdefiniuj tablicę w `packages.conf`, utwórz moduł w `modules/` i dodaj `source` + wywołanie w `install.sh`.
3. **Nowa domena** — utwórz katalog `modules/<domain>/` i postępuj jak powyżej.

## Notatki

- Skrypty wymagają `sudo` — APT instaluje do przestrzeni systemowej.
- Docker: po instalacji trzeba otworzyć nową sesję (`newgrp docker` lub relogin).
- Profile `run_base_profile` vs `run_full_profile` dzielą się na szybkie uruchomienie vs pełne zasoby.
- Instalacja grup pakietów pomija brakujące pakiety w repozytoriach, logując ostrzeżenie zamiast przerywać proces.
- `gh` ma fallback do oficjalnego repozytorium GitHub CLI (`https://cli.github.com/packages`) gdy nie ma go w domyślnych repo APT.
