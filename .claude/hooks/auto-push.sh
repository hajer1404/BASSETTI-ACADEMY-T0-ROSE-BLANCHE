#!/usr/bin/env bash
# Stop hook: auto-commit and push working-tree changes to origin/main.
cd "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel)}" || exit 0

branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
[ "$branch" = "main" ] || exit 0

[ -n "$(git status --porcelain)" ] || exit 0

git add -A
git commit -q -m "chore: auto-save $(date '+%Y-%m-%d %H:%M')" || exit 0

if ! git push -q origin main 2>&1; then
  echo "auto-push: git push failed (commit kept locally)" >&2
fi
exit 0
