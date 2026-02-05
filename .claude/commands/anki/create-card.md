---
description: Create Anki flashcard from conversation context or specified topic
argument-hint: "[topic] [--deck DeckName] [--tags tag1,tag2] [--type Basic|Cloze]"
allowed-tools: [Read, Grep, Glob, mcp__anki__addNote, mcp__anki__findNotes, mcp__anki__modelNames, mcp__anki__modelFieldNames, mcp__anki__deckActions]
---

# Create Anki Card

## Task

Create a high-quality Anki flashcard based on conversation context or a specified topic.

## Arguments

- `topic` (optional): Subject matter for the card
- `--deck`: Target deck name (default: "Default")
- `--tags`: Comma-separated tags to apply
- `--type`: Note type - Basic, Basic (and reversed card), or Cloze

## Process

### 1. Gather Context

If topic provided:
- Use the topic as the basis for the card

If no topic:
- Extract the most recent learning point from conversation
- Identify the core concept worth remembering

### 2. Verify Prerequisites

```
mcp__anki__deckActions with listDecks
```

- Confirm target deck exists
- If deck doesn't exist, offer to create it

### 3. Select Note Type

```
mcp__anki__modelNames
```

- Use specified `--type` or default to "Basic"
- For definitions/lists, suggest Cloze
- For vocabulary, suggest Basic (and reversed card)

### 4. Design the Card

Apply card design principles:

**Atomic**: One fact per card
**Clear**: Unambiguous question
**Contextual**: Enough context to avoid confusion

For Basic:
- Front: Clear, specific question
- Back: Concise, complete answer

For Cloze:
- Create fill-in-the-blank with `{{c1::hidden}}`
- Use multiple cloze numbers for separate cards

### 5. Check for Duplicates

```
mcp__anki__findNotes with query matching key terms
```

- Search for similar existing cards
- If duplicate found, show it and ask user for action

### 6. Create the Card

```
mcp__anki__addNote
```

Parameters:
- deckName: Target deck
- modelName: Selected note type
- fields: Front/Back or Text depending on type
- tags: From --tags argument

### 7. Verify Creation

- Check that returned note ID is not null
- If null, report the error

### 8. Confirm to User

Display:
- Created card content (Front/Back)
- Deck and tags applied
- Note ID for reference

## Error Handling

| Error | Action |
|-------|--------|
| Deck not found | Offer to create with `deckActions createDeck` |
| Duplicate detected | Show existing card, ask to proceed or cancel |
| Invalid note type | List available types, ask user to choose |
| Connection failed | Remind user to start Anki with AnkiConnect |

## Examples

```
/anki-create What is a closure in JavaScript?
/anki-create --deck Programming --tags javascript,functions
/anki-create "Python list comprehension" --type Cloze
```
