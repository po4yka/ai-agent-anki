# Standard Library: Anki Batch Patterns

Reusable patterns for Anki batch operations.

## Connection Check Pattern

Use before any batch operation:

```
# Step 1: Check connection
result = mcp__anki__deckActions({ action: "deckNames" })

# Step 2: Validate response
if result is error or empty:
  RALPH_STATUS: CONNECTION_FAILED
  STOP

# Step 3: Confirm target deck exists
if targetDeck not in result:
  # Create deck
  mcp__anki__deckActions({
    action: "createDeck",
    params: { deck: targetDeck }
  })
```

## Batch Creation Pattern

Standard flow for creating a batch of cards:

```
BATCH_SIZE = 15
errors = []
created = []
skipped = []

FOR i, card IN enumerate(batch):
  # 1. Deduplication check
  existing = mcp__anki__findNotes({
    query: f"front:\"{card.front}\""
  })

  IF existing is not empty:
    skipped.append({ card: card, reason: "duplicate" })
    CONTINUE

  # 2. Create card
  TRY:
    result = mcp__anki__addNote({
      note: {
        deckName: card.deck,
        modelName: card.noteType or "Basic",
        fields: {
          Front: card.front,
          Back: card.back
        },
        tags: buildTags(card)
      }
    })

    IF result.error:
      errors.append({ card: card, error: result.error })
    ELSE:
      created.append({ card: card, id: result })

  CATCH error:
    errors.append({ card: card, error: str(error) })

# 3. Emit status
RALPH_STATUS: BATCH_COMPLETE
Created: {len(created)}
Skipped: {len(skipped)}
Errors: {len(errors)}
```

## Tag Builder Pattern

Standard tags for all ralph-created cards:

```
def buildTags(card):
  tags = [
    "ralph-sync",
    f"ralph-{datetime.now().strftime('%Y-%m')}"
  ]

  if card.source:
    tags.append(f"source::{card.source}")

  if card.tags:
    tags.extend(card.tags)

  return tags
```

## RALPH_STATUS Block Format

Standard format for progress reporting:

```
RALPH_STATUS: <STATUS_CODE>
<Key>: <Value>
<Key>: <Value>
...
```

### Status Codes

| Code | Meaning |
|------|---------|
| `BATCH_COMPLETE` | Finished processing a batch |
| `CONNECTION_FAILED` | Cannot reach Anki |
| `ERROR_THRESHOLD` | Too many consecutive errors |
| `PAUSED` | Waiting for user intervention |

### Standard Fields

```
RALPH_STATUS: BATCH_COMPLETE
Batch: 3/7              # Current / Total batches
Cards created: 45       # This batch
Cards skipped: 2        # This batch (duplicates)
Cards failed: 0         # This batch (errors)
Running total: 47/105   # Total created / Total expected
Success rate: 96%       # Overall percentage
Time elapsed: 12m       # Since start
```

## Error Recovery Pattern

When errors occur:

```
consecutive_errors = 0
MAX_CONSECUTIVE = 3

FOR card IN batch:
  result = createCard(card)

  IF result.error:
    consecutive_errors += 1
    log_error(card, result.error)

    IF consecutive_errors >= MAX_CONSECUTIVE:
      RALPH_STATUS: ERROR_THRESHOLD
      Consecutive failures: {consecutive_errors}
      Last error: {result.error}
      Action: STOPPING - manual intervention required
      STOP
  ELSE:
    consecutive_errors = 0  # Reset on success
```

## Checkpoint Pattern

Save progress for resumption:

```
CHECKPOINT after each batch:
  {
    "batch_number": 3,
    "total_created": 45,
    "total_skipped": 5,
    "total_failed": 2,
    "last_card_index": 47,
    "timestamp": "2024-01-15T10:30:00Z"
  }

TO RESUME:
  1. Read checkpoint file
  2. Skip to last_card_index + 1
  3. Continue processing
```

## Dry Run Pattern

Test without creating cards:

```
DRY_RUN = true

FOR card IN batch:
  # 1. Parse and validate (same as normal)
  parsed = parseCard(card)
  validated = validateCard(parsed)

  # 2. Check duplicate (same as normal)
  isDuplicate = checkDuplicate(parsed)

  # 3. Skip actual creation
  IF not DRY_RUN:
    createCard(parsed)
  ELSE:
    log(f"Would create: {parsed.front[:50]}...")

# Report what WOULD happen
RALPH_STATUS: DRY_RUN_COMPLETE
Would create: 45
Would skip: 5
Validation errors: 2
```
