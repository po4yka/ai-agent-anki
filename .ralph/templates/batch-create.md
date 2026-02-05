# Batch Card Creation Task

Template for creating cards from a list or document.

## Task Definition

**Objective**: Create [NUMBER] flashcards from [SOURCE]
**Target Deck**: [DECK_NAME]
**Note Type**: Basic / Cloze
**Source**: [File path or description]

## Pre-Processing

- [ ] Verify Anki connection
- [ ] Confirm deck exists: `[DECK_NAME]`
- [ ] Verify note type available
- [ ] Count existing cards in deck (baseline)

## Card Data

<!-- Replace with actual card data -->

| # | Front | Back | Tags |
|---|-------|------|------|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| ... | | | |

## Batch Execution

### Batch 1 (Cards 1-15)

```
FOR cards 1-15:
  1. Check duplicate: front field
  2. Create card with tags: ralph-sync, ralph-YYYY-MM, [SOURCE_TAG]
  3. Verify creation succeeded
  4. Log result
```

- [ ] Process cards 1-15
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE

### Batch 2 (Cards 16-30)

- [ ] Process cards 16-30
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE

### Batch N (Remaining)

- [ ] Process remaining cards
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE

## Post-Processing

- [ ] Verify total count
- [ ] Generate summary
- [ ] Emit RALPH_COMPLETE

## Expected Output

```
RALPH_COMPLETE
Summary:
- Total cards processed: [NUMBER]
- Created: [N]
- Skipped (duplicates): [N]
- Failed: [N]
- Deck: [DECK_NAME]
- Tags: ralph-sync, ralph-YYYY-MM, [SOURCE_TAG]
```

## Error Log

| Card # | Error | Resolution |
|--------|-------|------------|
| | | |

## Notes

<!-- Special handling, observations -->
