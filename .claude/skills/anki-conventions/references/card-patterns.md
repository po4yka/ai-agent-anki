# Card Design Patterns

Best practices for creating effective Anki flashcards that maximize retention.

## User-Specific Preferences

**Mastery-oriented philosophy:** Cards are designed for deep understanding, not elementary learning.

| Principle | Application |
|-----------|-------------|
| **Precise terminology** | Use correct technical terms, not simplified language |
| **Depth over brevity** | Include nuanced explanations and conceptual connections |
| **Expert-level questions** | Test understanding and reasoning, not just recognition |
| **Why and how** | Focus on reasoning alongside facts |

**For programming/technical cards:** The atomic rule is relaxed. Longer cards with code snippets, multi-line examples, and contextual explanations are acceptable.

See `programming-cards.md` for detailed technical card patterns.

## Core Principles

### 1. Atomic Cards (One Concept)

**One concept per card.** Break topics into meaningful units, but include depth.

**Elementary (avoid):**
```
Q: What is the boiling point of water?
A: 100°C
```

**Mastery (prefer):**
```
Q: Why does water's boiling point (100°C at sea level) decrease at higher altitudes?
A: Lower atmospheric pressure means fewer air molecules pressing down on the water surface.
   Water molecules need less kinetic energy to overcome this reduced pressure and escape
   as vapor. At 3000m elevation, water boils at ~90°C.
```

**Elementary (avoid):**
```
Q: What is the freezing point of water?
A: 0°C
```

**Mastery (prefer):**
```
Q: What conditions can cause water to freeze above 0°C or remain liquid below 0°C?
A: Above 0°C: Pressure (ice skating), dissolved salts lower freezing point (saltwater ~-2°C)
   Below 0°C: Supercooling in very pure, undisturbed water (can reach -40°C)
   Pure water at standard pressure freezes at exactly 0°C (273.15K)
```

### 2. Precise Questions

Questions should test understanding with unambiguous correct answers.

**Elementary (avoid):**
```
Q: What keyword starts a function definition in Python?
A: def
```

**Mastery (prefer):**
```
Q: How does Python's `def` keyword differ from `lambda` for defining functions?
A: `def` creates a named function with a block body (multiple statements, docstrings, decorators).
   `lambda` creates anonymous, single-expression functions.

   Use `def` for: reusable logic, complex operations, anything needing documentation.
   Use `lambda` for: short callbacks, key functions in sort/filter, functional patterns.
```

### 3. Contextual and Connected

Include context and connect to related concepts.

**Elementary (avoid):**
```
Q: What is the capital of France?
A: Paris
```

**Mastery (prefer):**
```
Q: Why did Paris become France's capital rather than other major cities like Lyon or Marseille?
A: Strategic position: on the Seine River enabling trade routes, defensible Ile de la Cite,
   central location in the Paris Basin. The Capetian dynasty established it as their seat
   in 987 CE, and centralized French governance reinforced its dominance over provincial cities.
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

## Card Templates (Mastery-Oriented)

### Understanding "Why" (Not Just "What")

```
Front: Why did [event] occur when it did, and what were the key preconditions?
Back: [explanation of causes, context, and contributing factors]
```

### Definition with Depth

```
Front: What distinguishes [term] from related concepts, and when is it the right choice?
Back: [definition] + [distinctions from similar concepts] + [application guidance]

# Or as cloze with context:
{{c1::[term]}} differs from [related concept] in that [key distinction].
Used when [application context].
```

### Process with Reasoning

```
Front: What is the rationale behind [step N] in [process], and what happens if skipped?
Back: [step description] + [why it matters] + [consequences of omission]
```

### Trade-off Comparison

```
Front: When would you choose [A] over [B], and what trade-offs does this involve?
Back:
Choose A when: [conditions]
Choose B when: [conditions]

Trade-offs:
- A: [advantages] / [disadvantages]
- B: [advantages] / [disadvantages]
```

### Code Pattern with Reasoning

```
Front: Python: When should you use [pattern], and what problem does it solve?
Back:
```python
[code example]
```
Use when: [conditions]
Solves: [problem]
Avoid when: [counter-indications]
```

### Concept Application

```
Front: How would you apply [concept] to solve [problem type], and why is it effective?
Back: [approach] + [reasoning for effectiveness] + [potential pitfalls]
```

## Anti-Patterns to Avoid

### 1. Elementary Surface Questions

**Avoid:**
```
Q: What type system does Python use?
A: Dynamic typing
```

**Mastery:**
```
Q: What trade-offs come with Python's dynamic typing, and when might static typing be preferable?
A: Dynamic typing: faster prototyping, flexibility, duck typing enables polymorphism without inheritance.
   Trade-offs: runtime type errors, harder refactoring, less IDE support.

   Prefer static typing when: large codebase, team collaboration, performance-critical code,
   or using type hints with mypy for gradual typing benefits.
```

### 2. Recognition Instead of Understanding

**Avoid:**
```
Q: What two components must every recursive function have?
A: Base case and recursive case
```

**Mastery:**
```
Q: What happens if a recursive function lacks a proper base case, and how do you design one?
A: Without base case: infinite recursion until stack overflow.

   Designing base cases:
   - Identify the simplest input (empty list, n=0, leaf node)
   - Ensure all recursive calls eventually reach it
   - Handle edge cases explicitly

   Example: factorial(0)=1 is the base; factorial(n)=n*factorial(n-1) reduces toward it.
```

### 3. Isolated Facts

**Avoid:**
```
Q: What is the Big-O of hash table lookup?
A: O(1) average case
```

**Mastery:**
```
Q: When would hash table O(1) lookup degrade, and how do you prevent it?
A: Degrades to O(n) when: many collisions (poor hash function), load factor too high,
   or adversarial input exploiting hash weaknesses.

   Prevention:
   - Use cryptographic hash for untrusted input
   - Maintain load factor < 0.75 (resize threshold)
   - Choose hash function appropriate to key distribution
```

### 4. Lists Without Reasoning

Split enumeration into cards that explain each item's purpose.

### 5. Surface Definitions

Connect definitions to when/why you'd use the concept, not just what it means.

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

## Mastery Quality Checklist

Before adding a card, verify:

- [ ] Uses precise technical terminology
- [ ] Question requires understanding, not just recall
- [ ] Answer explains "why" or "how", not just "what"
- [ ] Connects to related concepts or principles
- [ ] Would help someone apply knowledge, not just recognize it
- [ ] Tests at the level of a practitioner, not a beginner
- [ ] Worth remembering long-term?
- [ ] Are appropriate tags applied?

## Related References

- **Technical cards:** See `programming-cards.md` for code-specific patterns
- **Maintenance:** See `card-maintenance.md` for reformulating problematic cards
- **Organization:** See `deck-organization.md` for tagging strategies
