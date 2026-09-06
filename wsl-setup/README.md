# wsl-setup

Lustrzana kopia `ubuntu-setup` dla Ubuntu w WSL 2. Te same grupy pakietów APT i te same domeny modułów, ale **warstwa wykonawcza jest oddzielona** od definicji instalacji.

`ubuntu-setup/install.sh` jednocześnie ładuje moduły, definiuje profile i je uruchamia. Tutaj `install.sh` jest cienkim dispatcherem — kolejność kroków, prerequisite’y, weryfikacja i notatki żyją w `exec/`.

## Struktura

```text
wsl-setup/
├── config/
│   ├── packages.conf       # Lustrzane grupy pakietów APT (jak ubuntu-setup)
│   └── settings.conf       # Locale + przełączniki WSL
├── modules/                # Funkcje instalacji (bez orkiestracji)
│   ├── system/             # update, locale, cleanup, wsl-environment
│   ├── python/             # pakiety, menedżery, devtools
│   ├── devops/             # git, vcs, docker
│   └── infrastructure/     # build, libs, network, monitoring, ...
├── exec/                   # Oddzielona struktura wykonawcza
│   ├── load.sh             # Composition root: helpers + config + modules + profiles
│   ├── prerequisites.sh    # Detekcja WSL 2, apt, systemd
│   ├── verify.sh           # Sprawdzenie narzędzi po instalacji
│   ├── notes.sh            # Notatki operatorskie (Docker Desktop, /mnt/c)
│   └── profiles/
│       ├── base.sh         # Szybki bootstrap
│       └── full.sh         # Pełny stack
├── scripts/
│   └── helpers.sh          # Logowanie, apt, detekcja WSL/arch
├── install.sh              # Cienki punkt wejścia (tylko dispatch profilu)
├── Makefile
└── README.md
```

## Różnice względem ubuntu-setup

| Obszar | ubuntu-setup | wsl-setup |
| --- | --- | --- |
| Orkiestracja | `install.sh` (wszystko w jednym pliku) | `exec/` (load, profiles, verify, notes) |
| Wejście | `install.sh` ładuje i uruchamia | `install.sh` tylko source + dispatch |
| Docker | `docker.io` + `systemctl` | Docker Desktop WSL (domyślnie); `docker.io` opcjonalnie |
| systemd | zakładany | wykrywany; opcjonalny zapis do `/etc/wsl.conf` |
| Profiling | instalacja bez komentarza | ostrzeżenie o kernelu Microsoft WSL |

## Wymagania wstępne

- **WSL 2** (`wsl.exe --set-version <distro> 2`)
- Distro **Ubuntu/Debian** z `apt`
- Uruchomienie **wewnątrz WSL**, nie z PowerShell/CMD
- Opcjonalnie: **Docker Desktop** z integracją WSL (zalecane)

## Profile instalacyjne

### Profil bazowy (domyślny)

1. Sprawdzenie WSL 2 / apt / systemd
2. Aktualizacja systemu
3. Podstawowe pakiety (`BASIC_PACKAGES`)
4. Git, git-lfs, GitHub CLI (`gh`), lazygit
5. Docker (Desktop jeśli dostępny; inaczej informacja)
6. Pakiety Pythona + menedżery (uv, Poetry)
7. Weryfikacja i podsumowanie

### Profil pełny

Wszystko z profilu bazowego plus te same grupy co w `ubuntu-setup` (terminal CLI, build, libs, docs, crypto, multimedia, locale, cleanup, OpenSearch informacyjnie). Bez Kubernetes i Cloud/IaC.

## Uruchamianie

```bash
# Profil bazowy
./wsl-setup/install.sh

# Profil pełny
WSL_SETUP_PROFILE=full ./wsl-setup/install.sh

# Przez Makefile
make -C wsl-setup install     # profil bazowy
make -C wsl-setup full        # profil pełny
make -C wsl-setup clean       # czyszczenie cache APT
```

`install.sh` można sourcing’ować — wtedy nie wykonuje profilu, tylko udostępnia funkcje.

## Przełączniki (`config/settings.conf` / env)

| Zmienna | Domyślnie | Znaczenie |
| --- | --- | --- |
| `WSL_SETUP_PROFILE` | (puste = base) | `full` uruchamia pełny profil |
| `WSL_PREFER_DOCKER_DESKTOP` | `true` | nie instaluje `docker.io`, gdy Docker nie jest już dostępny |
| `WSL_REQUIRE_WSL2` | `true` | przerywa na WSL 1 |
| `WSL_CONFIGURE_SYSTEMD` | `false` | gdy `true`, dopisuje `systemd=true` do `/etc/wsl.conf` |

Przykład: natywny Docker w distro (wymaga systemd):

```bash
WSL_PREFER_DOCKER_DESKTOP=false WSL_CONFIGURE_SYSTEMD=true ./wsl-setup/install.sh
```

Po zmianie `wsl.conf`: `wsl.exe --shutdown` z Windows i ponowne otwarcie terminala.

## Rozszerzanie

1. **Nowy pakiet** — dodaj nazwę do grupy w `config/packages.conf` (utrzymuj lustrzane nazwy względem `ubuntu-setup`).
2. **Nowa grupa** — tablica w `packages.conf`, moduł w `modules/`, `source` w `exec/load.sh`, wywołanie w `exec/profiles/`.
3. **Nowy krok runbooka** — tylko `exec/profiles/*.sh` (moduły pozostają funkcjami bez side-effectów przy source).

## Notatki

- Trzymaj repozytoria na filesystemie Linux (`~/code`), nie na `/mnt/c`.
- GUI (`vim-gtk3`) wymaga WSLg.
- `perf` / `bpfcc` często nie działają na kernelu Microsoft WSL.
- Instalacja grup pakietów pomija brakujące pakiety i loguje ostrzeżenie zamiast przerywać proces.
