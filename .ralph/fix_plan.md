# Anki Card Review Plan: Когнитивные искажения

## CURRENT PROGRESS

| Field | Value |
|-------|-------|
| **Current Batch** | 11 |
| **Cards Processed** | 150 / 366 |
| **Status** | IN PROGRESS |

**NEXT ACTION**: Process Batch 11 (cards 151-165)

**Note**: Deck has 366 cards (not 338 as originally estimated). Total batches: 25.

**IMPORTANT**: Batch 11 was partially processed before context overflow. Cards 151-160 had content updated but were NOT tagged or verified. Cards 161-165 were NOT processed. Re-run batch 11 from scratch -- already-improved cards will score MASTERY and get KEEP disposition (tag only).

---

## Task Overview

**Mode**: REVIEW (Mastery Improvement)
**Objective**: Review all cards in "Когнитивные искажения" deck and improve them to mastery level
**Target Deck**: Когнитивные искажения
**Total Cards**: 366
**Batches**: 25 (15 cards per batch, last batch has 6 cards)

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

### Batch 3 (Cards 31-45) -- COMPLETE
- [x] Verify connection
- [x] Fetch notes 31-45 via notesInfo
- [x] For EACH card: Analyzed and improved all 15 cards (14 substantial, 1 light)
- [x] Count: KEEP=0, IMPROVE=15 (14 substantial + 1 light), SPLIT=0, FLAG=0
- [x] Verify: Sampled 3 cards (32, 38, 45), all confirmed mastery (5/5)
- [x] Tag: ralph-reviewed, ralph-2026-02, batch-3, ralph-improved
- [x] Emit RALPH_STATUS: BATCH_COMPLETE
- **Note**: Biases covered: Даннинга-Крюгера (ex), сверхуверенность (4), иллюзия ума (4), иллюзия знания (4), самообман (def). Card 34 was NEEDS_IMPROVEMENT (3/5, light enrichment), all others ELEMENTARY (0-2/5, substantial rework).

### Batch 4 (Cards 46-60) -- COMPLETE
- [x] Verify connection
- [x] Fetch notes 46-60 via notesInfo
- [x] For EACH card: Analyzed and improved all 15 cards (14 substantial, 1 light)
- [x] Count: KEEP=0, IMPROVE=15 (14 substantial + 1 light), SPLIT=0, FLAG=0
- [x] Verify: Sampled 3 cards (54, 59, 48), all confirmed mastery (5/5)
- [x] Tag: ralph-reviewed, ralph-2026-02, batch-4, ralph-improved
- [x] Emit RALPH_STATUS: BATCH_COMPLETE
- **Note**: Biases covered: самообман (mech/rec/ex), слепое пятно предвзятости (4 cards), эффект ложной уникальности (4 cards), иллюзия конца истории (4 cards). Card 58 (end-of-history-mech) was NEEDS_IMPROVEMENT (3/5, light enrichment), all others ELEMENTARY (0-2/5, substantial rework).

### Batch 5 (Cards 61-75) -- COMPLETE
- [x] Verify connection
- [x] Fetch notes 61-75 via notesInfo
- [x] For EACH card: Analyzed and improved all 15 cards (all substantial rework)
- [x] Count: KEEP=0, IMPROVE=15 (all substantial), SPLIT=0, FLAG=0
- [x] Verify: Sampled 3 cards (61, 67, 74), all confirmed mastery (5/5)
- [x] Tag: ralph-reviewed, ralph-2026-02, batch-5, ralph-improved
- [x] Emit RALPH_STATUS: BATCH_COMPLETE
- **Note**: Biases covered: фундаментальная ошибка атрибуции (4 cards), эффект ложного консенсуса (4 cards), иллюзия прозрачности (4 cards), проклятие знания (3 cards). All cards were ELEMENTARY (0-2/5, substantial rework).

### Batch 6 (Cards 76-90) -- COMPLETE
- [x] Verify connection
- [x] Fetch notes 76-90 via notesInfo
- [x] For EACH card: Analyzed and improved all 15 cards (all substantial rework)
- [x] Count: KEEP=0, IMPROVE=15 (all substantial), SPLIT=0, FLAG=0
- [x] Verify: Sampled 3 cards (76, 82, 89), all confirmed mastery (5/5)
- [x] Tag: ralph-reviewed, ralph-2026-02, batch-6, ralph-improved
- [x] Emit RALPH_STATUS: BATCH_COMPLETE
- **Note**: Biases covered: проклятие знания (1 card - ex), профессиональная деформация (4 cards), иллюзия выбора (4 cards), ложная дилемма (4 cards), ошибка необратимых издержек (2 cards). All cards were ELEMENTARY (0-2/5, substantial rework).

### Batch 7 (Cards 91-105) -- COMPLETE
- [x] Verify connection
- [x] Fetch notes 91-105 via notesInfo
- [x] For EACH card: Analyzed and improved all 15 cards (all substantial rework)
- [x] Count: KEEP=0, IMPROVE=15 (all substantial), SPLIT=0, FLAG=0
- [x] Verify: Sampled 3 cards (91, 98, 105), all confirmed mastery (5/5)
- [x] Tag: ralph-reviewed, ralph-2026-02, batch-7, ralph-improved
- [x] Emit RALPH_STATUS: BATCH_COMPLETE
- **Note**: Biases covered: ошибка необратимых издержек (2 cards - rec/ex), отклонение в сторону статус-кво (4 cards), недооценка бездействия (4 cards), эффект фрейминга (4 cards), ошибка планирования (1 card - def). All cards were ELEMENTARY (0-2/5, substantial rework). Key connections: status-quo <-> omission bias <-> loss aversion cluster.

### Batch 8 (Cards 106-120) -- COMPLETE
- [x] Verify connection
- [x] Fetch notes 106-120 via notesInfo
- [x] For EACH card: Analyzed and improved all 15 cards (all substantial rework)
- [x] Count: KEEP=0, IMPROVE=15 (all substantial), SPLIT=0, FLAG=0
- [x] Verify: Sampled 3 cards (116, 118, 120), all confirmed mastery (5/5)
- [x] Tag: ralph-reviewed, ralph-2026-02, batch-8, ralph-improved
- [x] Emit RALPH_STATUS: BATCH_COMPLETE
- **Note**: Biases covered: ошибка планирования (3 cards - mech/rec/ex), эффект владения (4 cards), эффект якорения (4 cards), ошибка выжившего (4 cards). All cards were ELEMENTARY (0-2/5, substantial rework). Key references: Northcraft-Neal realtor anchoring experiment, Wald's WWII bomber survivorship, Collins "Good to Great" survivorship critique.

### Batch 9 (Cards 121-135) -- COMPLETE
- [x] Verify connection
- [x] Fetch notes 121-135 via notesInfo
- [x] For EACH card: Analyzed and improved all 15 cards (all substantial rework)
- [x] Count: KEEP=0, IMPROVE=15 (all substantial), SPLIT=0, FLAG=0
- [x] Verify: Sampled 3 cards (121, 126, 133), all confirmed mastery (5/5)
- [x] Tag: ralph-reviewed, ralph-2026-02, batch-9, ralph-improved
- [x] Emit RALPH_STATUS: BATCH_COMPLETE
- **Note**: Biases covered: парадокс инспекции (4 cards), селективное мышление/confirmation bias (4 cards), подгонка фактов/cherry picking (4 cards), предпочтение позитивных результатов/publication bias (3 cards). All cards were ELEMENTARY (0-2/5, substantial rework). Key cluster: confirmation bias -> cherry picking -> publication bias form connected triad of information-filtering biases. Key references: Wason 2-4-6 experiment (1960), Feld friendship paradox (1991), Ioannidis (2005), Turner et al. antidepressant study (2008).

### Batch 10 (Cards 136-150) -- COMPLETE
- [x] Verify connection
- [x] Fetch notes 136-150 via notesInfo
- [x] For EACH card: Analyzed and improved all 15 cards (all substantial rework)
- [x] Count: KEEP=0, IMPROVE=15 (all substantial), SPLIT=0, FLAG=0
- [x] Verify: Sampled 3 cards (136, 142, 149), all confirmed mastery (5/5)
- [x] Tag: ralph-reviewed, ralph-2026-02, batch-10, ralph-improved
- [x] Emit RALPH_STATUS: BATCH_COMPLETE
- **Note**: Biases covered: предпочтение позитивных результатов/publication bias (1 card - ex), принятие желаемого за действительное/wishful thinking (4 cards), каскад доступной информации/availability cascade (4 cards), эффект ореола/halo effect (4 cards), эффект первенства/primacy effect (2 cards). All cards were ELEMENTARY (0-2/5, substantial rework). Key references: Turner et al. antidepressant study (2008), Kuran & Sunstein availability cascades (1999), Wakefield vaccine scare (1998), Thorndike halo effect (1920), Dion et al. attractiveness bias (1972), Rosenzweig halo effect in business (2007), Ambady & Rosenthal thin slices (1993). Key cluster: halo effect <-> primacy effect <-> anchoring form a perception-first-impression triad.

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

### Batch 23 (Cards 331-345)
- [ ] Verify connection
- [ ] Fetch notes 331-345 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-23 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 24 (Cards 346-360)
- [ ] Verify connection
- [ ] Fetch notes 346-360 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-24 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

### Batch 25 (Cards 361-366)
- [ ] Verify connection
- [ ] Fetch notes 361-366 via notesInfo
- [ ] For EACH card:
  - [ ] Analyze: 5-dimension rubric
  - [ ] Classify: KEEP/IMPROVE/SPLIT/FLAG
  - [ ] Improve: Apply mastery template (ref domain-examples.md)
  - [ ] Verify: Re-fetch, confirm changes
  - [ ] Tag: ralph-reviewed + batch-25 + [ralph-improved if changed]
- [ ] Count: KEEP=?, IMPROVE=?, SPLIT=?, FLAG=?
- [ ] Emit RALPH_STATUS: BATCH_COMPLETE with breakdown

---

## Post-Processing

### Verification
- [ ] Query `tag:ralph-reviewed` - should return 366 cards
- [ ] Query `tag:ralph-improved` - expected 70-85% of total (256-311 cards)
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
| Total cards | 366 | |
| Reviewed | 366 | |
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
