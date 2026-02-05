# Agent Verification Commands

This file defines verification patterns for Anki batch processing.
Since Anki operations don't have traditional test suites, we verify via MCP queries.

## Pre-Task Verification

### Connection Check

```bash
# Verify Anki is running and AnkiConnect responds
# Run before any batch operation
```

MCP equivalent:
```
mcp__anki__deckActions({ action: "deckNames" })
```

Expected: Array of deck names (non-empty if Anki has decks)

### Deck Exists Check

```
mcp__anki__deckActions({ action: "deckNames" })
# Verify target deck is in returned list
```

### Model/Note Type Check

```
mcp__anki__modelNames()
# Verify required note types exist: "Basic", "Cloze"
```

## Post-Batch Verification

### Card Count Verification

After creating cards, verify they exist:

```
mcp__anki__findNotes({ query: "tag:ralph-sync added:1" })
# Should return IDs for recently created cards
```

### Specific Card Verification

After creating a card, verify by searching:

```
mcp__anki__findNotes({ query: "front:\"<exact front text>\"" })
# Should return exactly 1 result
```

### Batch Summary Query

```
mcp__anki__findNotes({ query: "tag:ralph-sync tag:ralph-YYYY-MM" })
# Count should match expected batch total
```

## Verification Workflow

```
1. PRE-BATCH
   ├── Connection check (deckActions)
   ├── Target deck exists
   └── Note types available

2. PER-CARD (after each addNote)
   └── Verify returned ID is not null

3. POST-BATCH
   ├── Count cards with batch tag
   ├── Compare to expected count
   └── Report discrepancies

4. FINAL
   ├── Total card count verification
   ├── Generate summary report
   └── Emit RALPH_COMPLETE
```

## Error Recovery

If verification fails:

1. Log the failure with details
2. Attempt retry (max 2 retries)
3. If still failing, add to error list
4. Continue with next card (don't block batch)
5. Include all errors in final summary

## Health Check Command

Quick check that everything is working:

```
# 1. Connection
mcp__anki__deckActions({ action: "deckNames" })

# 2. Can query
mcp__anki__findNotes({ query: "is:new" })

# 3. Can get info
mcp__anki__notesInfo({ notes: [<any_note_id>] })
```

If all three succeed, system is healthy.
