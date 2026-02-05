# Claude Code Infrastructure for Anki Integration

Research document for creating Claude Code Skills, Agents, and Scripts for working with Anki via AnkiConnect.

## Table of Contents

- [1. Available Integration Points](#1-available-integration-points)
- [2. AnkiConnect API Overview](#2-ankiconnect-api-overview)
- [3. Anki MCP Server](#3-anki-mcp-server-ankimcpanki-mcp-server)
- [4. Claude Code Component Options](#4-claude-code-component-options)
- [5. Recommended Architecture](#5-recommended-architecture)
- [6. Key Design Considerations](#6-key-design-considerations)
- [7. Integration Options](#7-integration-options)
- [8. Sources](#8-sources)

---

## 1. Available Integration Points

### Existing MCP Server

Already configured in `~/.claude/settings.local.json`:

```json
"anki": {
  "command": "npx",
  "args": ["-y", "@ankimcp/anki-mcp-server"]
}
```

### Existing Python AnkiConnect Clients

| Project | Path | Description |
|---------|------|-------------|
| obsidian-to-anki | `/Users/npochaev/GitHub/obsidian-to-anki/` | Full service architecture with domain interfaces |
| claude-code-obsidian-anki | `/Users/npochaev/GitHub/claude-code-obsidian-anki/src/utils/anki_connect.py` | Async client implementation |

### Key Interface Files

- `obsidian-to-anki/src/obsidian_anki_sync/domain/interfaces/anki_client.py` - Abstract interface
- `obsidian-to-anki/src/obsidian_anki_sync/anki/services/` - Service implementations
- `claude-code-obsidian-anki/src/utils/anki_connect.py` - Reusable async client

---

## 2. AnkiConnect API Overview

AnkiConnect exposes Anki features via HTTP REST API on port 8765.

### Request Format

```json
{
  "action": "actionName",
  "version": 6,
  "params": { }
}
```

### Response Format

```json
{
  "result": null,
  "error": null
}
```

### Action Categories

#### Deck Actions

| Action | Description | Parameters |
|--------|-------------|------------|
| `deckNames` | Get all deck names | None |
| `deckNamesAndIds` | Get deck names with IDs | None |
| `createDeck` | Create a new deck | `deck` (string) |
| `deleteDecks` | Delete decks | `decks` (array), `cardsToo` (bool) |
| `changeDeck` | Move cards to deck | `cards` (array), `deck` (string) |
| `getDeckConfig` | Get deck configuration | `deck` (string) |
| `getDeckStats` | Get deck statistics | `decks` (array) |

#### Note Actions

| Action | Description | Parameters |
|--------|-------------|------------|
| `addNote` | Create a new note | `note` object |
| `addNotes` | Create multiple notes | `notes` array |
| `updateNoteFields` | Modify note fields | `note` object with `id` and `fields` |
| `findNotes` | Find notes by query | `query` (string) |
| `notesInfo` | Get note details | `notes` (array of IDs) |
| `deleteNotes` | Delete notes | `notes` (array of IDs) |
| `canAddNotes` | Check for duplicates | `notes` (array) |

**Add Note Example:**

```json
{
  "action": "addNote",
  "version": 6,
  "params": {
    "note": {
      "deckName": "Default",
      "modelName": "Basic",
      "fields": {
        "Front": "What is spaced repetition?",
        "Back": "A learning technique that incorporates increasing intervals of time between review of previously learned material."
      },
      "tags": ["learning", "memory"]
    }
  }
}
```

#### Card Actions

| Action | Description | Parameters |
|--------|-------------|------------|
| `findCards` | Find cards by query | `query` (string) |
| `cardsInfo` | Get card details | `cards` (array of IDs) |
| `suspend` | Suspend cards | `cards` (array) |
| `unsuspend` | Unsuspend cards | `cards` (array) |
| `areDue` | Check if cards are due | `cards` (array) |
| `getIntervals` | Get review intervals | `cards` (array), `complete` (bool) |
| `cardsToNotes` | Convert card IDs to note IDs | `cards` (array) |

#### Model (Note Type) Actions

| Action | Description | Parameters |
|--------|-------------|------------|
| `modelNames` | Get all model names | None |
| `modelNamesAndIds` | Get model names with IDs | None |
| `modelFieldNames` | Get field names for model | `modelName` (string) |
| `modelFieldsOnTemplates` | Get fields used in templates | `modelName` (string) |

#### Tag Actions

| Action | Description | Parameters |
|--------|-------------|------------|
| `getTags` | Get all tags | None |
| `addTags` | Add tags to notes | `notes` (array), `tags` (string) |
| `removeTags` | Remove tags from notes | `notes` (array), `tags` (string) |

#### Media Actions

| Action | Description | Parameters |
|--------|-------------|------------|
| `storeMediaFile` | Store file in media folder | `filename`, `data` (base64) |
| `retrieveMediaFile` | Get file as base64 | `filename` (string) |
| `deleteMediaFile` | Delete media file | `filename` (string) |

#### GUI Actions

| Action | Description | Parameters |
|--------|-------------|------------|
| `guiBrowse` | Open card browser | `query` (string, optional) |
| `guiAddCards` | Open Add Cards dialog | None |
| `guiCurrentCard` | Get current review card | None |
| `guiAnswerCard` | Answer current card | `ease` (1-4) |
| `guiDeckReview` | Start deck review | `name` (string) |
| `guiDeckBrowser` | Open deck browser | None |

#### Miscellaneous Actions

| Action | Description | Parameters |
|--------|-------------|------------|
| `version` | Get API version | None |
| `sync` | Sync with AnkiWeb | None |
| `multi` | Execute multiple actions | `actions` (array) |

### Anki Query Syntax

Used with `findNotes` and `findCards`:

| Query | Description |
|-------|-------------|
| `deck:DeckName` | Notes in specific deck |
| `deck:Parent::Child` | Notes in subdeck |
| `tag:tagname` | Notes with tag |
| `-tag:tagname` | Notes without tag |
| `is:due` | Cards due for review |
| `is:new` | New/unstudied cards |
| `is:suspended` | Suspended cards |
| `added:7` | Added in last 7 days |
| `rated:1` | Rated today |
| `front:text` | Search in Front field |
| `"exact phrase"` | Exact phrase match |
| `flag:1` | Red flag (1-4 for colors) |
| `prop:due<=2` | Due within 2 days |
| `note:Basic` | Specific note type |

**Combined queries:** Use spaces for AND, `OR` for alternatives.

---

## 3. Anki MCP Server (@ankimcp/anki-mcp-server)

### Overview

Model Context Protocol server that enables AI assistants to interact with Anki.

- **npm package:** `@ankimcp/anki-mcp-server`
- **GitHub:** https://github.com/ankimcp/anki-mcp-server

### Installation

Already configured. Manual installation:

```bash
npx @ankimcp/anki-mcp-server --stdio
```

### Available MCP Tools

#### Review & Study

| Tool | Description |
|------|-------------|
| `sync` | Synchronize with AnkiWeb |
| `get_due_cards` | Retrieve cards ready for review |
| `present_card` | Display card for studying |
| `rate_card` | Submit card performance ratings |

#### Deck Management

| Tool | Description |
|------|-------------|
| `deckActions` | Unified deck operations |
| - `listDecks` | View all decks with optional statistics |
| - `createDeck` | Add new decks (max 2 levels: "Parent::Child") |
| - `deckStats` | Get comprehensive deck statistics |
| - `changeDeck` | Move cards between decks |

#### Note Management

| Tool | Description |
|------|-------------|
| `addNote` | Create new notes |
| `findNotes` | Search using Anki query syntax |
| `notesInfo` | Get detailed note information |
| `updateNoteFields` | Modify existing note fields |
| `deleteNotes` | Remove notes (requires confirmation) |

#### Media Management

| Tool | Description |
|------|-------------|
| `mediaActions` | Unified media operations |
| - `storeMediaFile` | Upload from base64, file paths, or URLs |
| - `retrieveMediaFile` | Download as base64 |
| - `getMediaFilesNames` | List media files with pattern filtering |
| - `deleteMediaFile` | Remove media files |

#### Model/Template Management

| Tool | Description |
|------|-------------|
| `modelNames` | List available note types |
| `modelFieldNames` | Get field names for note type |
| `modelStyling` | Retrieve CSS styling |

### Configuration Options

#### CLI Flags

| Flag | Description | Default |
|------|-------------|---------|
| `--stdio` | STDIO mode for MCP clients | - |
| `-p, --port <port>` | HTTP listen port | 3000 |
| `-h, --host <host>` | Bind address | 127.0.0.1 |
| `-a, --anki-connect <url>` | AnkiConnect URL | http://localhost:8765 |
| `--ngrok` | Enable ngrok tunnel | false |
| `--read-only` | Block write operations | false |

#### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `ANKI_CONNECT_URL` | AnkiConnect endpoint | http://localhost:8765 |
| `ANKI_CONNECT_API_VERSION` | API version | 6 |
| `ANKI_CONNECT_API_KEY` | Authentication key | - |
| `ANKI_CONNECT_TIMEOUT` | Request timeout (ms) | 5000 |
| `READ_ONLY` | Enable read-only mode | false |

### Important Limitations

- When updating notes with `updateNoteFields`, the update will silently fail if the note is currently being viewed in Anki's browser window
- Use file paths or URLs instead of base64 for image uploads (more efficient)
- Read-only mode blocks: `addNote`, `deleteNotes`, `createDeck`, `updateNoteFields`, media deletion
- Requires Node.js 20.19.0+ or 22.12.0+ (not 21.x)

---

## 4. Claude Code Component Options

### Skills (`.claude/skills/[name]/SKILL.md`)

**Purpose:** Auto-triggered background knowledge and domain expertise.

**Use for Anki:**
- Anki query syntax reference
- Note type conventions (cloze deletion patterns, etc.)
- Spaced repetition best practices
- Card formatting guidelines

**Structure:**

```
.claude/skills/
└── anki-conventions/
    ├── SKILL.md              # Main skill file (required)
    └── references/           # Optional detailed docs
        ├── query-syntax.md
        └── card-patterns.md
```

**SKILL.md Format:**

```yaml
---
name: anki-conventions
description: >
  Anki card creation patterns, query syntax, and spaced repetition principles.
  Use when creating flashcards, querying decks, or discussing learning strategies.
---

# Anki Conventions

## Quick Reference

### Query Syntax
- `deck:Name` - Cards in deck
- `tag:name` - Cards with tag
- `is:due` - Due cards
- `added:N` - Added in last N days

## Card Design Principles

1. **Atomic**: One fact per card
2. **Clear**: Unambiguous questions
3. **Connected**: Link to existing knowledge

## Detailed References

See `references/` for comprehensive documentation.
```

**Key Guidelines:**
- Keep under 500 lines
- Description is always loaded (put triggers here)
- Body loaded only when skill triggers
- Use progressive disclosure with references/

### Commands (`.claude/commands/[name].md`)

**Purpose:** Explicit `/command` workflows with multi-step processes.

**Use for Anki:**
- `/anki-create` - Create card from conversation
- `/anki-sync` - Sync notes from Obsidian
- `/anki-review` - Interactive review session
- `/anki-stats` - Show deck statistics
- `/anki-search` - Search and display cards

**Structure:**

```
.claude/commands/
└── anki/
    ├── create-card.md
    ├── sync-vault.md
    ├── review-session.md
    └── deck-stats.md
```

**Command Format:**

```yaml
---
description: Create Anki flashcard from conversation context
argument-hint: "[topic] [--deck DeckName] [--tags tag1,tag2]"
allowed-tools: [Read, Write, Bash, mcp__anki__addNote, mcp__anki__findNotes, mcp__anki__modelNames]
---

# Create Anki Card

## Task

Create a high-quality Anki flashcard based on the current conversation or specified topic.

## Process

1. **Gather Context**
   - Extract key information from conversation
   - Identify the core concept to memorize
   - Parse arguments for deck and tags

2. **Select Note Type**
   - Use mcp__anki__modelNames to list available types
   - Default to "Basic" unless cloze deletion is appropriate

3. **Create Card**
   - Front: Clear, specific question
   - Back: Concise, complete answer
   - Apply atomic principle (one fact per card)

4. **Add to Anki**
   - Use mcp__anki__addNote
   - Verify creation succeeded

5. **Confirm**
   - Display created card to user
   - Show deck and tags applied

## Verification

Always check the result from addNote before claiming success.

## Error Handling

- If duplicate detected: Show existing card, ask user for action
- If deck doesn't exist: Offer to create it
- If connection fails: Check Anki is running with AnkiConnect
```

**Key Guidelines:**
- One workflow per command
- Specify `allowed-tools` for security
- Include verification steps
- Handle errors explicitly

### Agents (`.claude/agents/[name].md`)

**Purpose:** Specialized subagents with isolated context for complex operations.

**Use for Anki:**
- `anki-card-creator` - Creates quality cards from content
- `anki-researcher` - Explores and extracts knowledge
- `anki-sync-agent` - Batch sync operations
- `anki-reviewer` - Handles study sessions

**Structure:**

```
.claude/agents/
├── anki-card-creator.md
├── anki-researcher.md
└── anki-sync-agent.md
```

**Agent Format:**

```yaml
---
name: anki-card-creator
description: >
  Creates high-quality Anki flashcards from content. Use proactively when
  user discusses topics worth remembering or explicitly asks for cards.
tools: Read, Write, Grep, Glob, mcp__anki__addNote, mcp__anki__findNotes, mcp__anki__modelNames, mcp__anki__modelFieldNames
model: haiku
memory: user
---

You are an expert at creating effective Anki flashcards that maximize retention.

## Core Principles

1. **Atomic**: One concept per card
2. **Clear**: Unambiguous questions with single correct answers
3. **Contextualized**: Include enough context to avoid ambiguity
4. **Connected**: Reference related concepts when helpful

## Card Creation Process

1. Identify the key fact or concept
2. Formulate a clear, specific question
3. Write a concise, complete answer
4. Add relevant tags for organization
5. Check for duplicates before adding

## Note Types

- **Basic**: Simple Q&A (default)
- **Basic (and reversed)**: Learn both directions
- **Cloze**: For lists, definitions, fill-in-the-blank

## Quality Checklist

Before creating each card:
- [ ] Is this worth remembering long-term?
- [ ] Is the question unambiguous?
- [ ] Is the answer verifiable?
- [ ] Are there existing cards covering this?

## Memory

Update your agent memory with:
- User's preferred deck structure
- Common tags they use
- Card patterns that work well for them
```

**Key Guidelines:**
- Include "use proactively" in description for auto-delegation
- Limit tools to what's needed
- Use `model: haiku` for cost efficiency when appropriate
- Enable `memory: user` for cross-session learning
- Agents cannot spawn other agents

### Hooks (`settings.json` → `hooks`)

**Purpose:** Event-driven automation scripts.

**Use for Anki:**
- `Stop` hook: Capture conversation insights as potential cards
- `PostToolUse` hook: Auto-sync after file edits
- `UserPromptSubmit` hook: Detect Anki-related requests

**Hook Configuration (settings.json):**

```json
{
  "hooks": {
    "Stop": [
      {
        "command": "~/.claude/hooks/anki-session-capture.sh",
        "timeout": 10000
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/anki-sync-check.sh"
          }
        ]
      }
    ]
  }
}
```

**Hook Script Example (`anki-session-capture.sh`):**

```bash
#!/bin/bash
# Capture session insights for potential Anki cards

INPUT=$(cat)
SESSION_FILE="$HOME/.claude/anki-captures/$(date +%Y-%m-%d).md"

# Extract conversation summary if available
SUMMARY=$(echo "$INPUT" | jq -r '.summary // empty')

if [ -n "$SUMMARY" ]; then
  mkdir -p "$(dirname "$SESSION_FILE")"
  echo "## Session $(date +%H:%M)" >> "$SESSION_FILE"
  echo "$SUMMARY" >> "$SESSION_FILE"
  echo "" >> "$SESSION_FILE"
fi

exit 0
```

**Available Hook Events:**

| Event | When | Use Case |
|-------|------|----------|
| `UserPromptSubmit` | Before processing user message | Detect Anki requests |
| `PreToolUse` | Before tool execution | Validate operations |
| `PostToolUse` | After tool execution | Trigger syncs |
| `Stop` | Session ends | Capture insights |
| `SubagentStart` | Subagent begins | Setup resources |
| `SubagentStop` | Subagent completes | Cleanup |

---

## 5. Recommended Architecture

### Directory Structure

```
.claude/
├── skills/
│   └── anki-conventions/
│       ├── SKILL.md                 # Query syntax, card patterns, SR principles
│       └── references/
│           ├── query-syntax.md      # Detailed query documentation
│           ├── card-patterns.md     # Card design patterns
│           └── note-types.md        # Available note types
│
├── commands/
│   └── anki/
│       ├── create-card.md           # /anki-create [topic]
│       ├── sync-vault.md            # /anki-sync [vault-path]
│       ├── review-session.md        # /anki-review [deck]
│       ├── deck-stats.md            # /anki-stats [deck]
│       └── search-cards.md          # /anki-search [query]
│
├── agents/
│   ├── anki-card-creator.md         # Creates quality cards from content
│   ├── anki-researcher.md           # Explores docs and extracts knowledge
│   └── anki-sync-agent.md           # Batch sync operations
│
└── hooks/
    └── anki-session-capture.sh      # Capture learnings at session end
```

### Component Responsibilities

| Component | Responsibility |
|-----------|----------------|
| **Skill: anki-conventions** | Background knowledge always available |
| **Command: create-card** | Single card creation workflow |
| **Command: sync-vault** | Obsidian to Anki sync |
| **Command: review-session** | Interactive study |
| **Agent: card-creator** | Bulk card creation with quality focus |
| **Agent: researcher** | Content extraction and card generation |
| **Hook: session-capture** | Automatic insight collection |

### Data Flow

```
User Request
     │
     ▼
┌─────────────────┐
│ Skill triggers? │──Yes──▶ Load anki-conventions
└────────┬────────┘
         │ No
         ▼
┌─────────────────┐
│ /command used?  │──Yes──▶ Execute command workflow
└────────┬────────┘
         │ No
         ▼
┌─────────────────┐
│ Complex task?   │──Yes──▶ Delegate to agent
└────────┬────────┘
         │ No
         ▼
    Direct MCP call
         │
         ▼
┌─────────────────┐
│ Session ends    │──────▶ Hook captures insights
└─────────────────┘
```

---

## 6. Key Design Considerations

### From Claude Code Documentation

| Principle | Application to Anki |
|-----------|---------------------|
| Skills <500 lines | Keep anki-conventions lean, use references/ |
| Commands: explicit workflows | One command = one complete Anki operation |
| Agents: isolated context | Use for bulk operations with verbose output |
| Hooks: event-driven | Capture session insights automatically |
| Tools: MCP over Bash | Use `mcp__anki__*` instead of curl/scripts |

### Context Management

```
Metadata (always loaded)     → Skill descriptions (~100 words each)
                              ↓
SKILL.md body (on trigger)   → Anki conventions (~300 lines)
                              ↓
References (on demand)       → Detailed query syntax, patterns
```

### Degrees of Freedom

| Task Type | Freedom Level | Approach |
|-----------|---------------|----------|
| Card content | High | Text instructions, principles |
| Query syntax | Medium | Templates with examples |
| Sync operations | Low | Specific scripts, exact steps |
| API calls | Low | Structured MCP tool calls |

### Tool Selection Priority

1. **MCP tools** (`mcp__anki__*`) - Preferred for all Anki operations
2. **Read/Write/Edit** - For local file operations
3. **Bash** - Only for git, npm, or system commands

### Verification Pattern

```markdown
## Verification

1. Check AnkiConnect is running: `mcp__anki__sync` or version check
2. After addNote: Verify returned note ID is not null
3. After updateNoteFields: Re-fetch note to confirm changes
4. After deleteNotes: Verify notes no longer exist

Never claim success without verification.
```

### Error Handling Pattern

```markdown
## Error Handling

- **Connection refused**: Check Anki is running with AnkiConnect installed
- **Duplicate note**: Show existing note, ask user for action
- **Invalid model**: List available models, suggest alternatives
- **Missing deck**: Offer to create deck
- **Timeout**: Retry once, then report to user
```

---

## 7. Integration Options

### Option A: MCP Server Only

**Setup:** Already configured in settings.local.json

**Pros:**
- No additional code needed
- Well-tested, maintained package
- Direct Claude integration

**Cons:**
- Limited customization
- Fixed tool set
- No custom workflows

**Best for:** Quick start, simple operations

### Option B: Skills + Commands

**Setup:** Create .claude/skills/ and .claude/commands/ directories

**Pros:**
- Flexible, version-controlled
- Shareable with team
- Custom workflows

**Cons:**
- More setup time
- Requires maintenance

**Best for:** Team projects, custom workflows

### Option C: Custom Python Scripts

**Setup:** Use existing clients in obsidian-to-anki or claude-code-obsidian-anki

**Pros:**
- Full control
- Existing tested code
- Complex logic possible

**Cons:**
- Requires Bash tool calls
- More maintenance
- Not MCP-native

**Best for:** Complex sync operations, existing infrastructure

### Option D: Hybrid (Recommended)

**Setup:** MCP server + Skills/Commands + Agents for complex workflows

**Pros:**
- Best of all approaches
- Gradual complexity
- Maximum flexibility

**Cons:**
- More components to manage

**Implementation:**

1. **Start:** Use MCP server for direct operations
2. **Add:** Skills for background knowledge
3. **Add:** Commands for explicit workflows
4. **Add:** Agents for complex/bulk operations
5. **Add:** Hooks for automation

---

## 8. Sources

### AnkiConnect

- [AnkiConnect GitHub (archived)](https://github.com/FooSoft/anki-connect)
- [AnkiConnect SourceHut (current)](https://git.sr.ht/~foosoft/anki-connect)
- [AnkiConnect API Reference](https://deepwiki.com/amikey/anki-connect/2.2-api-reference)
- [AnkiWeb Add-on Page](https://ankiweb.net/shared/info/2055492159)

### Anki MCP Server

- [GitHub - ankimcp/anki-mcp-server](https://github.com/ankimcp/anki-mcp-server)
- [npm - @ankimcp/anki-mcp-server](https://www.npmjs.com/package/@ankimcp/anki-mcp-server)
- [Anki MCP Installation Guide](https://ankimcp.ai/docs/installation/mcp-clients/)

### Claude Code

- [Claude Code Subagents Documentation](https://code.claude.com/docs/en/sub-agents)
- [Claude Code Skills and Commands](https://claudelog.com/mechanics/custom-agents/)
- [Claude Code Best Practices](https://www.builder.io/blog/claude-code)
- [How I Use Every Claude Code Feature](https://blog.sshh.io/p/how-i-use-every-claude-code-feature)
- [Mastering Claude Code Agents](https://new2026.medium.com/practical-guide-to-mastering-claude-codes-main-agent-and-sub-agents-fd52952dcf00)

### Related Libraries

- [yanki-connect (TypeScript client)](https://github.com/kitschpatrol/yanki-connect)
- [anki_connect (Elixir client)](https://hexdocs.pm/anki_connect/)
- [ankiconnect (Go client)](https://pkg.go.dev/github.com/atselvan/ankiconnect)

---

## Appendix: Quick Start Checklist

### Prerequisites

- [ ] Anki installed and running
- [ ] AnkiConnect add-on installed (code: 2055492159)
- [ ] Claude Code configured
- [ ] MCP server entry in settings.local.json

### Verification

```bash
# Check AnkiConnect is running
curl -s http://localhost:8765 -d '{"action":"version","version":6}' | jq

# Check MCP server is available in Claude Code
# Start Claude Code and check for anki tools
```

### First Steps

1. Test MCP connection: Ask Claude to list your decks
2. Create a simple card: Use the MCP addNote tool
3. Add the skill: Create .claude/skills/anki-conventions/
4. Add a command: Create .claude/commands/anki/create-card.md
5. Test the workflow: Run /anki-create with a topic
