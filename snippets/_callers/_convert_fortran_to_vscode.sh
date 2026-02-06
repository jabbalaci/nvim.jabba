#!/usr/bin/env bash

PRG="_convert_snippet_to_vscode.py"
DEST_DIR="$HOME/Dropbox/share/vscode_settings_windows_linux/snippets"
#
SNIPPET="fortran.snippets"
VSCODE="FortranFreeForm.json"

# python3 $PRG $SNIPPET
python3 $PRG $SNIPPET >${DEST_DIR}/${VSCODE}
