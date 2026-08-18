#!/usr/bin/env bash
# Compile a LaTeX document twice and generate PNG previews.

set -euo pipefail

if [ "$#" -ne 1 ]; then
    printf 'Usage: %s <path_to_latex_file.tex>\n' "$0" >&2
    exit 2
fi

TEX_FILE="$1"
if [ ! -f "$TEX_FILE" ]; then
    printf 'LaTeX source not found: %s\n' "$TEX_FILE" >&2
    exit 2
fi

if ! command -v pdflatex >/dev/null 2>&1; then
    printf 'pdflatex is not available in PATH\n' >&2
    exit 2
fi
if ! command -v pdftoppm >/dev/null 2>&1; then
    printf 'pdftoppm is not available in PATH\n' >&2
    exit 2
fi

BASENAME=$(basename "$TEX_FILE" .tex)
DIRNAME=$(dirname "$TEX_FILE")
PDF_FILE="${DIRNAME}/${BASENAME}.pdf"

printf 'Compiling %s (pass 1/2) ...\n' "$TEX_FILE"
pdflatex -halt-on-error -interaction=nonstopmode \
    -output-directory="$DIRNAME" "$TEX_FILE"

printf 'Compiling %s (pass 2/2) ...\n' "$TEX_FILE"
pdflatex -halt-on-error -interaction=nonstopmode \
    -output-directory="$DIRNAME" "$TEX_FILE"

if [ ! -f "$PDF_FILE" ]; then
    printf 'Expected PDF was not created: %s\n' "$PDF_FILE" >&2
    exit 1
fi

printf 'Generating PNG previews for %s ...\n' "$PDF_FILE"
pdftoppm -png -r 150 "$PDF_FILE" "${DIRNAME}/${BASENAME}_page"
printf 'Done. Preview images saved as %s_page-*.png\n' "${DIRNAME}/${BASENAME}"
