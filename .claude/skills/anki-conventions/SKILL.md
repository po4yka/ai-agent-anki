---
name: anki-conventions
description: >
  Anki card creation patterns, query syntax, FSRS settings, and spaced repetition principles.
  Use when creating flashcards, querying decks, discussing learning strategies, managing backlogs,
  or working with AnkiConnect API. Triggers on: anki, flashcard, spaced repetition, deck, card,
  note type, cloze, review, fsrs, retention, interval, backlog, leech, ease, programming card,
  code card, suspend, due, overdue.
---

# Anki Conventions

## User Preferences

**Longer technical cards are acceptable.** For programming topics, the atomic rule is relaxed:
- Code snippets need sufficient context
- Multi-line examples demonstrating patterns are fine
- Gotcha explanations can include related pitfalls

See `references/programming-cards.md` for technical card patterns.

## Quick Reference

### Query Syntax (Most Common)

| Query | Description |
|-------|-------------|
| `deck:Name` | Cards in deck |
| `deck:Parent::Child` | Cards in subdeck |
| `tag:tagname` | Cards with tag |
| `-tag:tagname` | Cards without tag |
| `is:due` | Due for review |
| `is:new` | Unstudied cards |
| `is:suspended` | Suspended cards |
| `prop:due<0` | Overdue cards |
| `added:N` | Added in last N days |
| `front:text` | Search Front field |

Combine with spaces (AND) or `OR`.

### Card Design Principles

1. **Atomic**: One fact per card (relaxed for programming)
2. **Clear**: Unambiguous question, single correct answer
3. **Contextual**: Enough context to avoid ambiguity
4. **Connected**: Reference related concepts

### FSRS Quick Setup

1. Enable FSRS in deck options
2. Set desired retention to **0.90**
3. Learning step: **15m or 30m** (single step)
4. Click "Optimize" monthly
5. Use **Again** and **Good** primarily (never "Hard" when forgotten)

### Note Types

| Type | Use Case |
|------|----------|
| Basic | Simple Q&A |
| Basic (reversed) | Learn both directions |
| Cloze | Fill-in-the-blank, lists, definitions |

### MCP Tools Available

```
mcp__anki__addNote        # Create note
mcp__anki__findNotes      # Search notes
mcp__anki__notesInfo      # Get note details
mcp__anki__updateNoteFields  # Modify note
mcp__anki__deleteNotes    # Remove notes
mcp__anki__deckActions    # Deck operations
mcp__anki__modelNames     # List note types
mcp__anki__sync           # Sync with AnkiWeb
```

### Backlog Quick Recovery

```
# Find overdue cards
prop:due<0

# Suspend, tag, then unsuspend batches daily
```

### Verification Pattern

Always verify operations:
1. After `addNote`: Check returned ID is not null
2. After `updateNoteFields`: Re-fetch to confirm
3. After `deleteNotes`: Verify removal

## Detailed References

| Topic | Reference File |
|-------|----------------|
| Query syntax | `references/query-syntax.md` |
| Card patterns | `references/card-patterns.md` |
| Note types | `references/note-types.md` |
| **FSRS settings** | `references/fsrs-settings.md` |
| **Programming cards** | `references/programming-cards.md` |
| **Deck organization** | `references/deck-organization.md` |
| **Card maintenance** | `references/card-maintenance.md` |
| **Troubleshooting** | `references/troubleshooting.md` |

## Background Research

For comprehensive background on spaced repetition best practices:
- `docs/anki-best-practices-2026.md` - Research on FSRS, card design, anti-patterns
- `docs/claude-code-integration.md` - Technical API and MCP reference
