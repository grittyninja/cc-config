#!/bin/bash

# Claude Code Stop Hook Script
# Prevents premature stopping when current session tasks are incomplete
# Fast session-aware implementation

set -euo pipefail

# Parse JSON input from stdin and extract session todos
analyze_session_todos() {
    local session_data pending in_progress completed total
    
    # Read JSON from stdin
    session_data=$(cat)
    
    # Extract session_id
    local session_id
    session_id=$(echo "$session_data" | jq -r '.session_id // empty' 2>/dev/null)
    
    if [[ -z "$session_id" || "$session_id" == "null" ]]; then
        echo "0 0 0 0"  # No session ID, allow stop
        return
    fi
    
    # Construct todo file path for current session
    local todo_file="$HOME/.claude/todos/${session_id}-agent-${session_id}.json"
    
    if [[ ! -f "$todo_file" || ! -s "$todo_file" ]]; then
        echo "0 0 0 0"  # No todo file or empty, allow stop
        return
    fi
    
    # Fast JSON parsing - single jq call for all counts
    local counts
    counts=$(jq -r '
        [
            ([.[] | select(.status == "pending")] | length),
            ([.[] | select(.status == "in_progress" or .status == "in-progress")] | length),
            ([.[] | select(.status == "completed" or .status == "done")] | length),
            length
        ] | join(" ")
    ' "$todo_file" 2>/dev/null || echo "0 0 0 0")
    
    echo "$counts"
}


# Generate intervention prompt for incomplete tasks
generate_intervention_prompt() {
    local pending="$1"
    local in_progress="$2" 
    local total="$3"
    
    cat << EOF

**Implementation Incomplete**: You have $pending pending and $in_progress in-progress tasks that need actual implementation work.

Please **implement and finish the actual work** for these remaining tasks before stopping. Do not just mark them as completed - actually do the implementation, coding, testing, or other work described in each task.

**Focus only on completing existing work - do not add new features or expand scope.**
EOF
}

# Main logic
main() {
    # Check if user explicitly requested stop
    if [[ "${CLAUDE_USER_REQUESTED_STOP:-}" == "1" ]]; then
        exit 0  # Allow stop silently
    fi
    
    # Analyze current session todo state from stdin
    local todo_stats
    todo_stats=$(analyze_session_todos)
    read -r pending in_progress completed total <<< "$todo_stats"
    
    # If no todos exist, allow stop silently
    if [[ "$total" -eq 0 ]]; then
        exit 0  # Exit 0 - no output shown to model
    fi
    
    # Simple deterministic logic: if there are incomplete tasks, send steering message
    local incomplete_count=$((pending + in_progress))
    
    if [[ "$incomplete_count" -gt 0 ]]; then
        echo "$(generate_intervention_prompt "$pending" "$in_progress" "$total")" >&2
        exit 2  # Exit 2 - show stderr to model and continue conversation
    fi
    
    # All tasks are completed - allow stop silently  
    exit 0  # Exit 0 - no output shown to model
}

# Execute main function
main