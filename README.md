# Antigravity Configuration

Shared configuration repository for **Antigravity** agentic coding assistant. This repository serves as a centralized source for rules, workflows, and preferences that can be shared across multiple projects.

## Overview

This repository provides:

- **Global Rules**: Standardized coding guidelines and agent behaviors stored in `.antigravity.yml`.
- **Workflows**: Reusable agent workflows (e.g., init, resume, save) in `.agent/workflows`.
- **User Configuration**: Template for personalizing agent interaction settings.

## Getting Started

1. **Add as Submodule**:
   Run the following command in your project root to add this repository as a submodule.
   ```bash
   git submodule add https://github.com/asabon/antigravity-config.git .shared-config
   ```

2. **Run Setup Script**:
   Execute the setup script to create necessary symlinks and configuration files.

   **Windows (PowerShell):**
   ```powershell
   ./.shared-config/scripts/setup.ps1
   ```

   **macOS / Linux:**
   ```bash
   chmod +x .shared-config/scripts/setup.sh
   ./.shared-config/scripts/setup.sh
   ```

3. **Configure `.gitignore`**:
   Add the following to your project's `.gitignore`:
   ```gitignore
   .agent/work/
   .agent/config.yml
   ```

4. **Customize**:
   Edit `.agent/config.yml` (created in step 2) to set your preferred language.

## Usage

This configuration includes standard agent workflows. You can trigger them by using the following slash commands in your chat interface:

- **/init**: Initialize the session (reads project rules, checks environment).
- **/save**: Save your current progress to a checkpoint file.
- **/resume**: Resume work from the last saved progress report.

## Structure

```
.
├── .agent/
│   ├── config.yml.sample   # Template for user-specific settings
│   └── workflows/          # Shared agent workflows
├── .antigravity.yml        # Core configuration and rules
├── README.md               # This file (English)
└── README.ja.md            # Documentation in Japanese
```

## Contributing

- Rules and documentation in this repository should be written in **English**.
- Internal communication will follow the language setting in your local `config.yml`.