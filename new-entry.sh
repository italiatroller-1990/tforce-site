#!/usr/bin/env bash
set -euo pipefail

DOCS_DIR="docs"
BLOG_DIR="$DOCS_DIR/blog"
WIKI_DIR="$DOCS_DIR/wiki"
BLOG_INDEX="$BLOG_DIR/index.md"
WIKI_INDEX="$WIKI_DIR/index.md"
WIKI_SIDEBAR="$DOCS_DIR/.vitepress/config.ts"

# --- Helpers ---

slugify() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//'
}

today() {
  date +%Y-%m-%d
}

# --- Prompt for entry type ---

echo "What do you want to create?"
echo "  1) Blog post"
echo "  2) Wiki entry"
read -rp "Choice [1/2]: " choice

case "$choice" in
  1) TYPE="blog" ;;
  2) TYPE="wiki" ;;
  *) echo "Invalid choice."; exit 1 ;;
esac

# --- Prompt for title ---

read -rp "Title: " title
if [[ -z "$title" ]]; then
  echo "Title cannot be empty."
  exit 1
fi

slug=$(slugify "$title")
date=$(today)

# --- Prompt for author ---

read -rp "Author: " author
if [[ -z "$author" ]]; then
  echo "Author cannot be empty."
  exit 1
fi

# --- Check for duplicates ---

if [[ "$TYPE" == "blog" ]]; then
  TARGET="$BLOG_DIR/$slug.md"
  INDEX="$BLOG_INDEX"
else
  TARGET="$WIKI_DIR/$slug.md"
  INDEX="$WIKI_INDEX"
fi

if [[ -f "$TARGET" ]]; then
  echo "Error: $TARGET already exists."
  exit 1
fi

# --- Create the content file ---

if [[ "$TYPE" == "blog" ]]; then
  cat > "$TARGET" <<EOF
---
title: $title
author: $author
date: $date
---

# {{ \$frontmatter.title }}

**Author:** {{ \$frontmatter.author }} | **Date:** {{ \$frontmatter.date }}

Write your blog post here.
EOF
  echo "Created: $TARGET"

  # Append to blog index
  sed -i "\$a\\
- [$title](/blog/$slug) — $date" "$INDEX"
  echo "Updated: $INDEX"

  # Show sidebar snippet
  echo ""
  echo "Add this line to the sidebar in config.ts under a '/blog/' section:"
  echo "  { text: '$title', link: '/blog/$slug' },"

elif [[ "$TYPE" == "wiki" ]]; then
  cat > "$TARGET" <<EOF
---
title: $title
author: $author
date: $date
---

# {{ \$frontmatter.title }}

**Author:** {{ \$frontmatter.author }} | **Date:** {{ \$frontmatter.date }}

Write your wiki entry here.
EOF
  echo "Created: $TARGET"

  # Append to wiki index
  read -rp "Short description for the index (e.g. 'the ambitious FPS remake'): " desc
  sed -i "\$a\\
- [$title](/wiki/$slug) — $desc" "$INDEX"
  echo "Updated: $INDEX"

  # Show sidebar insertion snippet
  echo ""
  echo "Add this line to the sidebar in config.ts under the 'items' array:"
  echo "  { text: '$title', link: '/wiki/$slug' },"
fi

echo ""
echo "Done! Edit $TARGET to write your content."
