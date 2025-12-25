# Architecture

This document outlines the high-level components and their interactions within the system.

## 1. Nix Configuration

The entire development environment, including Neovim, its plugins, and other tools, is managed declaratively using Nix. This ensures reproducibility and consistency across development setups.

*   **`flake.nix`**: The project's entry point, defining inputs (dependencies) and outputs (packages, devShells).
*   **`nix/devShell.nix`**: Configures the development shell, providing necessary tools and environment variables.
*   **`nix/packages/`**: Contains Nix expressions for various software packages and Neovim plugins.
*   **`nix/vimPlugins/`**: Specifically for packaging Neovim plugins as Nix derivations.

## 2. Neovim Core

The central text editor, configured and extended by the system. Its behavior is primarily driven by Lua configurations and integrated plugins.

## 3. Lua Configuration (`nvimrc/lua`)

This layer provides the primary configuration for Neovim. It defines keybindings, global options, and orchestrates the loading and setup of various plugins.

*   **`nvimrc/init.lua`**: The main entry point for Neovim's Lua configuration.
*   **`nvimrc/lua/custom/`**: Houses custom configurations, organized into modules for clarity.
    *   **`lazy.lua`**: Manages Neovim plugins using `lazy.nvim`.
    *   **`keybinds.lua`, `options.lua`, `commands.lua`, `utils.lua`**: Core Neovim setup and utility functions.
    *   **`plugins/`**: Directory for individual plugin configurations.

## 4. Neovim Plugins

Extend Neovim's functionality. These are managed by `lazy.nvim` (configured in Lua) and often packaged as Nix derivations for consistency.

*   **AI-related plugins**: (e.g., `codecompanion`, `avante`, `opencode`) for AI-assisted development.
*   **Completion (`nvim-cmp`)**: Provides intelligent code completion.
*   **Language Server Protocol (`lsp`)**: Integrates language servers for features like diagnostics, go-to-definition, and refactoring.
*   **Filetype-specific configurations**: Custom settings for different programming languages and file types.

## 5. Opencode Agents

Specialized, autonomous agents designed to interact with the codebase. These agents (e.g., `indexer`, `explorer`) are configured within the `opencode/` directory and contribute to an AI-assisted development workflow.
