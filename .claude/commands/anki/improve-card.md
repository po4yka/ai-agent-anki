---
description: Review and improve an existing Anki card's quality
argument-hint: "<card-id | search-query> [--apply] [--deck DeckName]"
allowed-tools: [Read, mcp__anki__findNotes, mcp__anki__notesInfo, mcp__anki__updateNoteFields, mcp__anki__modelFieldNames, mcp__anki__deckActions]
---

# Improve Anki Card

## Task

Analyze an existing Anki card against best practices and suggest (or apply) improvements.

## Arguments

- `card-id`: Note ID to improve (numeric)
- `search-query`: Query to find card(s) - e.g., `"front:recursion"`, `"tag:leech"`
- `--apply`: Apply suggested improvements automatically
- `--deck DeckName`: Limit search to specific deck

## Process

### 1. Find the Card

If numeric ID provided:
```
mcp__anki__notesInfo with [id]
```

If search query provided:
```
mcp__anki__findNotes with query
```

If multiple results, show list and ask user to select.

### 2. Fetch Card Details

```
mcp__anki__notesInfo with selected note ID
mcp__anki__modelFieldNames to understand field structure
```

Display current card:
```
Note ID: [id]
Note Type: [type]
Deck: [deck]
Tags: [tags]

Front:
─────────────────────
[front content]

Back:
─────────────────────
[back content]
```

### 3. Analyze Against Best Practices

Evaluate the card against these criteria (from references/card-patterns.md and references/programming-cards.md):

#### Atomic Check
- [ ] Tests only one fact/concept
- [ ] Could this be split into multiple cards?

#### Clarity Check
- [ ] Question is unambiguous
- [ ] Has exactly one correct answer
- [ ] Avoids yes/no format
- [ ] Sufficient context to avoid confusion

#### Answer Quality
- [ ] Answer is concise (not a paragraph)
- [ ] Answer is complete (not too terse)
- [ ] For code: syntax highlighted, 1-10 lines

#### Technical Card Rules (if programming-related)
- [ ] Tests concepts/patterns, not implementations
- [ ] Code has sufficient context
- [ ] Gotchas include related pitfalls
- [ ] Not testing rapidly-changing API details

#### Common Issues
- [ ] "Orphan knowledge" - lacks connection to other concepts
- [ ] Passive recognition trap - too easy to guess
- [ ] Sets without structure - testing enumeration
- [ ] Vague question - multiple valid answers

### 4. Generate Improvement Suggestions

Present findings:

```
## Analysis Results

### Issues Found

1. **[Issue type]**: [Description]
   - Current: [problematic part]
   - Problem: [why it's an issue]

### Suggested Improvements

**Original Front:**
[original]

**Improved Front:**
[improved version]

**Original Back:**
[original]

**Improved Back:**
[improved version]

### Additional Recommendations

- [ ] [recommendation 1]
- [ ] [recommendation 2]
```

### 5. Apply Changes (if --apply or user confirms)

If improvements suggested and user wants to apply:

```
mcp__anki__updateNoteFields with:
- id: [note id]
- fields: { updated fields }
```

**Important:** Verify the note is not open in Anki's browser (updates silently fail if it is).

After update:
```
mcp__anki__notesInfo to verify changes applied
```

### 6. Summary

Display:
```
Card Improvement Complete
─────────────────────────
Note ID: [id]
Changes: [list of changes made]
Status: [Applied / Suggestions only]

Tip: Close and reopen Anki browser to see changes.
```

## Improvement Patterns

### Splitting Cards

If a card tests multiple facts, offer to create additional cards:

```
This card tests 3 concepts. Split into:

Card 1: [focused question 1]
Card 2: [focused question 2]
Card 3: [focused question 3]

Create additional cards? [y/N]
```

### Reformulating Questions

| Original Pattern | Improved Pattern |
|------------------|------------------|
| "What is X?" (vague) | "What does X do in context Y?" |
| "Yes/No: Is X true?" | "What type of X is Y?" |
| "List all X" | Multiple cards, one per item |
| "Explain X" | "What are the 2 key aspects of X?" |

### Improving Code Cards

| Issue | Fix |
|-------|-----|
| Too long (>10 lines) | Extract core pattern |
| No output shown | Add expected output |
| Missing context | Add language tag, brief setup |
| Tests implementation | Refocus on concept/pattern |

## Error Handling

| Error | Action |
|-------|--------|
| Card not found | Show search tips, suggest queries |
| Multiple matches | List cards, ask user to select |
| Update failed | Check if card is open in browser |
| No improvements needed | Confirm card passes all checks |

## Examples

```
# Improve by ID
/anki-improve-card 1234567890

# Find and improve
/anki-improve-card "front:recursion"

# Improve leeches in a deck
/anki-improve-card "tag:leech" --deck Programming

# Auto-apply improvements
/anki-improve-card 1234567890 --apply
```

## User Preference Note

For programming/technical cards, longer answers with code snippets and contextual explanations are acceptable. The atomic rule is relaxed for technical content.
