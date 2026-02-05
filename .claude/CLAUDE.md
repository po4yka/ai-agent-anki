# AI Agent Anki - Project Instructions

This project provides Claude Code infrastructure for working with Anki via AnkiConnect.

## Prerequisites

- Anki desktop app running
- AnkiConnect add-on installed (code: 2055492159)
- MCP server configured: `@ankimcp/anki-mcp-server`

## Available Commands

| Command | Description |
|---------|-------------|
| `/anki-create-card` | Create a flashcard from conversation |
| `/anki-sync-vault` | Sync Obsidian notes to Anki |
| `/anki-review-session` | Interactive review session |
| `/anki-deck-stats` | View deck statistics |
| `/anki-search-cards` | Search cards by query |

## Available Agents

| Agent | Use Case |
|-------|----------|
| `anki-card-creator` | Create quality cards (auto-triggers) |
| `anki-researcher` | Extract cards from documents |
| `anki-sync-agent` | Bulk sync operations |

## Skill: anki-conventions

Auto-loaded when discussing Anki topics. Provides:
- Query syntax reference
- Card design patterns
- Note type guidance

## Quick Start

```
# Create a card from current conversation
/anki-create-card "What is X?" --deck MyDeck

# Check deck statistics
/anki-deck-stats

# Search for cards
/anki-search-cards "tag:programming is:due"

# Start review
/anki-review-session MyDeck --limit 10
```

## File Locations

```
.claude/
├── skills/anki-conventions/    # Background knowledge
├── commands/anki/              # Slash commands
├── agents/                     # Specialized agents
├── hooks/                      # Event scripts
└── settings.json               # Project configuration
```

## Configuration

This project disables global components not relevant to Anki workflows:

### Enabled

| Component | Type | Purpose |
|-----------|------|---------|
| anki MCP | Server | Core Anki integration |
| superpowers | Plugin | Brainstorming, TDD, debugging |
| commit-commands | Plugin | Git workflows |
| claude-hud | Plugin | Status line |

### Disabled (for this project)

| Component | Type | Reason |
|-----------|------|--------|
| atlassian MCP | Server | Jira/Confluence not needed |
| obsidian MCP | Server | Using file-based sync instead |
| backend-development | Plugin | Server patterns not needed |
| firebase | Plugin | Unrelated |
| voltagent-infra | Plugin | Infrastructure not needed |
| llm-application-dev | Plugin | RAG/LLM patterns not needed |
| documentation-generator | Plugin | Doc generation not needed |
| code-simplifier | Plugin | Refactoring not primary |
| python-development | Plugin | Not writing Python here |
| claude-delegator | Plugin | GPT delegation not needed |
| para-method | Skill | Note organization not primary |

To re-enable any component, edit `.claude/settings.json`.
