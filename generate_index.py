import os
import re

# Categories matching your README layout
CATEGORIES = {"Easy": [], "Medium": [], "Hard": []}

# Manual mapping file or difficulty detection rules
# Since file names don't explicitly store difficulty, we can map problem numbers
# For this example, we'll auto-categorize based on common numbers or lists, 
# but you can adapt this logic or fetch from LeetCode API.
EASY_PROBS = [2, 9, 13, 14, 20, 21, 26, 27, 28, 66, 88, 136]
MEDIUM_PROBS = [3, 5, 6, 7, 8, 11, 12, 15, 16, 17]
HARD_PROBS = [4, 10, 23, 25, 30]

def get_difficulty(prob_num):
    if prob_num in EASY_PROBS: return "Easy"
    if prob_num in MEDIUM_PROBS: return "Medium"
    if prob_num in HARD_PROBS: return "Hard"
    return "Medium" # Default fallback

# Scan repo for solution files
for file in os.listdir('.'):
    # Regex to grab leading digits from files like '13. Roman...' or '066_plus_one...'
    match = re.match(r'^(\d+)[._\s]+(.*)\.(py|rb)$', file)
    if match:
        prob_num = int(match.group(1))
        # Format the display name (replace underscores with spaces, remove extension)
        prob_name = match.group(2).replace('_', ' ').title()
        ext = match.group(3)
        
        lang_badge = (
            "![Python](https://img.shields.io/badge/-Python-3776AB?style=flat-square&logo=python&logoColor=white)"
            if ext == "py" else
            "![Ruby](https://img.shields.io/badge/-Ruby-CC342D?style=flat-square&logo=ruby&logoColor=white)"
        )
        
        diff = get_difficulty(prob_num)
        CATEGORIES[diff].append({
            "num": prob_num,
            "name": prob_name,
            "path": f"./{file}",
            "badge": lang_badge
        })

# Read original README
with open("README.md", "r", encoding="utf-8") as f:
    readme_content = f.read()

# Generate Markdown tables dynamically
tables_output = "## 🗂️ Solutions Index\n\n"
for diff in ["Easy", "Medium", "Hard"]:
    color = "🟢" if diff == "Easy" else "🟡" if diff == "Medium" else "🔴"
    tables_output += f'<details open>\n<summary><strong>{color} {diff}</strong></summary>\n\n'
    tables_output += "| # | Problem | Language |\n|---|---------|----------|\n"
    
    # Sort by problem number
    sorted_probs = sorted(CATEGORIES[diff], key=lambda x: x["num"])
    for p in sorted_probs:
        tables_output += f'| {p["num"]} | [{p["name"]}]({p["path"]}) | {p["badge"]} |\n'
    
    tables_output += "\n</details>\n\n"

# Locate placeholders in README and swap content
pattern = r"## 🗂️ Solutions Index.*?## 🛠️ Tech Stack"
replacement = f"{tables_output}## 🛠️ Tech Stack"
updated_readme = re.sub(pattern, replacement, readme_content, flags=re.DOTALL)

with open("README.md", "w", encoding="utf-8") as f:
    f.write(updated_readme)
