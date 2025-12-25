# Patterns

This document outlines recurring coding styles, invariants, idioms, and specific configuration strategies employed within the system.

## 1. Nix-driven Development Environment

The entire development and runtime environment is managed declaratively using Nix. This ensures:
*   **Reproducibility**: The exact same environment can be recreated anywhere.
*   **Consistency**: All developers work with identical toolchains and dependencies.
*   **Isolation**: Dependencies are isolated from the host system.

## 2. Lazy.nvim for Plugin Management

Neovim plugins are managed through `lazy.nvim`, configured entirely in Lua. This strategy provides:
*   **Performance**: Plugins are loaded on-demand, leading to faster Neovim startup times.
*   **Declarative Configuration**: Plugin settings are defined in a structured, readable manner.
*   **Modularity**: Each plugin's configuration is typically encapsulated within its own Lua module.

## 3. Modular Lua Configuration

The Neovim configuration (`nvimrc/lua`) is broken down into small, focused Lua files. This promotes:
*   **Organization**: Configuration for different aspects (keybindings, options, plugins) is logically separated.
*   **Maintainability**: Easier to locate and modify specific settings without affecting unrelated parts.
*   **Readability**: Smaller files are easier to understand and review.

## 4. Plugin-specific Lua Modules

Each significant Neovim plugin typically has its own dedicated Lua module for configuration (e.g., `nvimrc/lua/custom/plugins/lsp/setup.lua`). This centralizes:
*   **Plugin Settings**: All configurations related to a specific plugin are found in one place.
*   **Integration Logic**: How a plugin interacts with other parts of the Neovim setup is clearly defined.

## 5. Opencode Agent Integration

The system incorporates `opencode` agents for specific tasks, indicating a pattern of AI-assisted development. This involves:
*   **Automated Tasks**: Agents handle routine or complex tasks (e.g., indexing, code exploration).
*   **Structured Interaction**: Agents operate within defined roles and permissions, interacting with the codebase in a controlled manner.
*   **Documentation Generation**: Agents contribute to maintaining up-to-date documentation.
