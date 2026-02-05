# Ralph Infrastructure Research

Research for implementing long-running task automation (e.g., processing 100+ Anki cards).

## Table of Contents

- [Overview](#overview)
- [Project Comparison](#project-comparison)
- [snarktank/ralph](#snarktankralph)
- [frankbria/ralph-claude-code](#frankbriaralph-claude-code)
- [michaelshimeles/ralphy](#michaelshimelesralphy)
- [subsy/ralph-tui](#subsyralph-tui)
- [ClaytonFarr/ralph-playbook](#claytonfarrralph-playbook)
- [Recommendation for Anki Project](#recommendation-for-anki-project)
- [Implementation Plan](#implementation-plan)

---

## Overview

**Ralph** is an automation pattern for running AI coding tools (Claude Code, Amp, etc.) in autonomous loops until tasks are complete. Named after Geoffrey Huntley's technique, it enables:

- **Long-running operations** - Process large task lists across multiple iterations
- **Context management** - Fresh context per iteration with persistent state via files
- **Progress tracking** - Track completion through JSON task files and git commits
- **Quality gates** - Validate work before committing (tests, type checks, etc.)

### Core Concept

```
┌─────────────────────────────────────────────────────────┐
│                    RALPH LOOP                           │
├─────────────────────────────────────────────────────────┤
│  1. Select highest-priority incomplete task             │
│  2. Execute task with fresh AI context                  │
│  3. Run validation (tests, checks)                      │
│  4. Commit on success                                   │
│  5. Update task status in JSON                          │
│  6. Append learnings to progress file                   │
│  7. Repeat until all tasks complete or limit reached    │
└─────────────────────────────────────────────────────────┘
```

### State Persistence

Since each iteration starts with fresh context, state persists through:

| Mechanism | Purpose |
|-----------|---------|
| `prd.json` | Task list with completion status |
| `progress.txt` | Accumulated learnings and notes |
| Git commits | Code changes and history |
| `AGENTS.md` | Project conventions for AI |

---

## Project Comparison

| Feature | snarktank/ralph | frankbria/ralph-claude-code | ralphy | ralph-tui |
|---------|-----------------|----------------------------|--------|-----------|
| **Primary Tool** | Amp / Claude | Claude Code | Multi-engine | Multi-engine |
| **Installation** | Script copy | Global CLI | npm package | bun package |
| **Parallel Execution** | No | No | Yes (5 agents) | No |
| **TUI/Dashboard** | No | tmux monitor | No | Full TUI |
| **Exit Detection** | Iteration limit | Dual-condition gate | Iteration limit | Completion detect |
| **Session Continuity** | No | Yes | No | Yes |
| **Rate Limiting** | No | Yes (100/hr) | No | No |
| **Remote Control** | No | No | No | Yes |
| **Complexity** | Low | Medium | Medium | Medium |
| **Best For** | Simple loops | Production use | Parallel tasks | Monitoring |

---

## snarktank/ralph

**Repository:** https://github.com/snarktank/ralph

### Overview

The original Ralph implementation. A bash script that orchestrates AI coding tools in a loop.

### Key Files

| File | Purpose |
|------|---------|
| `ralph.sh` | Main orchestration script |
| `prompt.md` | System prompt template |
| `prd.json` | Task list with status |
| `progress.txt` | Accumulated learnings |

### Installation

```bash
# Option 1: Copy to project
cp ralph.sh scripts/ralph/
cp prompt.md scripts/ralph/

# Option 2: Global skills
cp -r skills/prd ~/.claude/skills/
cp -r skills/ralph ~/.claude/skills/
```

### Usage

```bash
# Run with Claude Code
./scripts/ralph/ralph.sh --tool claude [max_iterations]

# Default: 10 iterations
./scripts/ralph/ralph.sh --tool claude 20
```

### Task Format (prd.json)

```json
{
  "userStories": [
    {
      "id": "US001",
      "title": "Process card batch",
      "description": "Process first 10 cards from deck",
      "acceptanceCriteria": ["Cards processed", "Progress logged"],
      "passes": false
    }
  ]
}
```

### Pros/Cons

**Pros:**
- Simple, easy to understand
- Minimal dependencies
- Works with multiple AI tools

**Cons:**
- No parallel execution
- No smart exit detection
- No session continuity
- No rate limiting

---

## frankbria/ralph-claude-code

**Repository:** https://github.com/frankbria/ralph-claude-code

### Overview

Claude Code-specific implementation with intelligent exit detection, rate limiting, and session continuity. Most production-ready option.

### Key Features

- **Dual-condition exit gate**: Requires both completion indicators AND explicit `EXIT_SIGNAL: true`
- **Session continuity**: Preserves context across iterations
- **Rate limiting**: 100 calls/hour (configurable)
- **Circuit breaker**: Stops after 3 no-progress loops
- **tmux monitoring**: Live dashboard

### Installation

```bash
# Clone and install globally
git clone https://github.com/frankbria/ralph-claude-code.git
cd ralph-claude-code
./install.sh

# Enable in existing project
cd my-project
ralph-enable
```

### Configuration (.ralphrc)

```bash
PROJECT_NAME="ai-agent-anki"
MAX_CALLS_PER_HOUR=100
CLAUDE_TIMEOUT_MINUTES=15
ALLOWED_TOOLS="Write,Read,Edit,Bash(git *),mcp__anki__*"
SESSION_CONTINUITY=true
SESSION_EXPIRY_HOURS=24
```

### Directory Structure (.ralph/)

```
.ralph/
├── PROMPT.md      # High-level project goals
├── fix_plan.md    # Prioritized task list
├── AGENT.md       # Build/test commands (auto-maintained)
└── specs/         # Detailed requirements
```

### Usage

```bash
# With monitoring (recommended)
ralph --monitor

# Custom rate limits
ralph --calls 50

# Resume session
ralph --resume <session_id>
```

### Pros/Cons

**Pros:**
- Intelligent exit detection
- Session continuity
- Rate limiting and safety features
- Production-ready (465 tests)
- tmux monitoring

**Cons:**
- More complex setup
- Claude Code only
- No parallel execution

---

## michaelshimeles/ralphy

**Repository:** https://github.com/michaelshimeles/ralphy

### Overview

Multi-engine CLI supporting parallel execution with up to 5 agents. Works with Claude Code, Copilot, Codex, Gemini, and others.

### Key Features

- **Multi-engine**: 8 different AI coding tools
- **Parallel execution**: Up to 5 agents simultaneously
- **Isolated worktrees**: Each agent gets separate git branch
- **Auto-merge**: AI-assisted conflict resolution
- **Webhooks**: Discord, Slack notifications

### Installation

```bash
# npm (recommended)
npm install -g ralphy-cli

# Or bash
git clone https://github.com/michaelshimeles/ralphy.git
cd ralphy && chmod +x ralphy.sh
```

### Configuration (.ralphy/config.yaml)

```yaml
project:
  name: ai-agent-anki
  language: typescript
  framework: claude-code

commands:
  test: "echo 'No tests'"
  lint: "echo 'No lint'"

rules:
  - "Process cards in batches of 10"
  - "Always verify Anki connection first"

boundaries:
  never_touch:
    - "*.env*"
    - ".claude/settings.json"

parallel:
  max_agents: 3
  merge_strategy: auto
```

### Usage

```bash
# Simple task
ralphy "process 10 cards from deck"

# With PRD file
ralphy --prd tasks.md

# Parallel execution
ralphy --parallel --max-parallel 3 --prd tasks.md

# Create PRs instead of merging
ralphy --parallel --create-pr --prd tasks.md
```

### Task Format (Markdown)

```markdown
# Tasks

## Group 1 (parallel)
- [ ] Process cards 1-10
- [ ] Process cards 11-20
- [ ] Process cards 21-30

## Group 2 (sequential, after Group 1)
- [ ] Verify all cards processed
- [ ] Generate summary report
```

### Pros/Cons

**Pros:**
- Parallel execution (huge for large tasks)
- Multi-engine support
- Webhook notifications
- GitHub issue sync

**Cons:**
- More complex setup
- Requires managing multiple branches
- Conflict resolution can be tricky

---

## subsy/ralph-tui

**Repository:** https://github.com/subsy/ralph-tui

### Overview

Terminal UI for managing Ralph loops with real-time monitoring, remote instance control, and session persistence.

### Key Features

- **Full TUI**: Keyboard-driven interface
- **Real-time monitoring**: Subagent call tracing
- **Session persistence**: Pause/resume capability
- **Remote control**: Manage multiple instances across machines
- **Theme support**: Customizable appearance

### Installation

```bash
bun install -g ralph-tui
cd my-project
ralph-tui setup
```

### Usage

```bash
# Run with PRD
ralph-tui run --prd ./tasks.json

# Listen for remote connections
ralph-tui --listen
```

### Keyboard Controls

| Key | Action |
|-----|--------|
| `s` | Start execution |
| `p` | Pause |
| `d` | Toggle dashboard |
| `q` | Quit |
| `Tab` | Switch remote instances |

### Pros/Cons

**Pros:**
- Best monitoring experience
- Session persistence
- Remote instance control
- Real-time visibility

**Cons:**
- Requires bun runtime
- No parallel execution
- Overkill for simple tasks

---

## ClaytonFarr/ralph-playbook

**Repository:** https://github.com/ClaytonFarr/ralph-playbook

### Overview

Not a tool, but a methodology guide. Documents best practices for running autonomous AI coding loops.

### Core Principles

1. **Context is everything**: ~40-60% of token limit is optimal zone
2. **Upstream steering**: Deterministic setup with consistent file loading
3. **Downstream steering**: Backpressure via tests and validation
4. **Let Ralph Ralph**: Trust self-correction, regenerate plans when needed
5. **Move outside the loop**: Engineer environment, don't prescribe everything

### Three Phases

1. **Define**: Create specs via LLM conversations
2. **Plan**: Gap analysis, generate task list
3. **Build**: Implement tasks, validate, commit

### File Structure

```
project-root/
├── loop.sh              # Core loop script
├── PROMPT_build.md      # Building instructions
├── PROMPT_plan.md       # Planning instructions
├── AGENTS.md            # Operational guide
├── IMPLEMENTATION_PLAN.md  # Persistent task state
├── specs/               # Requirement specs
└── src/                 # Application code
```

### Key Language Patterns

| Pattern | Purpose |
|---------|---------|
| "Study" (not "read") | Deeper analysis |
| "Don't assume not implemented" | Prevents hallucination |
| "Using parallel subagents" | Enables concurrency |
| "Only 1 subagent for build/tests" | Controls backpressure |
| "Capture the why" | Documents reasoning |

### When to Regenerate Plan

- Ralph goes off track
- Plan feels stale
- Too much clutter
- Major spec changes
- Confusion about completion

---

## Recommendation for Anki Project

For processing 100+ Anki cards, I recommend **frankbria/ralph-claude-code** as the primary choice with elements from **ralphy** for parallel execution.

### Why ralph-claude-code?

1. **Session continuity**: Critical for maintaining Anki connection state
2. **Rate limiting**: Prevents hitting API limits during long runs
3. **Intelligent exit detection**: Won't stop prematurely
4. **Safety features**: Circuit breaker prevents infinite loops
5. **Production ready**: 465 tests, battle-tested

### Hybrid Approach

For maximum throughput:

1. Use **ralph-claude-code** for orchestration and safety
2. Design tasks to use Claude Code's **parallel subagents** internally
3. Process cards in batches (10-20 per iteration)
4. Each iteration = one batch, fresh context

### Task Sizing for Anki

| Task Size | Example | Context Usage |
|-----------|---------|---------------|
| Too small | "Process 1 card" | Inefficient |
| **Optimal** | "Process batch of 10-20 cards" | Good balance |
| Too large | "Process all 500 cards" | Context overflow |

---

## Implementation Plan

### Phase 1: Install ralph-claude-code

```bash
git clone https://github.com/frankbria/ralph-claude-code.git ~/tools/ralph-claude-code
cd ~/tools/ralph-claude-code
./install.sh
```

### Phase 2: Enable in Anki Project

```bash
cd /Users/npochaev/GitHub/ai-agent-anki
ralph-enable
```

### Phase 3: Configure .ralphrc

```bash
PROJECT_NAME="ai-agent-anki"
MAX_CALLS_PER_HOUR=50
CLAUDE_TIMEOUT_MINUTES=30
ALLOWED_TOOLS="Read,Write,Edit,Glob,Grep,Bash(git *),mcp__anki__*"
SESSION_CONTINUITY=true
SESSION_EXPIRY_HOURS=4
```

### Phase 4: Create Task Structure

```
.ralph/
├── PROMPT.md           # Anki processing goals
├── fix_plan.md         # Batch task list
├── AGENT.md            # Anki-specific commands
└── specs/
    └── card-processing.md  # Processing requirements
```

### Phase 5: Define Batch Tasks (fix_plan.md)

```markdown
# Anki Card Processing Plan

## Batch 1: Cards 1-20
- [ ] Verify Anki connection
- [ ] Fetch cards 1-20 from deck
- [ ] Process each card
- [ ] Log progress

## Batch 2: Cards 21-40
- [ ] Fetch cards 21-40
- [ ] Process each card
- [ ] Log progress

... (continue for all batches)

## Final: Summary
- [ ] Generate processing report
- [ ] Verify all cards processed
```

### Phase 6: Run

```bash
ralph --monitor
```

---

## Sources

- [snarktank/ralph](https://github.com/snarktank/ralph)
- [frankbria/ralph-claude-code](https://github.com/frankbria/ralph-claude-code)
- [michaelshimeles/ralphy](https://github.com/michaelshimeles/ralphy)
- [subsy/ralph-tui](https://github.com/subsy/ralph-tui)
- [ClaytonFarr/ralph-playbook](https://github.com/ClaytonFarr/ralph-playbook)
- [Geoffrey Huntley's Original Ralph Article](https://ghuntley.com/ralph)
