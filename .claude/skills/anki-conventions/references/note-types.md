# Anki Note Types Reference

Guide to built-in and common note types (models) in Anki.

## Built-in Note Types

### Basic

The simplest note type with Front and Back fields.

**Fields:**
- Front
- Back

**Cards Generated:** 1 (Front → Back)

**Use Cases:**
- Simple Q&A
- Definitions
- Facts with one-way recall

**Example:**
```
Front: What is the capital of Japan?
Back: Tokyo
```

### Basic (and reversed card)

Same as Basic but generates two cards for bidirectional learning.

**Fields:**
- Front
- Back

**Cards Generated:** 2 (Front → Back, Back → Front)

**Use Cases:**
- Vocabulary learning
- Translations
- Symbol ↔ meaning pairs
- Bidirectional associations

**Example:**
```
Front: dog
Back: perro (Spanish)

# Generates:
Card 1: dog → perro
Card 2: perro → dog
```

### Basic (optional reversed card)

Like Basic, with optional reverse card controlled by a field.

**Fields:**
- Front
- Back
- Add Reverse

**Cards Generated:** 1 or 2 (reverse only if Add Reverse has content)

**Use Cases:**
- Mixed content where some items need reversal, others don't

### Basic (type in the answer)

Front card includes a text input for typing the answer.

**Fields:**
- Front
- Back

**Cards Generated:** 1

**Use Cases:**
- Spelling practice
- Exact recall required
- Language learning (typing words)

**Note:** Uses `{{type:Back}}` in template.

### Cloze

Special note type for fill-in-the-blank cards.

**Fields:**
- Text
- Extra (optional additional info)

**Cards Generated:** One per cloze deletion

**Syntax:**
```
{{c1::hidden text}}
{{c2::another hidden}}
{{c1::same card as first}}
```

**Use Cases:**
- Definitions
- Lists and enumerations
- Fill-in-the-blank
- Contextual learning

**Examples:**

Single cloze:
```
Text: The {{c1::mitochondria}} is the powerhouse of the cell.
```

Multiple clozes (separate cards):
```
Text: {{c1::Python}} was created by {{c2::Guido van Rossum}} in {{c3::1991}}.
```

List learning:
```
Text: Primary colors are {{c1::red}}, {{c2::blue}}, and {{c3::yellow}}.
```

**Hint syntax:**
```
{{c1::answer::hint text}}
```

## Custom Note Types

### Q&A with Source

**Fields:**
- Question
- Answer
- Source
- Notes

**Template idea:** Show source on back for reference.

### Vocabulary

**Fields:**
- Word
- Definition
- Example Sentence
- Part of Speech
- Pronunciation

**Template idea:** Show word → definition, with example on reveal.

### Code Snippet

**Fields:**
- Language
- Description
- Code
- Output
- Explanation

**Template idea:** Show description → code, with output/explanation on back.

### Image Occlusion

**Fields:**
- Image
- Header
- Remarks

**Note:** Requires Image Occlusion add-on. Hides parts of images.

## Creating Custom Note Types

### Via AnkiConnect API

```json
{
  "action": "createModel",
  "version": 6,
  "params": {
    "modelName": "CustomBasic",
    "inOrderFields": ["Question", "Answer", "Notes"],
    "css": ".card { font-family: arial; }",
    "cardTemplates": [
      {
        "Name": "Card 1",
        "Front": "{{Question}}",
        "Back": "{{FrontSide}}<hr>{{Answer}}<br><small>{{Notes}}</small>"
      }
    ]
  }
}
```

### Via MCP

```
mcp__anki__modelNames      # List existing types
mcp__anki__modelFieldNames # Get fields for a type
```

## Field Best Practices

### Required Fields

Every note type needs at least:
- One field for the question/prompt
- One field for the answer

### Optional Fields

Consider adding:
- **Source**: Where the information came from
- **Notes**: Additional context not shown on card
- **Tags field**: For dynamic tagging (though Anki has built-in tags)

### Field Naming

- Use clear, descriptive names
- Be consistent across note types
- Consider how fields appear in browser columns

## Template Syntax

### Basic Replacement

```html
{{FieldName}}
```

### Conditional Display

```html
{{#FieldName}}
  This shows if FieldName has content
{{/FieldName}}

{{^FieldName}}
  This shows if FieldName is empty
{{/FieldName}}
```

### Special Fields

```html
{{FrontSide}}    <!-- Include front content on back -->
{{Tags}}         <!-- Show note's tags -->
{{Type}}         <!-- Note type name -->
{{Deck}}         <!-- Deck name -->
{{Card}}         <!-- Card template name -->
```

### Type Answer

```html
{{type:FieldName}}
```

### Cloze

```html
{{cloze:Text}}
```

## Choosing the Right Note Type

| Scenario | Recommended Type |
|----------|------------------|
| Simple fact | Basic |
| Word ↔ translation | Basic (reversed) |
| Definition with context | Cloze |
| List memorization | Cloze (one item per c#) |
| Spelling practice | Basic (type answer) |
| Complex topic | Multiple Basic cards |
| Code syntax | Custom code type |
| Visual learning | Image Occlusion |

## Common Issues

### Too Many Card Types

Stick to a few note types. More types = more maintenance.

### Overly Complex Templates

Keep templates simple. Complex CSS/JS can break on mobile.

### Inconsistent Field Usage

Decide field purposes upfront and stick to them.
