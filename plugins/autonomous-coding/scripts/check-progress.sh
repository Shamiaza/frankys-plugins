#!/bin/bash
# Check progress of autonomous-coding project
# Reads feature_list.json and displays summary

FEATURE_FILE="${1:-feature_list.json}"

if [ ! -f "$FEATURE_FILE" ]; then
    echo "No feature_list.json found."
    echo "Run /autonomous-coding:init to generate features."
    exit 0
fi

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "Warning: jq not installed. Using basic parsing."
    TOTAL=$(grep -c '"id":' "$FEATURE_FILE" 2>/dev/null || echo "0")
    PASSING=$(grep -c '"passes": true' "$FEATURE_FILE" 2>/dev/null || echo "0")
else
    TOTAL=$(jq '.features | length' "$FEATURE_FILE" 2>/dev/null || echo "0")
    PASSING=$(jq '[.features[] | select(.passes == true)] | length' "$FEATURE_FILE" 2>/dev/null || echo "0")
fi

if [ "$TOTAL" -eq 0 ]; then
    echo "Feature list is empty or invalid."
    exit 1
fi

PERCENT=$(echo "scale=1; $PASSING * 100 / $TOTAL" | bc 2>/dev/null || echo "N/A")
REMAINING=$((TOTAL - PASSING))

echo "================================"
echo "  Autonomous Coding Progress"
echo "================================"
echo ""
echo "  Passing:   $PASSING / $TOTAL ($PERCENT%)"
echo "  Remaining: $REMAINING features"
echo ""

# Progress bar
if command -v bc &> /dev/null; then
    FILLED=$(echo "scale=0; $PASSING * 30 / $TOTAL" | bc)
    EMPTY=$((30 - FILLED))
    printf "  ["
    printf "%${FILLED}s" | tr ' ' '#'
    printf "%${EMPTY}s" | tr ' ' '-'
    printf "]\n"
fi

echo ""

# Show categories breakdown if jq available
if command -v jq &> /dev/null; then
    echo "  By Category:"
    jq -r '.features | group_by(.category) | .[] | "    " + .[0].category + ": " + (([.[] | select(.passes == true)] | length | tostring)) + "/" + (length | tostring)' "$FEATURE_FILE" 2>/dev/null
fi

echo ""
echo "================================"
