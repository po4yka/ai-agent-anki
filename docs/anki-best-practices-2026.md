# Anki Best Practices in 2026: FSRS, Atomic Cards, and AI-Assisted Workflows

> Background research document for the AI Agent Anki project. For actionable quick references, see `.claude/skills/anki-conventions/references/`.

## Table of Contents

- [Overview](#overview)
- [Wozniak's Rules and Modern Frameworks](#wozniaks-rules-and-modern-frameworks)
- [FSRS Algorithm](#fsrs-algorithm)
- [Retention vs Workload Tradeoffs](#retention-vs-workload-tradeoffs)
- [Daily Habits and Backlog Management](#daily-habits-and-backlog-management)
- [Programming Cards](#programming-cards)
- [Essential Add-ons](#essential-add-ons)
- [MCP Servers and AI-Assisted Card Creation](#mcp-servers-and-ai-assisted-card-creation)
- [Knowledge Management Integration](#knowledge-management-integration)
- [Anti-Patterns to Avoid](#anti-patterns-to-avoid)
- [Conclusion](#conclusion)

---

## Overview

The landscape of spaced repetition has fundamentally shifted since FSRS (Free Spaced Repetition Scheduler) became Anki's default algorithm in late 2023. **FSRS reduces daily reviews by 20-30%** compared to the legacy SM-2 algorithm while achieving the same retention, making it the clear choice for all users. The community consensus is now near-unanimous: enable FSRS, set desired retention to **0.90**, use single short learning steps (15-30 minutes), and let the algorithm's 21 machine-learned parameters handle scheduling.

Beyond algorithmic improvements, the integration of AI tools and knowledge management systems has transformed card creation workflows. Claude and ChatGPT can now draft cards from PDFs and lecture notes, while MCP (Model Context Protocol) servers enable natural language commands like "add a vocabulary card for 'perseverance' to my English deck" directly from Claude Desktop. Meanwhile, Obsidian-to-Anki plugins have matured, allowing users to maintain their notes as canonical sources while automatically syncing flashcards.

The core principles from Piotr Wozniak's **20 Rules of Formulating Knowledge** remain foundational, but the community has distilled them into more practical frameworks. The most important takeaway hasn't changed: **understand before you memorize**, and make every card atomic.

---

## Wozniak's Rules and Modern Frameworks

Piotr Wozniak's original 20 rules from 1999 remain the bedrock of effective flashcard design, but the Anki community has refined them into more actionable principles. The most critical rules, in order: never learn what you don't understand, build the big picture before creating cards, and follow the **minimum information principle**—the rule Wozniak himself considers most important.

LeanAnki distilled these into three memorable principles called **EAT**: cards must be *Encoded* (created only from material you've already learned), *Atomic* (testing one specific fact), and *Timeless* (comprehensible to your future self). Soren Bjornstad's Control-Alt-Backspace blog added precision rules: questions should ask exactly one thing, permit exactly one answer, and avoid yes/no formats that are hard to remember and less useful.

The infamous "Dead Sea example" illustrates minimum information perfectly. A card asking "What are the characteristics of the Dead Sea?" with a paragraph answer should become multiple atomic cards: "Where is the Dead Sea located?" (Border of Israel and Jordan), "How much saltier is the Dead Sea than oceans?" (7 times). Each fact gets its own forgetting curve.

Medical school communities have pushed these principles furthest. The consensus on r/MedicalSchoolAnki favors **cloze deletions and image occlusion** over basic cards, maintaining a strict 1:1 ratio of fact to card. They recommend 20-30 new cards daily as sustainable (100+ leads to burnout), and only unsuspending or creating cards *after* watching the corresponding lecture—never before.

---

## FSRS Algorithm

The transition from Anki's original SM-2 algorithm to FSRS represents the biggest improvement in spaced repetition since the field's inception. Created by Jarrett Ye and trained on **700 million reviews from 20,000 users**, FSRS uses machine learning to track three memory states per card: retrievability (probability of recall), stability (how quickly you forget), and difficulty (inherent complexity affecting learning speed).

The advantages are substantial. FSRS eliminates **"ease hell"**—the death spiral where cards get stuck at minimum ease after repeated failures—because it doesn't use ease factors at all. It handles overdue cards intelligently rather than punishing you for missed study days. And it allows you to set your exact target retention rate, something SM-2 never offered.

Current versions have evolved significantly. **FSRS-5** (Anki 24.11) added short-term memory modeling and recency weighting. **FSRS-6** (Anki 25.02+) expanded to 21 parameters and considers all reviews per day, not just the first. Community polls are "unanimous" on FSRS being better—benchmarks show FSRS-5 outperforms even trainable SM-2 variants in 97.4% of cases.

The optimal setup is straightforward: enable FSRS globally, set **desired retention to 0.90** (0.85-0.95 depending on stakes), configure a single short learning step like 15 or 30 minutes, click "Optimize" monthly, and critically—never press "Hard" when you've forgotten. FSRS assumes Hard means "recalled with difficulty," so misusing it breaks the algorithm. Use only Again and Good for most reviews.

---

## Retention vs Workload Tradeoffs

Understanding the exponential relationship between retention targets and review load is essential. At **0.90 retention**, you achieve a good balance for most purposes. Push to 0.95 and your intervals nearly halve. At 0.97, you're doing 3.7 times more reviews. At 0.99, ten times more.

Medical students preparing for board exams might reasonably target 92-95% retention, accepting the higher workload for higher-stakes material. Casual learners working through large vocabulary decks might prefer 85% to reduce the burden. The FSRS Helper add-on previously included a "Compute Minimum Recommended Retention" feature that found the retention rate maximizing learning per time spent—though this was temporarily removed from Anki 25.x pending UI rework.

Several SM-2 settings become irrelevant when FSRS is enabled: graduating interval, easy interval, easy bonus, interval modifier, starting ease, hard interval, and new interval percentage all disappear from the interface. What remains important includes learning steps (keep under one day—**15m or 30m single step** is ideal), relearning steps (10-15 minutes), and your daily new card limit.

---

## Daily Habits and Backlog Management

Consistency beats optimization. The most effective Anki users review **at the same time daily**, treating it like brushing teeth rather than a variable task. Morning reviews are widely recommended—they establish a positive learning sensation before the day's demands pile up and create a reliable routine.

The sustainable new card rate depends on your context. For language learning, **5-20 new cards daily** works for most people, with beginners starting at 5 and increasing as immersion time grows. Medical students using the AnKing deck commonly do 30-50 daily during dedicated study periods, though this is unsustainable long-term. The rule of thumb: multiply your daily new cards by 7-10 to estimate your eventual daily review load. Fifty new cards daily eventually becomes 500-1000 reviews daily.

When life interferes, the response matters:

- **Miss one day?** Just catch up tomorrow—this barely qualifies as a backlog.
- **Miss several days?** The "stop the bleeding" approach works: suspend all overdue cards by searching `prop:due<0`, tag them, then unsuspend manageable batches daily while keeping current with newly-due cards.
- **Miss weeks or months?** Audit ruthlessly, delete what you no longer need, and recognize that since most cards are already overdue, the pile isn't growing much—you can recover faster than you'd expect.

What never to do: reset your deck (you lose all progress on cards you still remember) or use automatic rescheduling tools that hide the true cost of missed study.

---

## Programming Cards

Technical flashcards fail when they try to capture what should be practiced through projects. The golden rule from experienced developers: **you cannot learn programming through flashcards alone**—programming is an applied discipline where knowledge is gained tacitly through building things. Flashcards support this learning; they don't replace it.

Effective programming cards memorize patterns and concepts, not implementations. Cards should capture **core syntax patterns, common gotchas** (JavaScript type coercion, for instance), idioms that recur across languages (map, filter, reduce), error patterns you've encountered, and algorithmic approaches. They should avoid detailed API signatures with every parameter, information that changes frequently, entire function implementations, and multi-step procedural knowledge like deployment scripts.

For code snippets, keep them to 1-5 lines and use syntax highlighting add-ons like Syntax Highlighting for Code (add-on 1463041493) or Greg's Code Highlighter (add-on 112228974). Screenshots from your IDE can work well—the visual context creates richer memory anchors. Cloze deletions excel for code cards: `var a = {{c1::5 + '5'}}; // what is a?` tests understanding of string coercion in one elegant card.

The Janki Method, refined over years by developer Jack Kinsella, crystallized key principles: only add a card after having tried to use the knowledge (Rule 4), and ruthlessly delete incorrect, outdated, or unnecessary cards (Rule 7). For interview preparation, one developer created just 42 Anki cards from 194 LeetCode problems—only cards for problems he struggled with, each containing the problem description, approach, key data structure, and complexity. Review these cards rather than grinding new problems.

---

## Essential Add-ons

Several add-ons have become nearly universal:

| Add-on | Code | Description |
|--------|------|-------------|
| **Review Heatmap** | 1771074083 | GitHub-style heatmap visualizing study history |
| **Image Occlusion Enhanced** | 1374772155 | Hide parts of images for visual learning |
| **AnkiConnect** | 2055492159 | API for automation and integrations |
| **FSRS Helper** | 759844606 | Extended FSRS features, load balancing |
| **Mini Format Pack** | - | Proper bullets and formatting |
| **Frozen Fields** | - | Keep field content between additions |
| **Syntax Highlighting** | 1463041493 | Code syntax highlighting |

**AnkiHub** from the AnKing team enables real-time synchronization with community-improved decks—particularly valuable for medical students using the AnKing Step 1 and Step 2 decks that evolve with community contributions. The AnKing team maintains a compatibility tracker showing which add-ons work with different Anki versions; they recommend Anki 2.1.56 Qt6 for maximum compatibility.

One significant loss: **SIAC (Search Inside Add Card)** was archived in March 2024 and is no longer maintained—a reminder that add-on dependencies can break.

---

## MCP Servers and AI-Assisted Card Creation

Model Context Protocol servers now connect Anki to AI assistants like Claude. The most comprehensive implementation, **@ankimcp/anki-mcp-server**, allows natural language commands from Claude Desktop: "Add a Japanese vocabulary card for '時間' to my Japanese deck" creates the card directly in Anki without manual intervention.

Configuration is straightforward. Install AnkiConnect, ensure Anki is running, and add the MCP server to Claude's configuration file:

```json
{
  "mcpServers": {
    "anki": {
      "command": "npx",
      "args": ["@ankimcp/anki-mcp-server"]
    }
  }
}
```

The AnkiConnect API itself (running on port 8765) enables programmatic access through Python wrappers like **ankiapi** or command-line tools like **py-ankiconnect**. This powers everything from browser extensions that create cards from selected text to bulk processing scripts that convert documentation into flashcard sets.

For direct AI card generation, both Claude and ChatGPT can draft cards from source material, though they have different strengths. **Claude produces more conceptually focused cloze deletions** suited for understanding-based exams, while ChatGPT generates more numerous fact-focused cards suited for memorization-heavy tests. Neither should be trusted blindly—the workflow is AI-assisted, human-approved. Tools like MemoForge wrap this into a polished interface: upload a PDF, receive AI-generated cards with quality scores, verify and edit, then export to Anki.

---

## Knowledge Management Integration

The **Obsidian-to-Anki** ecosystem now offers multiple mature plugins. The primary plugin (ObsidianToAnki) uses custom syntax for flashcards, supports math, images, audio, and tables, and treats your Markdown files as the canonical source. Configuration requires adding `app://obsidian.md` to AnkiConnect's CORS whitelist.

Alternative plugins serve different preferences: **Flashcards-Obsidian** uses simpler inline syntax like `Question::Answer`, **Yanki** maps folder hierarchy directly to Anki decks, and the newer **Anki Integration Plugin** provides a native-feeling popup interface for one-click sync.

**Logseq-anki-sync** brings similar capabilities to Logseq users, rendering Logseq's markdown and org-mode syntax properly in Anki while supporting block references, PDF annotations with image occlusion, and incremental card creation. For Roam Research users, **ankify_roam** offers command-line synchronization that can be automated with cron jobs.

Incremental reading—Wozniak's technique of spacing both reading and reviewing by breaking articles into extracts that become flashcards—has partial support in Anki through the Incremental Reading add-on (935264945), though it lacks SuperMemo's intelligent priority-based scheduling. Some users implement workarounds using Emacs org-mode with AnkiConnect, creating a more sophisticated incremental reading workflow.

---

## Anti-Patterns to Avoid

### Starting with Too Many New Cards

Users excited about a new deck add 30-40 cards daily, not realizing this creates 300-400 daily reviews within weeks. The LessWrong community recommends an extreme constraint: if your daily review limit is 20, set new cards to 2. This prevents the "Anki death spiral" where backlogs become insurmountable.

### Ease Hell (SM-2 only)

Pressing "Again" dropped ease by 20%, but pressing "Good" only maintained it—requiring "Easy" to raise it, which felt wrong on struggled cards. Six failures (not necessarily consecutive) locked cards at minimum ease permanently. FSRS eliminates this entirely, but users on legacy SM-2 can apply workarounds like the "Low-Key Anki" approach: set starting ease to 131% (minimum) with interval modifier at 192% to compensate.

### Making Cards Without Understanding First

Anki is a retention tool, not a learning tool—"scheduled garbage is still garbage." The correct workflow: learn the material, identify what's worth remembering, test your understanding by using the knowledge, *then* create cards. Cards created while reading for the first time produce fragmented knowledge that doesn't transfer.

### Passive Recognition

Users flip cards, read answers, and mark themselves correct without ever committing to a response. The solution: say answers out loud before flipping, or write them down for critical material. If you can't honestly commit to an answer before seeing it, you're not actually testing your memory.

### Over-Reliance on Anki

If you spend more time on Anki than on immersion, practice, or primary learning—something has gone wrong. Anki supports learning; it doesn't constitute it. For procedural skills (coding, music, surgery), flashcards are secondary to actual practice.

---

## Conclusion

Anki in 2026 is more powerful and easier to use correctly than ever. **FSRS has solved the algorithm problem**—enable it, set 0.90 retention, optimize monthly, and stop worrying about intervals. The minimum information principle remains paramount: atomic cards that take under 8 seconds to answer, testing one fact each. For technical knowledge, prioritize concepts over implementations and only card what you've tested in practice.

The integration story has improved dramatically. MCP servers turn Claude into an Anki assistant. Obsidian plugins make your notes the single source of truth. AI can draft cards from PDFs in seconds—though human review remains essential.

The anti-patterns haven't changed: too many new cards, no understanding before cardifying, passive recognition, treating Anki as learning rather than retention. Start with 5-10 new cards daily, always do reviews before adding new cards, and remember that consistency beats intensity. Five minutes daily beats an hour weekly.

The users who succeed share a common trait: they treat Anki as a maintenance tool for knowledge they've already acquired elsewhere, not as a learning system itself. Get that relationship right, and spaced repetition becomes the closest thing to a superpower available to anyone willing to show up daily.
