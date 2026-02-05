# Deck Organization Reference

Strategies for organizing Anki decks and tags effectively.

## Deck Hierarchy

Anki supports hierarchical decks using `::` separator:

```
Languages
Languages::Spanish
Languages::Spanish::Vocabulary
Languages::Spanish::Grammar
Languages::Japanese
Languages::Japanese::Kanji
Languages::Japanese::Vocabulary
```

### Hierarchy Recommendations

| Level | Max Depth | Example |
|-------|-----------|---------|
| 1 | Subject area | `Languages`, `Programming`, `Medicine` |
| 2 | Topic | `Languages::Spanish`, `Programming::Python` |
| 3 | Subtopic (optional) | `Programming::Python::Async` |

**Keep hierarchy to 2-3 levels maximum.** Deeper nesting creates maintenance burden.

### MCP Limitation

The Anki MCP server (`@ankimcp/anki-mcp-server`) supports max 2 levels: `Parent::Child`. For deeper organization, use tags instead.

## Decks vs Tags Decision Tree

```
Need separate study sessions?
├── Yes → Use decks
│   └── "I want to study Spanish vocabulary separately"
│
└── No → Use tags
    └── "I want to find all cards about loops"

Need different scheduling settings?
├── Yes → Use decks
│   └── "Medical cards need 95% retention, casual 85%"
│
└── No → Use tags

Will cards belong to multiple categories?
├── Yes → Use tags (cards can have multiple tags)
│
└── No → Either works
```

### Summary Table

| Use Case | Decks | Tags |
|----------|-------|------|
| Different study sessions | Yes | No |
| Different scheduling | Yes | No |
| Multiple categories per card | No | Yes |
| Quick filtering in browser | Either | Either |
| Cross-cutting concerns | No | Yes |
| Source tracking | No | Yes |

## Tag Strategies

### Hierarchical Tags

```
subject::topic::subtopic

Examples:
- programming::python::async
- language::spanish::verbs::irregular
- math::calculus::integrals
```

### Status Tags

Track card lifecycle:

| Tag | Meaning |
|-----|---------|
| `new` | Just added, unverified |
| `verified` | Confirmed accurate |
| `needs-review` | May be outdated |
| `difficult` | Consistently challenging |
| `leech` | Auto-added by Anki after failures |

### Source Tags

Track where cards came from:

```
source::book-name
source::course-name
source::article-url
source::conversation-YYYYMMDD
```

### Context Tags

```
context::interview-prep
context::project-X
context::certification
```

## Recommended Limits

| Metric | Recommendation | Why |
|--------|----------------|-----|
| Top-level decks | 5-10 | Easy to navigate |
| Subdeck depth | 2-3 levels | Manageable maintenance |
| Cards per deck | No strict limit | But consider splitting at 5000+ |
| Tags per card | 2-5 | Enough to filter, not overwhelming |

## Daily Limits

Set in deck options:

| Setting | Casual | Active | Intensive |
|---------|--------|--------|-----------|
| New cards/day | 5-10 | 15-25 | 30-50 |
| Reviews/day | 100-200 | 200-500 | No limit |

**Important:** Limits apply to deck and all subdecks combined by default.

## Common Structures

### Language Learning

```
Decks:
- Spanish
  - Spanish::Vocabulary
  - Spanish::Grammar
  - Spanish::Sentences

Tags:
- level::a1, level::a2, level::b1
- source::duolingo, source::textbook
- topic::travel, topic::food, topic::work
```

### Programming

```
Decks:
- Programming (single deck, use tags for organization)

Tags:
- lang::python, lang::javascript, lang::go
- topic::syntax, topic::gotchas, topic::algorithms
- source::book-X, source::leetcode
- context::interview-prep
```

### Medical/Academic

```
Decks:
- Step1
  - Step1::Cardiology
  - Step1::Neurology
  - Step1::Pathology

Tags:
- system::cardiovascular, system::nervous
- source::anking, source::lectures
- difficulty::high, difficulty::medium
```

## Migration Tips

### Restructuring Existing Decks

1. **Back up first:** File > Export with scheduling

2. **Use browser to move cards:**
   ```
   deck:OldDeck
   ```
   Select all > Change Deck

3. **Batch rename with search/replace:**
   - Use deck browser
   - Rename parent updates children

### Converting Decks to Tags

1. **Add tag matching deck name:**
   ```
   deck:DeckName
   ```
   Select all > Add Tags

2. **Move cards to single deck:**
   Select all > Change Deck

3. **Delete empty old deck**

## MCP Commands for Deck Management

```
mcp__anki__deckActions
├── listDecks    - View all decks with optional statistics
├── createDeck   - Add new deck (max 2 levels)
├── deckStats    - Get deck statistics
└── changeDeck   - Move cards between decks
```

## Further Reading

See `query-syntax.md` for filtering cards by deck and tag in searches.
