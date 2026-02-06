# Card Review Specification

Review lifecycle and quality rubric for improving existing Anki cards.

## Review Lifecycle

```
Fetch -> Analyze -> Classify -> Improve -> Verify -> Tag
```

### 1. Fetch

Retrieve card content using MCP:

```
mcp__anki__notesInfo({ notes: [noteId] })
```

Extract: Front, Back, Tags, noteId, modelName

### 2. Analyze

Score the card on 5 quality dimensions (see rubric below).

### 3. Classify

Apply the decision tree to determine disposition: KEEP, IMPROVE, SPLIT, or FLAG_FOR_DELETION.

### 4. Improve

Apply the appropriate transformation based on disposition and quality score.

### 5. Verify

Re-fetch the card and confirm changes were applied.

### 6. Tag

Apply tags based on disposition.

---

## 5-Dimension Quality Rubric

Every card is scored PASS or FAIL on each dimension:

| # | Dimension | PASS | FAIL |
|---|-----------|------|------|
| 1 | **Terminology** | Precise technical terms (e.g., "когнитивное искажение", "систематическая тенденция") | Simplified/vague language (e.g., "ошибка мышления", "привычка") |
| 2 | **Question depth** | Tests understanding: why, how, when, conditions | Tests recall only: "Что такое X?", definitions |
| 3 | **Answer quality** | Includes reasoning, concrete examples, mechanisms | Definition or bare fact only |
| 4 | **Connections** | Links to related biases, contexts, or concepts | Isolated fact with no connections |
| 5 | **Applicability** | Enables recognition in real life, includes countermeasures | No practical guidance for applying knowledge |

### Scoring

| Score | Classification | Meaning |
|-------|----------------|---------|
| 5/5 | MASTERY | Card meets all quality standards |
| 3-4/5 | NEEDS_IMPROVEMENT | Good foundation, needs enrichment |
| 0-2/5 | ELEMENTARY | Requires substantial rework |

---

## Decision Tree

```
Is quality = MASTERY (5/5)?
  YES -> KEEP (tag only, no field changes)
  NO  ->
    Is content still relevant to the deck topic?
      NO  -> FLAG_FOR_DELETION
      YES ->
        Does the card test multiple unrelated concepts?
          YES -> SPLIT into 2-3 focused cards
          NO  ->
            Is quality = NEEDS_IMPROVEMENT (3-4/5)?
              YES -> IMPROVE (light enrichment)
              NO  -> IMPROVE (substantial rework)
```

---

## Disposition Actions

| Disposition | Action | Tags Added |
|-------------|--------|------------|
| **KEEP** | Tag only, no field changes | `ralph-reviewed` |
| **IMPROVE (light)** | Enrich answer: add examples, countermeasures, connections. Keep question if it already tests understanding. | `ralph-reviewed`, `ralph-improved` |
| **IMPROVE (substantial)** | Reformulate question AND answer using mastery template from `domain-examples.md` | `ralph-reviewed`, `ralph-improved` |
| **SPLIT** | Create 2-3 focused cards via `addNote`, suspend original via tag | `ralph-reviewed`, `ralph-split-source` (on original) |
| **FLAG_FOR_DELETION** | Tag for manual review. Do NOT delete the card. | `ralph-reviewed`, `ralph-delete-candidate` |

### IMPROVE (light) - What to Change

Only enrich the answer field:
- Add concrete examples (2-3 real-world scenarios)
- Add countermeasures (2-3 strategies)
- Add related biases section
- Preserve existing correct content

### IMPROVE (substantial) - What to Change

Reformulate both fields using the mastery template:
- Question: Use "Как/Почему/Когда" starters (ref `domain-examples.md`)
- Answer: Full mastery structure (definition + examples + countermeasures + connections)

### SPLIT - When and How

A card should be split when it combines multiple unrelated concepts. Example:
- Original: "Что такое эффект привязки и неприятие потерь?" -> Split into 2 cards

To split:
1. Create new focused cards via `mcp__anki__addNote`
2. Tag original with `ralph-split-source` (do NOT delete)
3. Tag new cards with `ralph-reviewed`, `ralph-split-child`

---

## Verification After Edit

After every `updateNoteFields` call:

```
1. Re-fetch: mcp__anki__notesInfo({ notes: [noteId] })
2. Confirm: Front field matches intended improvement
3. Confirm: Back field matches intended improvement
4. Confirm: Tags include ralph-reviewed
5. If card is STILL ELEMENTARY after improvement: add tag needs-manual-review
```

---

## Error Handling

| Error | Action |
|-------|--------|
| Note not found (notesInfo returns empty) | Skip, log noteId, continue to next card |
| `updateNoteFields` fails | Keep original card unchanged, add tag `needs-manual-review` |
| `addNote` fails (for SPLIT) | Keep original card, tag `needs-manual-review`, continue |
| 3+ consecutive failures | STOP immediately, report ERROR_THRESHOLD |
| Card has no Front/Back fields | Skip, log as incompatible note type |

### Consecutive Failure Counter

```
consecutiveFailures = 0

On success: consecutiveFailures = 0
On failure: consecutiveFailures += 1

If consecutiveFailures >= 3:
  STOP
  Emit: RALPH_STATUS: ERROR_THRESHOLD
  Report: last 3 errors with noteIds
```

---

## Tagging Strategy for Review Mode

All reviewed cards receive:
- `ralph-reviewed` - Card has been through the review process
- `ralph-2026-02` - Month of review
- `batch-N` - Batch number (e.g., `batch-1`, `batch-2`)

Cards that were modified also receive:
- `ralph-improved` - Fields were updated
- `ralph-split-source` - Original card that was split (if applicable)
- `ralph-split-child` - New card created from a split (if applicable)
- `ralph-delete-candidate` - Flagged for manual deletion review

Cards that need human attention:
- `needs-manual-review` - Improvement failed or result is still ELEMENTARY
