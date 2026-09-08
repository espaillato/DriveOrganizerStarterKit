#!/usr/bin/env bash
# setup.sh — one-command setup for the Living Reference Starter Kit.
#
# What this does (see SETUP_GUIDE.md step 1 for the full explanation):
#   1. Asks where you want your File Archive and Living Reference folders.
#   2. Copies File_Archive_Template/ and Living_Reference_Template/ into
#      those locations — never overwriting a file that's already there, so
#      it's safe to re-run this after you've started filing real documents.
#   3. Builds file-renamer.skill and file-archive-audit.skill (installable
#      zip packages) into dist/ from the source in skills/.
#   4. Prints next steps pointing at SETUP_GUIDE.md.
#
# Safe to re-run. Existing files in your target folders are never touched.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

echo "Living Reference Starter Kit — setup"
echo "======================================"
echo

# ---- 1. Ask for target locations -------------------------------------------

read -r -p "Where should your File Archive folder go? (e.g. a path inside your Google Drive) " ARCHIVE_TARGET
read -r -p "Where should your Living Reference folder go? (a sibling folder, not nested inside the archive) " REFERENCE_TARGET

if [ -z "$ARCHIVE_TARGET" ] || [ -z "$REFERENCE_TARGET" ]; then
  echo "Both paths are required. Re-run setup.sh when you're ready." >&2
  exit 1
fi

# Expand ~ if the user typed it.
ARCHIVE_TARGET="${ARCHIVE_TARGET/#\~/$HOME}"
REFERENCE_TARGET="${REFERENCE_TARGET/#\~/$HOME}"

mkdir -p "$ARCHIVE_TARGET" "$REFERENCE_TARGET"

# ---- 2. Copy templates, never overwriting existing files -------------------

echo
echo "Copying File_Archive_Template/ -> $ARCHIVE_TARGET (existing files kept as-is)..."
cp -Rn "$REPO_DIR/File_Archive_Template/." "$ARCHIVE_TARGET/"

echo "Copying Living_Reference_Template/ -> $REFERENCE_TARGET (existing files kept as-is)..."
cp -Rn "$REPO_DIR/Living_Reference_Template/." "$REFERENCE_TARGET/"

# ---- 3. Build the installable .skill packages ------------------------------

echo
echo "Building installable skill packages into dist/..."
mkdir -p "$REPO_DIR/dist"

build_skill () {
  local skill_name="$1"
  local src_dir="$REPO_DIR/skills/$skill_name"
  local out_zip="$REPO_DIR/dist/$skill_name.skill"

  if [ ! -d "$src_dir" ]; then
    echo "  ! skipping $skill_name — $src_dir not found" >&2
    return
  fi

  rm -f "$out_zip"
  # zip the *contents* of the skill folder, not the folder itself, so
  # SKILL.md ends up at the root of the archive as required.
  (cd "$src_dir" && zip -rq "$out_zip" . -x ".*")
  echo "  built dist/$skill_name.skill"
}

if command -v zip >/dev/null 2>&1; then
  build_skill "file-renamer"
  build_skill "file-archive-audit"
else
  echo "  ! 'zip' command not found — skipping package build." >&2
  echo "    Install zip (e.g. 'apt install zip' / 'brew install zip') and re-run," >&2
  echo "    or follow SETUP_GUIDE.md step 1's Option B to build them by hand." >&2
fi

# ---- 4. Done ----------------------------------------------------------------

echo
echo "Done."
echo "  File Archive:      $ARCHIVE_TARGET"
echo "  Living Reference:  $REFERENCE_TARGET"
if [ -f "$REPO_DIR/dist/file-renamer.skill" ]; then
  echo "  Skill packages:     $REPO_DIR/dist/"
fi
echo
echo "Next: open SETUP_GUIDE.md and continue from step 2."
