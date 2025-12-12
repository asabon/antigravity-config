# Antigravity Configuration

Shared configuration repository for **Antigravity** agentic coding assistant. This repository serves as a centralized source for rules, workflows, and preferences that can be shared across multiple projects.

## Overview

This repository provides:

- **Global Rules**: Standardized coding guidelines and agent behaviors stored in `.antigravity.yml`.
- **Workflows**: Reusable agent workflows (e.g., init, resume, save) in `.agent/workflows`.
- **User Configuration**: Template for personalizing agent interaction settings.

## Design Philosophy

This configuration is built upon the following core principles:

1.  **Safety & Stability**:
    We prioritize non-destructive operations. The agent is strictly restricted to writing temporary files only within the `.agent/work` directory, preventing accidental clutter or modification of source code without explicit intent.
2.  **Global Standard, Local Comfort**:
    To ensure portability across diverse teams, the base rules and documentation are written in English. However, actual interaction with the agent respects the user's preferred language defined in `config.yml`.
3.  **Flexible Integration**:
    We support both "strict synchronization" (via submodules and symlinks) for teams wanting centralized control, and "selective adoption" (via manual copying) for projects needing customization.

## Getting Started

1. **Add as Submodule**:
   Run the following command in your project root to add this repository as a submodule.
   ```bash
   git submodule add https://github.com/asabon/antigravity-config.git .shared-config
   ```

2. **Apply Configuration**:
   Choose one of the following methods to apply the configuration.

   ### Option A: Automatic Linking (Recommended)
   Run the setup script to create symlinks. This ensures your project always uses the latest shared configuration.

   **Windows (PowerShell):**
   ```powershell
   ./.shared-config/scripts/setup.ps1
   ```

   **macOS / Linux:**
   ```bash
   chmod +x .shared-config/scripts/setup.sh
   ./.shared-config/scripts/setup.sh
   ```

   ### Option B: Manual Copy / Reference
   If you prefer to selectively adopt rules or workflows:

   1. Run the manual setup script to copy the helper workflow.
      ```powershell
      ./.shared-config/scripts/setup-manual.ps1  # Windows
      # OR
      ./.shared-config/scripts/setup-manual.sh   # macOS / Linux
      ```
   2. Use the AI agent to compare and adopt configurations.
      - Run `/check-updates` in the chat.
      - The agent will show diffs between your project and `.shared-config`.
      - Instruct the agent to copy/merge the files you want (e.g., "Adopt the global rules").

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

- **/check-updates**: Check for updates from the shared configuration submodule.
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