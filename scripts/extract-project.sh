#!/usr/bin/env bash
set -euo pipefail

ZIP_FILE="${1:-create-website-jornal-ana-neri.zip}"
OUT_DIR="${2:-site}"

if [ ! -f "$ZIP_FILE" ]; then
  echo "Arquivo ZIP não encontrado: $ZIP_FILE"
  exit 1
fi

mkdir -p "$OUT_DIR"
rm -rf "$OUT_DIR"/*

unzip -oq "$ZIP_FILE" -d "$OUT_DIR"

echo "Projeto extraído em: $OUT_DIR"

# Tenta mover o conteúdo da pasta extraída para a raiz da pasta de destino, caso o ZIP venha com uma pasta interna.
first_level=$(find "$OUT_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1 || true)
if [ -n "$first_level" ] && [ "$(find "$OUT_DIR" -mindepth 1 -maxdepth 1 | wc -l)" -eq 1 ]; then
  shopt -s dotglob
  mv "$first_level"/* "$OUT_DIR"/
  rmdir "$first_level"
  shopt -u dotglob
fi

echo "Organização concluída."
