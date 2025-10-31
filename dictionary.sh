#!/bin/bash
# Simple Dictionary Tool (Shell Version)

WORD=$1

# 🧭 Step 1: Check if user provided a word
if [ -z "$WORD" ]; then
  echo "Usage: ./dictionary.sh <word>"
  exit 1
fi

# 🗂 Step 2: Try to find meaning in local words.txt file
if [ -f "words.txt" ]; then
  if grep -iq "^$WORD:" words.txt; then
    grep -i "^$WORD:" words.txt
    exit 0
  fi
fi

# 🌐 Step 3: Try online lookup using Dictionary API
if command -v curl >/dev/null 2>&1; then
  RESPONSE=$(curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/$WORD")
  
  # Requires jq to parse JSON cleanly
  if command -v jq >/dev/null 2>&1; then
    MEANING=$(echo "$RESPONSE" | jq -r '.[0].meanings[0].definitions[0].definition' 2>/dev/null)
    if [ "$MEANING" != "null" ] && [ -n "$MEANING" ]; then
      echo "$WORD: $MEANING"
      exit 0
    fi
  fi
fi

# ❌ Step 4: If not found
echo "❌ No definition found for '$WORD'."
