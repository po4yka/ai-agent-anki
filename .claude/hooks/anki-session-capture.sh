#!/bin/bash
# anki-session-capture.sh
# Captures potential flashcard content from Claude Code sessions
#
# This hook runs at session end (Stop event) and extracts
# learning insights that could become Anki cards.
#
# Output is saved to a daily capture file for later review.

set -euo pipefail

# Configuration
CAPTURE_DIR="${HOME}/.claude/anki-captures"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M:%S)
CAPTURE_FILE="${CAPTURE_DIR}/${DATE}.md"

# Read input from stdin (JSON from Claude Code)
INPUT=$(cat)

# Ensure capture directory exists
mkdir -p "$CAPTURE_DIR"

# Extract session info if available
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"' 2>/dev/null || echo "unknown")
WORKING_DIR=$(echo "$INPUT" | jq -r '.cwd // "unknown"' 2>/dev/null || echo "unknown")

# Create or append to daily capture file
if [ ! -f "$CAPTURE_FILE" ]; then
    cat > "$CAPTURE_FILE" << EOF
# Anki Capture - ${DATE}

Potential flashcard content from Claude Code sessions.
Review and create cards using \`/anki-create\` or the anki-card-creator agent.

---

EOF
fi

# Append session marker
cat >> "$CAPTURE_FILE" << EOF

## Session ${TIME}

**Directory:** ${WORKING_DIR}
**Session ID:** ${SESSION_ID}

### Potential Cards

<!-- Add extracted insights here -->
<!-- Format: Q: question / A: answer -->

---

EOF

# Output success (hook should not block)
echo '{"status": "captured", "file": "'"$CAPTURE_FILE"'"}'

exit 0
