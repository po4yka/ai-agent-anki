# Card Design Patterns

Best practices for creating effective Anki flashcards that maximize retention.

## User-Specific Preferences

**For programming/technical cards:** The atomic rule is relaxed. Longer cards with code snippets, multi-line examples, and contextual explanations are acceptable.

See `programming-cards.md` for detailed technical card patterns.

## Core Principles

### 1. Atomic Cards

**One fact per card.** Break complex topics into smallest meaningful units.

**Bad:**
```
Q: What are the properties of water?
A: Colorless, odorless, tasteless, boiling point 100C, freezing point 0C,
   density 1g/cm3, universal solvent, high specific heat...
```

**Good:**
```
Q: What is the boiling point of water at sea level?
A: 100°C (212°F)

Q: What is the freezing point of water?
A: 0°C (32°F)

Q: Why is water called the "universal solvent"?
A: It dissolves more substances than any other liquid
```

### 2. Clear Questions

Questions should have one unambiguous correct answer.

**Bad:**
```
Q: Tell me about Python
A: [essay about Python]
```

**Good:**
```
Q: What keyword starts a function definition in Python?
A: def
```

### 3. Contextual Cues

Include enough context to avoid confusion with similar facts.

**Bad:**
```
Q: What is the capital?
A: Paris
```

**Good:**
```
Q: What is the capital of France?
A: Paris
```

### 4. Cloze Deletions

Use for definitions, lists, and fill-in-the-blank learning.

**Definition:**
```
{{c1::Photosynthesis}} is the process by which plants convert
{{c2::sunlight}} into {{c3::chemical energy}}.
```

**List (one card per item):**
```
The three branches of US government are:
- {{c1::Legislative}}
- {{c2::Executive}}
- {{c3::Judicial}}
```

### 5. Bidirectional Learning

Use "Basic (and reversed)" for concepts that benefit from both directions.

**Good candidates:**
- Vocabulary (word ↔ definition)
- Translations (English ↔ Spanish)
- Symbols (symbol ↔ meaning)

**Poor candidates:**
- Dates (year → event is useful; event → year less so)
- Complex explanations

## Card Templates

### Simple Fact

```
Front: What year did [event] occur?
Back: [year]
```

### Definition

```
Front: Define: [term]
Back: [definition]

# Or as cloze:
{{c1::[term]}} - [definition]
```

### Process/Steps

```
Front: What are the steps to [process]?
Back:
1. [step 1]
2. [step 2]
3. [step 3]

# Or as multiple cards:
Front: What is step 1 of [process]?
Back: [step 1]
```

### Comparison

```
Front: [Thing A] vs [Thing B]: What is the key difference in [aspect]?
Back: A: [characteristic], B: [characteristic]
```

### Code Syntax

```
Front: Python: How do you [action]?
Back:
```python
[code example]
```

### Concept Application

```
Front: When would you use [concept/technique]?
Back: [use case description]
```

## Anti-Patterns to Avoid

### 1. Sets Without Structure

**Bad:**
```
Q: Name all planets in the solar system
A: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
```

**Better:** One card per planet with a distinctive question.

### 2. Yes/No Questions

**Bad:**
```
Q: Is Python dynamically typed?
A: Yes
```

**Better:**
```
Q: What type system does Python use?
A: Dynamic typing
```

### 3. Vague Questions

**Bad:**
```
Q: Explain recursion
A: [long explanation]
```

**Better:**
```
Q: What two components must every recursive function have?
A: Base case and recursive case
```

### 4. Too Much on Back

Keep answers concise. If the answer is a paragraph, split the card.

### 5. Orphan Knowledge

Cards should connect to something you already know. Add context or prerequisite cards.

## Tagging Strategy

### Hierarchical Tags

```
subject::topic::subtopic

Examples:
- programming::python::syntax
- math::calculus::derivatives
- language::spanish::verbs
```

### Status Tags

```
- new (just added, unverified)
- verified (confirmed accurate)
- needs-review (may be outdated)
- difficult (consistently hard)
```

### Source Tags

```
- source::book-name
- source::course-name
- source::article-url
```

## Quality Checklist

Before adding a card, verify:

- [ ] Is this worth remembering long-term?
- [ ] Is the question unambiguous?
- [ ] Is there exactly one correct answer?
- [ ] Is the answer verifiable?
- [ ] Could this be split into smaller cards?
- [ ] Does it connect to existing knowledge?
- [ ] Are appropriate tags applied?

## Related References

- **Technical cards:** See `programming-cards.md` for code-specific patterns
- **Maintenance:** See `card-maintenance.md` for reformulating problematic cards
- **Organization:** See `deck-organization.md` for tagging strategies
