# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles for **macOS and Linux**, managed with [chezmoi](https://www.chezmoi.io). This repository IS the chezmoi source directory, cloned at `~/.local/share/chezmoi`. Files deploy to `$HOME` as **real copies** (not symlinks).

## Source Naming Conventions

chezmoi encodes target attributes in source filenames:

```
dot_zshrc                    → ~/.zshrc
dot_zsh/aliases.zsh          → ~/.zsh/aliases.zsh
dot_zsh/private_aliases.zsh  → ~/.zsh/aliases.zsh  (mode 0600 preserved via private_)
dot_config/starship.toml     → ~/.config/starship.toml
dot_gitconfig.tmpl           → ~/.gitconfig        (Go template; .tmpl suffix)
.chezmoiignore               → targets chezmoi must never manage
```

## Managed Targets

- `~/.zshrc` — plain zsh, sources everything in `~/.zsh/*.zsh`
- `~/.zsh/aliases.zsh`, `~/.zsh/function.zsh`
- `~/.gitconfig` (template)
- `~/.config/starship.toml` — includes Claude Code statusline profile

## Secrets Policy

**NEVER commit secrets to this repo — it is PUBLIC.**

- `~/.zsh/secrets.zsh` holds local tokens; it is excluded via `.chezmoiignore` and sourced by the `~/.zsh/*.zsh` loop in `.zshrc`
- Scan staged files for token/key/password patterns before every push
- Upgrade path if needed: 1Password CLI (`op read`) or chezmoi + age encryption

## Portability Rules (macOS + Linux)

- `.zshrc` stays **plain zsh** with shell guards (`command -v ...`, `[ -f ... ]`) — no templating. Anything optional must be guarded so a machine without the tool still gets a clean shell
- Use `$HOME` / `${HOME}` — never hardcode `/Users/jonduarte`
- Use `$(brew --prefix)` instead of `/opt/homebrew` (differs on Linuxbrew)
- `dot_gitconfig.tmpl` wraps the `gh` credential helper in `{{ if eq .chezmoi.os "darwin" }}` because git has no OS-conditional include
- Unmanaged files other machines need manually: `~/.gitconfig-gorilla`, the `github.com-gorilla` SSH host alias in `~/.ssh/config`, `~/.zsh/secrets.zsh`

## Common Commands

```bash
chezmoi edit --apply ~/.zshrc   # edit source file and deploy immediately
chezmoi add <path>              # start managing a file (reads from live target)
chezmoi diff                    # preview changes chezmoi would make to $HOME
chezmoi apply                   # deploy source state to $HOME
chezmoi update                  # pull repo + apply
chezmoi cd                      # shell into the source dir
chezmoi managed                 # list managed targets
chezmoi doctor                  # health check
```

## Workflow

- Work on a branch, open a PR, merge only after review — no exceptions (even docs/config-only changes)
- Bootstrap a new machine (installs chezmoi if missing, clones, applies):
  ```bash
  sh -c "$(curl -fsSL get.chezmoi.io)" -- init --apply jonjpbm/dotfiles
  ```
- Then create `~/.zsh/secrets.zsh` manually (chmod 600) — it is never in the repo

## History Note

This repo previously used **dotter**, then **tuckr** (symlink-based, never pushed). The chezmoi migration (2026-09) superseded both; tuckr symlinks were replaced with real copies.
