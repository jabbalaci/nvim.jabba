#!/usr/bin/env bash

PRG="_callers/_convert_snippet_to_vscode.py"
DEST_DIR="$HOME/.config/Code/User/snippets"
#
SNIPPET="nim.snippets"
VSCODE="nim.json"

# python3 $PRG $SNIPPET
python3 $PRG $SNIPPET >${DEST_DIR}/${VSCODE}
