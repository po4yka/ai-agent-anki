# Card Processing Specification

Detailed lifecycle for processing cards through the ralph batch system.

## Card Lifecycle

### Creation Lifecycle
```
Source → Parse → Validate → Deduplicate → Create → Verify → Tag
```

### Review Lifecycle (see card-review.md)
```
Fetch → Analyze → Classify → Improve → Verify → Tag
```

### 1. Source

Cards can originate from:
- **Obsidian notes**: Markdown files with card markers
- **Document extraction**: PDF/text documents
- **Conversation**: User-provided Q&A pairs
- **Structured data**: JSON/CSV imports

### 2. Parse

Extract card components:

```
{
  "front": "Question text",
  "back": "Answer text",
  "noteType": "Basic" | "Cloze",
  "deck": "Parent::Child",
  "tags": ["tag1", "tag2"],
  "source": "origin identifier"
}
```

**Parsing rules:**
- Front field: Required, max 500 characters
- Back field: Required, max 2000 characters
- Deck: Required, use `::` for hierarchy
- Tags: Optional, auto-add `ralph-sync`

### 3. Validate

Check each card before creation:

| Check | Rule | Action on Failure |
|-------|------|-------------------|
| Front not empty | `front.trim().length > 0` | Skip card, log error |
| Back not empty | `back.trim().length > 0` | Skip card, log error |
| Front not too long | `front.length <= 500` | Truncate with "..." |
| Back not too long | `back.length <= 2000` | Truncate with "..." |
| Deck specified | `deck` is non-empty | Use default deck |
| Note type valid | In `["Basic", "Cloze"]` | Default to "Basic" |

### 4. Deduplicate

Before creating, check for existing cards:

```
mcp__anki__findNotes({ query: "front:\"<exact front text>\"" })
```

**Deduplication rules:**
- Exact match on front field: Skip, log as duplicate
- Similar match (>90% similarity): Warn, create anyway with `needs-review` tag
- No match: Proceed with creation

### 5. Create

Call MCP to create the card:

```
mcp__anki__addNote({
  note: {
    deckName: "<deck>",
    modelName: "<noteType>",
    fields: {
      Front: "<front>",
      Back: "<back>"
    },
    tags: ["ralph-sync", "ralph-YYYY-MM", ...otherTags]
  }
})
```

**On success**: Receive note ID
**On failure**: Log error, increment failure count

### 6. Verify

After creation, verify the card exists:

```
mcp__anki__notesInfo({ notes: [<returned_id>] })
```

Confirm:
- Note ID matches
- Fields populated correctly
- Tags applied

### 7. Tag

Final tagging applied to all created cards:

| Tag | Purpose |
|-----|---------|
| `ralph-sync` | Identifies batch-created cards |
| `ralph-YYYY-MM` | Month of creation (e.g., `ralph-2024-01`) |
| `source::<origin>` | Where the card came from |
| `batch::<id>` | Links cards from same batch (optional) |

## Error Handling Matrix

| Error | Severity | Action | Continue? |
|-------|----------|--------|-----------|
| Connection lost | Critical | Retry 3x, then STOP | No |
| Duplicate found | Info | Skip, log | Yes |
| Invalid note type | Warning | Use "Basic" | Yes |
| Field too long | Warning | Truncate | Yes |
| Empty field | Error | Skip card | Yes |
| API timeout | Warning | Retry 1x | Yes |
| 3+ consecutive failures | Critical | STOP | No |

## Batch Processing Flow

```
FOR each batch of 15 cards:
  1. Verify connection
  2. FOR each card in batch:
     a. Parse
     b. Validate
     c. Check duplicate
     d. Create (if valid)
     e. Verify creation
     f. Track success/failure
  3. Emit RALPH_STATUS
  4. Check error threshold
  5. Continue or STOP
```

## Output Formats

### Per-Card Result

```
Card 1: SUCCESS | SKIPPED | FAILED
  Front: "What is..."
  ID: 1234567890
  Reason: [if skipped/failed]
```

### Batch Summary

```
RALPH_STATUS: BATCH_COMPLETE
Batch: 2/5
Cards in batch: 15
Created: 14
Skipped: 1 (duplicate)
Failed: 0
Running total: 29/75
```

### Final Summary

```
RALPH_COMPLETE
Total processed: 75
Created: 71
Skipped: 3
Failed: 1
Decks: ["Programming::Python"]
Duration: 25m
```
