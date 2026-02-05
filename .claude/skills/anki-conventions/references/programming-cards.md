# Programming Cards Reference

Patterns for creating effective technical flashcards for software development topics.

## User Preferences

**Longer technical cards are acceptable.** The atomic rule is relaxed for programming context where:
- Code snippets need sufficient context to be meaningful
- Multi-line examples demonstrate complete patterns
- Explanations benefit from showing gotchas alongside correct usage

## Core Philosophy

**Flashcards support programming learning; they don't replace it.**

Programming is an applied discipline where knowledge is gained tacitly through building things. Cards memorize patterns and concepts, not implementations.

## What to Card

| Good Candidates | Examples |
|-----------------|----------|
| Core syntax patterns | `async/await` structure, list comprehension syntax |
| Common gotchas | JavaScript type coercion, Python mutable defaults |
| Cross-language idioms | map/filter/reduce patterns |
| Error patterns you've encountered | Specific bugs you've debugged |
| Algorithmic approaches | When to use BFS vs DFS |
| Design patterns | When Observer pattern applies |
| API quirks that bit you | Browser API inconsistencies |

## What NOT to Card

| Avoid | Why |
|-------|-----|
| Detailed API signatures | Reference docs exist, APIs change |
| Information that changes frequently | Version-specific details |
| Entire function implementations | Should be practiced, not memorized |
| Multi-step procedural knowledge | Deployment scripts, setup procedures |
| Rarely-used features | Look up when needed |

## Card Templates

### Syntax Pattern Card

```
Front: Python: How do you unpack a dictionary into keyword arguments?

Back:
```python
def greet(name, age):
    print(f"{name} is {age}")

data = {"name": "Alice", "age": 30}
greet(**data)  # Alice is 30
```
```

### Gotcha Card (Longer Format OK)

```
Front: JavaScript: What is the result of `5 + '5'`? Why?

Back:
`'55'` (string)

JavaScript coerces the number to a string for concatenation.
The `+` operator prefers string concatenation when either operand is a string.

Related gotchas:
- `5 - '5'` = `0` (number, `-` doesn't concat)
- `'5' + + '5'` = `'55'` (unary `+` converts to number first)
```

### Cloze for Code

```
Text: In Python, {{c1::*args}} captures positional arguments as a tuple,
while {{c2::**kwargs}} captures keyword arguments as a dictionary.
```

### Error Pattern Card

```
Front: Python: What causes "TypeError: unhashable type: 'list'"?

Back:
Using a list as a dictionary key or set element.

Lists are mutable, so they can't be hashed.

Fix: Use a tuple instead (if contents are hashable):
```python
# Bad
d = {[1, 2]: "value"}

# Good
d = {(1, 2): "value"}
```
```

### Algorithm Approach Card

```
Front: When should you use BFS instead of DFS for graph traversal?

Back:
Use BFS when:
- Finding shortest path in unweighted graph
- Level-order traversal needed
- Target is likely close to start

Use DFS when:
- Exploring all paths
- Topological sorting
- Finding connected components
- Memory is constrained (DFS uses less)
```

### Design Pattern Card

```
Front: When is the Strategy pattern preferable to inheritance?

Back:
Use Strategy when:
- Algorithms vary independently of clients that use them
- You need to switch algorithms at runtime
- Multiple classes differ only in behavior

Example: Payment processing with interchangeable payment methods
rather than CardPayment, PayPalPayment, CryptoPayment subclasses.
```

## Code Snippet Guidelines

| Guideline | Recommendation |
|-----------|----------------|
| Length | 1-10 lines (longer OK if necessary for context) |
| Formatting | Use syntax highlighting add-on (1463041493) |
| Language tag | Always specify language in code blocks |
| Comments | Include only if they clarify the key point |
| Output | Show expected output when it's the point |

## Quality Rules (Relaxed for Technical)

| Rule | Standard Cards | Programming Cards |
|------|----------------|-------------------|
| Answer length | Very short | Can include code blocks |
| One fact | Strictly one | One concept, may need context |
| Under 8 seconds | Yes | Reasonable read time OK |
| No lists in answers | Avoid | Related points OK |

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
