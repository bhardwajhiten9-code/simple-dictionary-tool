📘 Simple Dictionary Tool (Shell Script)

A lightweight command-line dictionary tool built using Bash, curl, and jq, with offline + online meaning lookup and a beautiful terminal UI.

🚀 Features
✔ Local Dictionary (Offline Mode)

Stores meanings in words.txt

Instantly retrieves previously searched words

No internet required after first lookup

✔ Online Dictionary Lookup

Uses DictionaryAPI to fetch real meanings

Automatically adds new words to words.txt

✔ Wikipedia Fallback (Tech & Name Words)

If DictionaryAPI does not have the word, the tool fetches a short summary from Wikipedia using its REST API.

Useful for:

Technical terms

Names

Concepts not found in normal dictionaries

✔ User-Friendly Terminal UI

Colored output

Loading animation

Clean formatting

Interactive prompts

✔ Add Your Own Meaning

If a word is not found online, the script allows you to add your own custom definition.

📂 Project Structure
simple-dictionary-tool/
│
├── dictionary.sh      # Main Bash script
├── words.txt          # Local dictionary storage
└── README.md          # Project documentation

⚙️ How It Works

The tool follows a 4-level lookup process:

1️⃣ Local Search

Searches words.txt for:

word: meaning


If found → instantly displays.

2️⃣ Online Dictionary API Search

If not found locally:

Fetches meaning from
https://api.dictionaryapi.dev/api/v2/entries/en/<word>

Extracts:

Meaning

Part of speech

Pronunciation

If found → shows meaning and saves to words.txt.

3️⃣ Wikipedia Fallback

If DictionaryAPI fails:

Converts word to lowercase

Fetches summary from
https://en.wikipedia.org/api/rest_v1/page/summary/<word>

Displays short description

4️⃣ Manual Entry

If both sources fail:
The user can manually enter:

"your own meaning"

Which is then saved in words.txt.

🧠 Technologies & Commands Used
Bash Scripting

Used for full logic, control structure, variables, and functions.

curl

Fetches API results from:

DictionaryAPI

Wikipedia REST API

jq

Parses JSON responses safely.

grep

Searches inside words.txt with:

grep -i "^word:"


The caret (^) ensures exact matching at the start of line.

ANSI Escape Codes

Add colors for a clean output.

📥 Installation
1. Clone the repository
git clone https://github.com/bhardwajhiten9-code/simple-dictionary-tool
cd simple-dictionary-tool

2. Give execute permission
chmod +x dictionary.sh

3. (Optional) Install jq
sudo apt install jq

▶️ Usage
Search a word interactively
./dictionary.sh

Or directly pass a word
./dictionary.sh python

📌 Example Output
==============================
   🧠 Simple Dictionary Tool
==============================

Searching...

python (noun)
Pronunciation: /ˈpaɪθən/
Meaning: A high-level programming language.

🛠 Customization

You can modify:

Colors

Loading animation

API behavior

words.txt storage format

Everything is editable in dictionary.sh.

⭐ Future Enhancements

Want to expand the tool? Possible upgrades:

Synonyms / Antonyms

Voice pronunciation using espeak

Export meanings to JSON or CSV

Web version using Python/Flask

Autocomplete suggestions

👨‍💻 Author

Hiten Bhardwaj
Unix Lab Project – Simple Dictionary Tool 
<img width="991" height="262" alt="image" src="https://github.com/user-attachments/assets/f31c0d19-3551-40f8-9334-d0bedf77bf29" />

