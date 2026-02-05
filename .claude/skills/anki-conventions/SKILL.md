---
name: anki-conventions
description: >
  Anki card creation patterns, query syntax, and spaced repetition principles.
  Use when creating flashcards, querying decks, discussing learning strategies,
  or working with AnkiConnect API. Triggers on: anki, flashcard, spaced repetition,
  deck, card, note type, cloze, review.
---

# Anki Conventions

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
| `added:N` | Added in last N days |
| `front:text` | Search Front field |

Combine with spaces (AND) or `OR`.

### Card Design Principles

1. **Atomic**: One fact per card
2. **Clear**: Unambiguous question, single correct answer
3. **Contextual**: Enough context to avoid ambiguity
4. **Connected**: Reference related concepts

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

### Verification Pattern

Always verify operations:
1. After `addNote`: Check returned ID is not null
2. After `updateNoteFields`: Re-fetch to confirm
3. After `deleteNotes`: Verify removal

## Detailed References

- **Query syntax**: See `references/query-syntax.md`
- **Card patterns**: See `references/card-patterns.md`
- **Note types**: See `references/note-types.md`
