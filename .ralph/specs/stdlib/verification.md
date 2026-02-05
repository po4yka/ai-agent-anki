# Standard Library: Verification Patterns

Verification patterns for Anki batch operations.

## Verification Levels

```
PRE-BATCH → PER-CARD → POST-BATCH → FINAL
```

## Pre-Batch Verification

Run before starting any batch:

### 1. Connection Check

```
result = mcp__anki__deckActions({ action: "deckNames" })

VERIFY:
  - Result is not error
  - Result is array
  - Array is not empty (Anki has decks)

ON FAIL: STOP, report CONNECTION_FAILED
```

### 2. Deck Existence

```
decks = mcp__anki__deckActions({ action: "deckNames" })

VERIFY:
  - Target deck in decks list

ON FAIL:
  - Create deck: mcp__anki__deckActions({ action: "createDeck", params: { deck: targetDeck }})
  - Verify creation succeeded
```

### 3. Note Type Availability

```
models = mcp__anki__modelNames()

VERIFY:
  - "Basic" in models
  - "Cloze" in models (if using cloze cards)

ON FAIL: STOP, report missing note types
```

### 4. Pre-existing Count

```
existing = mcp__anki__findNotes({ query: f"deck:\"{targetDeck}\"" })
initialCount = len(existing)

# Store for post-batch comparison
```

## Per-Card Verification

Run after each card creation:

### 1. ID Returned

```
result = mcp__anki__addNote({ note: {...} })

VERIFY:
  - Result is not null
  - Result is not error
  - Result is numeric (note ID)

ON FAIL: Log error, increment failure count
```

### 2. Card Exists (optional, for critical cards)

```
info = mcp__anki__notesInfo({ notes: [noteId] })

VERIFY:
  - info[0] exists
  - info[0].fields.Front matches expected
  - info[0].tags includes "ralph-sync"

ON FAIL: Log warning, card may not have been created
```

## Post-Batch Verification

Run after each batch of 15 cards:

### 1. Batch Count Check

```
# Query cards created in this batch
batchTag = f"ralph-{batchId}"  # Or use timestamp
results = mcp__anki__findNotes({ query: f"tag:{batchTag}" })

VERIFY:
  - len(results) == expectedBatchCount

ON FAIL: Log discrepancy, continue with warning
```

### 2. Connection Still Active

```
# Re-verify connection before next batch
result = mcp__anki__deckActions({ action: "deckNames" })

VERIFY:
  - Connection still works

ON FAIL: Pause, retry 3x, then STOP
```

### 3. Error Threshold Check

```
VERIFY:
  - consecutiveErrors < 3
  - totalErrors < (totalCards * 0.1)  # Less than 10% error rate

ON FAIL: STOP, report ERROR_THRESHOLD
```

## Final Verification

Run after all batches complete:

### 1. Total Count Verification

```
# Count all cards with ralph-sync tag from this session
monthTag = f"ralph-{datetime.now().strftime('%Y-%m')}"
results = mcp__anki__findNotes({ query: f"tag:ralph-sync tag:{monthTag}" })

VERIFY:
  - len(results) >= expectedTotal - allowedSkips

ON FAIL: Report discrepancy in final summary
```

### 2. Deck Population Check

```
deckCards = mcp__anki__findNotes({ query: f"deck:\"{targetDeck}\"" })
finalCount = len(deckCards)

VERIFY:
  - finalCount == initialCount + cardsCreated

ON FAIL: Report discrepancy
```

### 3. Sample Card Verification

```
# Verify a random sample of created cards
sample = random.sample(createdIds, min(5, len(createdIds)))
infos = mcp__anki__notesInfo({ notes: sample })

VERIFY:
  - All samples exist
  - All samples have correct tags
  - All samples have non-empty fields

ON FAIL: Report which cards failed verification
```

## Verification Report Format

```
VERIFICATION_REPORT
==================
Pre-batch checks: PASSED
Per-card checks: 73/75 PASSED (2 warnings)
Post-batch checks: 5/5 PASSED
Final verification: PASSED

Details:
- Initial deck count: 150
- Final deck count: 223
- Cards created: 73
- Cards skipped: 2
- Verification errors: 0

Sample verification (5 cards):
- Card 1234567890: OK
- Card 1234567891: OK
- Card 1234567892: OK
- Card 1234567893: OK
- Card 1234567894: OK
```

## Quick Health Check

Fast verification that system is working:

```
def healthCheck():
  # 1. Connection
  decks = mcp__anki__deckActions({ action: "deckNames" })
  if error: return "FAIL: No connection"

  # 2. Can query
  notes = mcp__anki__findNotes({ query: "is:new" })
  if error: return "FAIL: Cannot query"

  # 3. Can get info (if notes exist)
  if len(notes) > 0:
    info = mcp__anki__notesInfo({ notes: [notes[0]] })
    if error: return "FAIL: Cannot get note info"

  return "OK: All checks passed"
```

Usage before any operation:
```
status = healthCheck()
if status != "OK":
  RALPH_STATUS: HEALTH_CHECK_FAILED
  {status}
  STOP
```
