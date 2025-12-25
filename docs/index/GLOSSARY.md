# Glossary

This glossary defines project-specific terms, acronyms, and distinct concepts that are not assumed knowledge for developers familiar with the core technologies (e.g., Nix, common programming paradigms).

*   **DeepWiki**: The project's comprehensive internal documentation set, explaining the "how" and "why" of the system's design and implementation. It focuses on conveying the mental model for developers.

*   **Opencode Agent**: An autonomous software entity designed to perform specific, often complex, tasks within the codebase. Agents operate with defined roles and permissions, contributing to an AI-assisted development workflow (e.g., `indexer`, `explorer`).

*   **Nix Flake**: A modern, self-contained, and reproducible unit of a Nix project. It defines a project's inputs (dependencies) and outputs (packages, development environments) in a standardized way, enabling easier sharing and consumption. While Nix itself is a core technology, the "flake" concept represents a specific, advanced pattern of its usage within this project.

*   **`nvimrc`**: The conventional root directory for Neovim's runtime configuration. In this project, it specifically refers to the `/home/mmfallacy/.nixnvim/nvimrc` directory, which contains all Lua-based settings, plugin configurations, and custom scripts for Neovim.

*   **`lazy.nvim`**: A high-performance, declarative plugin manager for Neovim. It is used in this project to efficiently manage and load Neovim plugins on-demand, contributing to faster startup times and a modular configuration.
