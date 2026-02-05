# Obsidian to Anki Sync Task

Template for syncing Obsidian notes to Anki.

## Task Definition

**Objective**: Sync notes from Obsidian vault to Anki
**Vault Path**: [PATH_TO_VAULT]
**Note Pattern**: [PATTERN, e.g., "**/*flashcards*.md"]
**Target Deck**: [DECK_NAME] (or derive from note path)
**Card Markers**: `#card` / `#cloze` / YAML frontmatter

## Pre-Processing

- [ ] Verify Anki connection
- [ ] Scan vault for matching notes
- [ ] Extract cards from notes
- [ ] Deduplicate against existing Anki cards
- [ ] Calculate batch count

### Vault Scan Results

| File | Cards Found | Duplicates | To Create |
|------|-------------|------------|-----------|
| | | | |
| | | | |

**Total**: [N] cards to create in [N] batches

## Card Extraction Rules

### Marker-Based Extraction

```markdown
<!-- In Obsidian note -->
Q: What is X?
A: X is...
#card

<!-- Becomes -->
Front: What is X?
Back: X is...
Tags: [source::obsidian, file::<filename>]
```

### Cloze Extraction

```markdown
<!-- In Obsidian note -->
The {{c1::answer}} is found here.
#cloze

<!-- Becomes -->
Text: The {{c1::answer}} is found here.
Tags: [source::obsidian, cloze]
```

### YAML Frontmatter

```yaml
---
anki_deck: Programming::Python
anki_tags: [python, basics]
---
```

## Batch Execution

### Batch 1 (Files/Cards 1-15)

- [ ] Process items 1-15
- [ ] Verify each card created
- [ ] Emit RALPH_STATUS

### Batch N (Remaining)

- [ ] Process remaining items
- [ ] Emit RALPH_STATUS

## Post-Processing

- [ ] Verify sync counts
- [ ] Update sync timestamp in vault (optional)
- [ ] Generate sync report
- [ ] Emit RALPH_COMPLETE

## Expected Output

```
RALPH_COMPLETE
Sync Summary:
- Files processed: [N]
- Cards extracted: [N]
- Cards created: [N]
- Duplicates skipped: [N]
- Errors: [N]
- Decks modified: [list]
- Tags applied: ralph-sync, source::obsidian, ralph-YYYY-MM
```

## Sync Mapping

Track which Obsidian notes map to which Anki cards:

| Obsidian Note | Card Front (truncated) | Anki Note ID |
|---------------|------------------------|--------------|
| | | |
| | | |

## Error Log

| File | Card | Error | Resolution |
|------|------|-------|------------|
| | | | |

## Notes

<!-- Special handling, edge cases, observations -->
