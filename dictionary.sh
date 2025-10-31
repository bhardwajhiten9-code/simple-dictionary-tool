#!/bin/bash
# 🌐 Simple Dictionary Tool (Enhanced UI Version)
# Author: Hiten's Shell Dictionary
# Description: Looks up word meanings locally and online with clean terminal UI.

# 🎨 Colors
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RED="\033[1;31m"
RESET="\033[0m"

# 🧭 Function: Loading animation
loading() {
  echo -ne "${CYAN}Searching"
  for i in {1..3}; do
    echo -n "."
    sleep 0.3
  done
  echo -e "${RESET}"
}

# 🧾 Function: Display header
header() {
  clear
  echo -e "${YELLOW}=============================="
  echo -e "   🧠 Simple Dictionary Tool"
  echo -e "==============================${RESET}"
}

# 📘 Function: Search local dictionary
search_local() {
  local word="$1"
  if [ -f "words.txt" ]; then
    local result
    result=$(grep -i "^$word:" words.txt)
    if [ -n "$result" ]; then
      echo -e "${GREEN}${result}${RESET}"
      return 0
    fi
  fi
  return 1
}

# 🌐 Function: Search online
search_online() {
  local word="$1"
  if ! command -v curl >/dev/null 2>&1; then
    echo -e "${RED}❌ curl not installed. Cannot fetch online meaning.${RESET}"
    return 1
  fi

  loading
  local response
  response=$(curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/$word")

  # Check if API returned "No Definitions Found"
  if echo "$response" | grep -q '"title": "No Definitions Found"'; then
    echo -e "${RED}❌ No definition found online for '${word}'.${RESET}"
    return 1
  fi

  if command -v jq >/dev/null 2>&1; then
    local meaning pos pronunciation
    meaning=$(echo "$response" | jq -r '.[0].meanings[0].definitions[0].definition' 2>/dev/null)
    pos=$(echo "$response" | jq -r '.[0].meanings[0].partOfSpeech' 2>/dev/null)
    pronunciation=$(echo "$response" | jq -r '.[0].phonetic // empty' 2>/dev/null)

    if [ "$meaning" != "null" ] && [ -n "$meaning" ]; then
      echo -e "${GREEN}$word (${pos})${RESET}"
      [ -n "$pronunciation" ] && echo -e "${CYAN}Pronunciation:${RESET} $pronunciation"
      echo -e "Meaning: ${YELLOW}$meaning${RESET}"
      # Save fetched meaning locally
      echo "$word: $meaning" >> words.txt
      return 0
    fi
  else
    echo -e "${CYAN}Raw response:${RESET}"
    echo "$response" | head -c 200
  fi

  return 1
}

# 🚀 Main Script
header

# Take word as argument or ask user
if [ -z "$1" ]; then
  read -rp "Enter a word to search: " WORD
else
  WORD=$1
fi

if [ -z "$WORD" ]; then
  echo -e "${RED}Usage:${RESET} ./dictionary.sh <word>"
  exit 1
fi

echo ""
loading

# Try local first, then online
if search_local "$WORD"; then
  exit 0
elif search_online "$WORD"; then
  exit 0
else
  echo -e "${RED}❌ No definition found for '$WORD'.${RESET}"
  read -rp "➕ Add your own meaning? (y/n): " choice
  if [[ "$choice" =~ ^[Yy]$ ]]; then
    read -rp "Enter your meaning: " meaning
    echo "$WORD: $meaning" >> words.txt
    echo -e "${GREEN}✅ Saved to local dictionary!${RESET}"
  else
    echo -e "${YELLOW}Tip:${RESET} Try checking your internet or adding it manually to words.txt"
  fi
fi
