# Programming Cards Reference

Patterns for creating effective technical flashcards for software development topics.

## User Preferences

**Mastery-oriented cards for deep understanding.** Programming cards should:
- Use precise technical terminology, not simplified explanations
- Test understanding and reasoning, not just syntax recall
- Include trade-offs, when-to-use guidance, and conceptual connections
- Explain "why" alongside "what" and "how"

**Longer technical cards are acceptable.** The atomic rule is relaxed for programming context where:
- Code snippets need sufficient context to be meaningful
- Multi-line examples demonstrate complete patterns
- Explanations benefit from showing gotchas alongside correct usage

## Core Philosophy

**Flashcards support programming mastery; they don't replace practice.**

Programming is an applied discipline. Cards should build expert-level mental models and decision-making frameworks, not just memorize syntax.

## What to Card

| Good Candidates | Mastery-Oriented Examples |
|-----------------|---------------------------|
| Trade-off decisions | When to choose BFS vs DFS, and why (not just "what is BFS") |
| Pattern reasoning | Why Observer pattern solves coupling problems, when to avoid it |
| Gotcha understanding | Why Python mutable defaults fail, how to prevent it |
| Conceptual models | How async/await transforms code flow, mental model for the event loop |
| Design rationale | Why certain APIs are designed a way, what problems they solve |
| Failure mode knowledge | What causes specific errors, how to diagnose and prevent them |
| Comparative analysis | Hash table vs BST trade-offs, when each excels |

## What NOT to Card

| Avoid | Why |
|-------|-----|
| Detailed API signatures | Reference docs exist, APIs change |
| Information that changes frequently | Version-specific details |
| Entire function implementations | Should be practiced, not memorized |
| Multi-step procedural knowledge | Deployment scripts, setup procedures |
| Rarely-used features | Look up when needed |

## Card Templates (Mastery-Oriented)

### Syntax Pattern with Reasoning

```
Front: Python: When would you use **kwargs unpacking vs explicit parameters, and what are the trade-offs?

Back:
```python
# Explicit: clear, type-checkable, IDE-supported
def greet(name: str, age: int):
    print(f"{name} is {age}")

# **kwargs: flexible, useful for forwarding or config objects
def greet(**kwargs):
    print(f"{kwargs['name']} is {kwargs['age']}")

data = {"name": "Alice", "age": 30}
greet(**data)
```

Trade-offs:
- Explicit: better for stable APIs, catches errors early
- **kwargs: better for wrapper functions, decorator patterns, or when forwarding to other functions
```

### Gotcha Card with Deep Understanding

```
Front: Why does JavaScript's `+` operator behave inconsistently with types, and how should you handle this?

Back:
`+` is overloaded: concatenation (strings) and addition (numbers).
When types differ, JS coerces to string if either operand is string.

`5 + '5'` = `'55'` (concat, string wins)
`5 - '5'` = `0` (subtraction only works with numbers, so string coerced to number)

Defense strategies:
- Use explicit conversion: `Number(x) + Number(y)`
- TypeScript for compile-time safety
- `===` to catch type mismatches early

Mental model: `-`, `*`, `/` only do math, so they force number conversion.
`+` tries to be "helpful" with strings.
```

### Error Pattern with Prevention

```
Front: Why does Python raise "TypeError: unhashable type: 'list'" and what does this reveal about hash-based data structures?

Back:
Hash-based structures (dict, set) require immutable keys because:
- Hash value must remain constant for lookup to work
- Mutating a key would orphan its value (can't find it anymore)

Lists are mutable, so unhashable. Tuples are immutable, so hashable (if contents are).

```python
# Fails: list can change after being used as key
d = {[1, 2]: "value"}

# Works: tuple is immutable
d = {(1, 2): "value"}

# Also fails: tuple containing mutable items
d = {([1], 2): "value"}  # list inside tuple
```

Design insight: This is why frozen dataclasses and NamedTuples can be dict keys but regular classes need __hash__.
```

### Algorithm Trade-off Card

```
Front: When would you choose BFS over DFS, and what are the memory/performance trade-offs?

Back:
Choose BFS when:
- Need shortest path in unweighted graph (BFS guarantees this)
- Level-order processing required
- Target likely close to start (BFS finds it faster)

Choose DFS when:
- Exploring all paths (backtracking problems)
- Topological sort, cycle detection
- Memory constrained: DFS uses O(h) stack vs BFS O(w) queue

Trade-offs:
- BFS: O(w) memory where w = max width (can be entire level)
- DFS: O(h) memory where h = height (call stack depth)
- For balanced tree: w >> h, so DFS more memory-efficient
- For deep/narrow graphs: h >> w, so BFS more memory-efficient
```

### Design Pattern Reasoning Card

```
Front: Why does the Strategy pattern solve problems that inheritance cannot, and when is inheritance actually better?

Back:
Strategy solves:
- Need to swap algorithms at runtime (inheritance is static)
- Algorithms vary independently of clients (inheritance couples them)
- Avoiding combinatorial explosion of subclasses

```
# Inheritance problem: PaymentMethod x Currency x Region = explosion
# Strategy: compose behaviors instead
class Payment:
    def __init__(self, method: PaymentStrategy, currency: CurrencyStrategy):
        self.method = method
        self.currency = currency
```

Inheritance is better when:
- Behavior truly defines the type identity (a Dog IS-A Animal)
- You need protected access to parent internals
- Single dimension of variation (no combinations)

Rule of thumb: "Has-a behavior" = Strategy, "Is-a type" = Inheritance
```

### Cloze with Context

```
Text: In Python, {{c1::*args}} captures positional arguments as a tuple,
while {{c2::**kwargs}} captures keyword arguments as a dictionary.

Order matters: *args must come before **kwargs in function signatures.
Use case: wrapper functions, decorators, and functions that forward arguments.
```

## Code Snippet Guidelines

| Guideline | Recommendation |
|-----------|----------------|
| Length | 1-10 lines (longer OK if necessary for context) |
| Formatting | Use syntax highlighting add-on (1463041493) |
| Language tag | Always specify language in code blocks |
| Comments | Include only if they clarify the key point |
| Output | Show expected output when it's the point |

## Mastery Quality Rules

| Aspect | Elementary (avoid) | Mastery (prefer) |
|--------|-------------------|------------------|
| Question | "What is X?" | "When/why would you use X over Y?" |
| Answer depth | Single fact | Trade-offs, reasoning, connections |
| Code examples | Syntax only | Syntax + when to use + pitfalls |
| Terminology | Simplified | Precise technical terms |
| Target knowledge | Recognition | Application and decision-making |

| Rule | Standard Cards | Programming Cards |
|------|----------------|-------------------|
| Answer length | Very short | Can include code blocks + explanation |
| One fact | Strictly one | One concept with depth |
| Under 8 seconds | Yes | Reasonable read time OK |
| No lists in answers | Avoid | Trade-off lists encouraged |

## The Janki Method Principles

From Jack Kinsella's refined approach:

1. **Rule 4:** Only add a card after having tried to use the knowledge
2. **Rule 7:** Ruthlessly delete incorrect, outdated, or unnecessary cards
3. **Rule 8:** Only card what you've struggled with or found surprising

## Interview Prep Pattern

One developer created 42 cards from 194 LeetCode problems:
- Only cards for problems he struggled with
- Each card contains:
  - Problem description
  - Approach
  - Key data structure
  - Time/space complexity

**Review cards instead of grinding new problems.**

## Maintenance

Technical knowledge changes. Schedule periodic reviews:
- [ ] Delete cards for deprecated features
- [ ] Update syntax for new language versions
- [ ] Remove cards you now find trivial
- [ ] Add cards for new gotchas you encounter

## Related References

- See `card-patterns.md` for general card design principles
- See `docs/anki-best-practices-2026.md` for comprehensive background
