# AI Agent Anki

Claude Code infrastructure for working with Anki via AnkiConnect.

## Overview

This project provides a complete Claude Code setup for Anki integration:

- **Skills** - Background knowledge about Anki query syntax, card patterns, and note types
- **Commands** - Slash commands for card creation, sync, review, and search
- **Agents** - Specialized subagents for bulk operations and knowledge extraction
- **Hooks** - Session capture for potential flashcard content

## Prerequisites

1. **Anki** - Desktop application running
2. **AnkiConnect** - Add-on installed (code: `2055492159`)
3. **Claude Code** - CLI installed and configured
4. **Node.js** - For MCP server (npx)

## Installation

```bash
git clone https://github.com/yourusername/ai-agent-anki.git
cd ai-agent-anki
```

The `.claude/` directory contains all configuration. Claude Code will automatically load it when you start a session in this directory.

## Usage

### Commands

| Command | Description |
|---------|-------------|
| `/anki-create-card [topic]` | Create a flashcard from conversation |
| `/anki-sync-vault [path]` | Sync Obsidian notes to Anki |
| `/anki-review-session [deck]` | Interactive review session |
| `/anki-deck-stats [deck]` | View deck statistics |
| `/anki-search-cards <query>` | Search cards by query |

### Examples

```bash
# Start Claude Code in the project
claude

# Create a card
> /anki-create-card "What is a closure?" --deck Programming --tags javascript

# Check deck stats
> /anki-deck-stats Programming

# Search for due cards
> /anki-search-cards "is:due tag:python"

# Start a review session
> /anki-review-session "Japanese Vocabulary" --limit 10
```

### Agents

Agents are automatically invoked based on context:

| Agent | Triggers On | Purpose |
|-------|-------------|---------|
| `anki-card-creator` | "create card", "remember this" | Quality card creation |
| `anki-researcher` | "extract cards from", "study material" | Bulk extraction from docs |
| `anki-sync-agent` | "sync to anki", "bulk import" | Large sync operations |

### Skill

The `anki-conventions` skill auto-loads when discussing Anki topics, providing:

- Query syntax reference
- Card design patterns
- Note type guidance

## Project Structure

```
.
├── .claude/
│   ├── CLAUDE.md                    # Project instructions
│   ├── settings.json                # Configuration
│   ├── skills/
│   │   └── anki-conventions/
│   │       ├── SKILL.md             # Core skill
│   │       └── references/
│   │           ├── query-syntax.md  # Full query reference
│   │           ├── card-patterns.md # Card design patterns
│   │           └── note-types.md    # Note type guide
│   ├── commands/
│   │   └── anki/
│   │       ├── create-card.md
│   │       ├── sync-vault.md
│   │       ├── review-session.md
│   │       ├── deck-stats.md
│   │       └── search-cards.md
│   ├── agents/
│   │   ├── anki-card-creator.md
│   │   ├── anki-researcher.md
│   │   └── anki-sync-agent.md
│   └── hooks/
│       └── anki-session-capture.sh
├── RESEARCH.md                      # Research documentation
├── README.md
├── LICENSE
└── .gitignore
```

## Configuration

The project disables global Claude Code components not relevant to Anki:

**Enabled:**
- `anki` MCP server
- `superpowers` plugin (brainstorming, TDD)
- `commit-commands` plugin (git workflows)
- `claude-hud` plugin (status line)

**Disabled:**
- `atlassian`, `obsidian` MCP servers
- `backend-development`, `firebase`, `voltagent-infra`, etc.

See `.claude/settings.json` to modify.

## Anki Query Syntax

Quick reference for search queries:

| Query | Description |
|-------|-------------|
| `deck:Name` | Cards in deck |
| `tag:tagname` | Cards with tag |
| `is:due` | Due for review |
| `is:new` | New cards |
| `added:7` | Added in last 7 days |
| `front:text` | Search front field |

Combine with spaces (AND) or `OR`. See `references/query-syntax.md` for full documentation.

## Card Design Principles

1. **Atomic** - One fact per card
2. **Clear** - Unambiguous question, single answer
3. **Contextual** - Enough context to avoid confusion
4. **Testable** - Verifiable answer

See `references/card-patterns.md` for detailed patterns.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with Claude Code
5. Submit a pull request

## License

MIT License - see [LICENSE](LICENSE) for details.

## Resources

- [AnkiConnect Documentation](https://git.sr.ht/~foosoft/anki-connect)
- [Anki MCP Server](https://github.com/ankimcp/anki-mcp-server)
- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Spaced Repetition Best Practices](https://www.supermemo.com/en/blog/twenty-rules-of-formulating-knowledge)
