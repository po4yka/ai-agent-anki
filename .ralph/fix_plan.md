# Anki Card Review Plan: Когнитивные искажения

## CURRENT PROGRESS

| Field | Value |
|-------|-------|
| **Current Batch** | 3 |
| **Cards Processed** | 30 / 366 |
| **Status** | IN PROGRESS |

**NEXT ACTION**: Process Batch 3 (cards 31-45)

**Note**: Deck has 366 cards (not 338 as originally estimated). Updated totals accordingly.

---

## Task Overview

**Mode**: REVIEW (Mastery Improvement)
**Objective**: Review all cards in "Когнитивные искажения" deck and improve them to mastery level
**Target Deck**: Когнитивные искажения
**Total Cards**: 338
**Batches**: 23 (15 cards per batch)

## Note IDs (cached)

Query: `"deck:Когнитивные искажения"`

To get all note IDs, run:
```
mcp__anki__findNotes({ query: "deck:Когнитивные искажения" })
```

Store the IDs and process in batches of 15.

## Mastery Improvement Criteria

Transform cards from elementary to mastery level:

| Elementary (improve) | Mastery (target) |
|---------------------|------------------|
| "Что такое X?" | "Почему возникает X и как его распознать в своем мышлении?" |
| Simple definition | Definition + примеры + как противодействовать |
| Isolated fact | Connected to related biases and real-life situations |

## Pre-Processing Checklist

- [x] Verify Anki connection
- [x] Confirm deck exists and has 366 cards (updated from 338)
- [x] Sample 3 cards to understand current format
- [x] Identify note type used: Basic+

---

## Detailed Per-Card Workflow

For EACH card in every batch, follow these 6 steps:

### Step 1: Fetch
```
mcp__anki__notesInfo({ notes: [noteId] })
```
Extract: Front, Back, Tags, noteId, modelName

### Step 2: Analyze (5-Dimension Rubric)

Score each dimension PASS (1) or FAIL (0):

| Dimension | Check | Score |
|-----------|-------|-------|
| Terminology | Uses precise terms ("когнитивное искажение", "систематическая тенденция")? | 0/1 |
| Question depth | Tests understanding (why/how/when), not just recall ("Что такое")? | 0/1 |
| Answer quality | Includes reasoning, concrete examples, mechanisms? | 0/1 |
| Connections | Links to related biases or concepts? | 0/1 |
| Applicability | Includes countermeasures and real-life recognition? | 0/1 |

**Total**: X/5 -> MASTERY (5), NEEDS_IMPROVEMENT (3-4), ELEMENTARY (0-2)

### Step 3: Classify (Decision Tree)
```
5/5 -> KEEP
Content irrelevant? -> FLAG_FOR_DELETION
Multiple unrelated concepts? -> SPLIT
3-4/5 -> IMPROVE (light)
0-2/5 -> IMPROVE (substantial)
```

### Step 4: Improve

**If KEEP**: Skip to Step 6 (tagging only)

**If IMPROVE (light)**: Enrich the Back field only:
- Add "Как проявляется:" with 3 examples
- Add "Как противодействовать:" with 3 strategies
- Add "Связанные искажения:" section
- Preserve existing correct content

**If IMPROVE (substantial)**: Rewrite both fields:
- Front: Use mastery question starters (Почему/Как/Когда)
- Back: Use full mastery template (ref `.ralph/specs/domain-examples.md`)

**If SPLIT**: Create 2-3 focused cards via addNote, tag original

**If FLAG_FOR_DELETION**: Tag only, no field changes

Apply changes:
```
mcp__anki__updateNoteFields({
  note: {
    id: noteId,
    fields: { Front: "...", Back: "..." }
  }
})
```

### Step 5: Verify
```
mcp__anki__notesInfo({ notes: [noteId] })
```
- Confirm Front/Back match intended improvement
- If still ELEMENTARY after improvement: tag `needs-manual-review`

### Step 6: Tag

Apply tags based on disposition:
- ALL cards: `ralph-reviewed`, `ralph-2026-02`, `batch-N`
- IMPROVED cards: add `ralph-improved`
- SPLIT originals: add `ralph-split-source`
- SPLIT children: add `ralph-split-child`
- FLAGGED cards: add `ralph-delete-candidate`

---

## Batch Tasks

### Batch 1 (Cards 1-15) -- COMPLETE
- [x] Verify connection
- [x] Fetch notes 1-15 via notesInfo
- [x] For EACH card: Analyzed all 15 cards
- [x] Count: KEEP=15, IMPROVE=0, SPLIT=0, FLAG=0
- [x] Emit RALPH_STATUS: BATCH_COMPLETE
- **Note**: All 15 cards already at MASTERY (5/5) - previously improved. Tags applied only.

### Batch 2 (Cards 16-30) -- COMPLETE
- [x] Verify connection
- [x] Fetch notes 16-30 via notesInfo
- [x] For EACH card: Analyzed and improved all 15 cards (substantial rework)
- [x] Count: KEEP=0, IMPROVE=15 (all substantial), SPLIT=0, FLAG=0
- [x] Verify: Sampled 3 cards, all confirmed mastery (5/5)
- [x] Tag: ralph-reviewed, ralph-2026-02, batch-2, ralph-improved
- [x] Emit RALPH_STATUS: BATCH_COMPLETE
- **Note**: All 15 cards were ELEMENTARY (1-2/5). Rewrote questions + answers with mastery template.

### Batch 3 (Cards 31-45)
- [ ] Verify connection
- [ ] Fetch notes 31-45 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-3 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 4 (Cards 46-60)
- [ ] Verify connection
- [ ] Fetch notes 46-60 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-4 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 5 (Cards 61-75)
- [ ] Verify connection
- [ ] Fetch notes 61-75 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-5 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 6 (Cards 76-90)
- [ ] Verify connection
- [ ] Fetch notes 76-90 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-6 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 7 (Cards 91-105)
- [ ] Verify connection
- [ ] Fetch notes 91-105 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-7 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 8 (Cards 106-120)
- [ ] Verify connection
- [ ] Fetch notes 106-120 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-8 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 9 (Cards 121-135)
- [ ] Verify connection
- [ ] Fetch notes 121-135 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-9 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 10 (Cards 136-150)
- [ ] Verify connection
- [ ] Fetch notes 136-150 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-10 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 11 (Cards 151-165)
- [ ] Verify connection
- [ ] Fetch notes 151-165 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-11 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 12 (Cards 166-180)
- [ ] Verify connection
- [ ] Fetch notes 166-180 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-12 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 13 (Cards 181-195)
- [ ] Verify connection
- [ ] Fetch notes 181-195 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-13 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 14 (Cards 196-210)
- [ ] Verify connection
- [ ] Fetch notes 196-210 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-14 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 15 (Cards 211-225)
- [ ] Verify connection
- [ ] Fetch notes 211-225 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-15 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 16 (Cards 226-240)
- [ ] Verify connection
- [ ] Fetch notes 226-240 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-16 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 17 (Cards 241-255)
- [ ] Verify connection
- [ ] Fetch notes 241-255 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-17 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 18 (Cards 256-270)
- [ ] Verify connection
- [ ] Fetch notes 256-270 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-18 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 19 (Cards 271-285)
- [ ] Verify connection
- [ ] Fetch notes 271-285 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-19 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 20 (Cards 286-300)
- [ ] Verify connection
- [ ] Fetch notes 286-300 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-20 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 21 (Cards 301-315)
- [ ] Verify connection
- [ ] Fetch notes 301-315 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-21 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 22 (Cards 316-330)
- [ ] Verify connection
- [ ] Fetch notes 316-330 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-22 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 23 (Cards 331-338)
- [ ] Verify connection
- [ ] Fetch notes 331-338 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-23 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

---

## Post-Processing

### Verification
- [ ] Query `tag:ralph-reviewed` - should return 338 cards
- [ ] Query `tag:ralph-improved` - expected 70-85% of total (237-287 cards)
- [ ] Sample 5 improved cards at random, verify they meet mastery rubric (5/5)
- [ ] Check for `needs-manual-review` tagged cards and report count

### Disposition Statistics
- [ ] Count: KEEP (already mastery)
- [ ] Count: IMPROVE (light + substantial)
- [ ] Count: SPLIT (new cards created)
- [ ] Count: FLAG_FOR_DELETION
- [ ] Count: Errors

### Completion
- [ ] Generate improvement summary
- [ ] Emit RALPH_COMPLETE signal with full breakdown

## Summary Table

| Metric | Expected | Actual |
|--------|----------|--------|
| Total cards | 338 | |
| Reviewed | 338 | |
| KEEP (mastery) | ~50-100 | |
| IMPROVED (light) | ~100-150 | |
| IMPROVED (substantial) | ~100-150 | |
| SPLIT | ~5-15 | |
| FLAGGED | ~0-10 | |
| Errors | 0 | |

## Note IDs Reference

Query to get all note IDs:
```
"deck:Когнитивные искажения"
```

## Improvement Examples

**Before (elementary):**
```
Front: Что такое эффект привязки?
Back: Когнитивное искажение, при котором люди слишком полагаются на первую полученную информацию.
```

**After (mastery):**
```
Front: Как эффект привязки влияет на принятие решений и как его распознать в своем мышлении?
Back: Эффект привязки - склонность чрезмерно опираться на первую полученную информацию ("якорь") при принятии решений.

Как проявляется:
- Переговоры: первое предложение цены влияет на итоговую сделку
- Оценки: случайное число влияет на последующие числовые оценки
- Диагностика: первый диагноз влияет на интерпретацию симптомов

Как противодействовать:
- Осознанно генерировать альтернативные "якоря"
- Спрашивать себя: "Почему я выбрал именно эту отправную точку?"
- Использовать внешние объективные данные вместо интуитивных оценок

Связанные искажения: эвристика доступности, предвзятость подтверждения
```

See `.ralph/specs/domain-examples.md` for 10 complete before/after transformations.
