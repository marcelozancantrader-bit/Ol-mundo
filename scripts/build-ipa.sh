#!/usr/bin/env bash
# Gera um .ipa do app OlaMundo. PRECISA rodar em macOS com Xcode 15+.
#
# Uso:
#   ./scripts/build-ipa.sh unsigned        # .ipa sem assinatura (para AltStore/Sideloadly)
#   ./scripts/build-ipa.sh development     # .ipa assinado para seu dispositivo (Apple Developer)
#   ./scripts/build-ipa.sh ad-hoc          # .ipa ad-hoc (Apple Developer pago)
#
# Saída: build/OlaMundo.ipa

set -euo pipefail

MODE="${1:-unsigned}"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="$ROOT_DIR/OlaMundo/OlaMundo.xcodeproj"
SCHEME="OlaMundo"
BUILD_DIR="$ROOT_DIR/build"
ARCHIVE_PATH="$BUILD_DIR/OlaMundo.xcarchive"
EXPORT_DIR="$BUILD_DIR/export"

if [[ "$(uname)" != "Darwin" ]]; then
  echo "ERRO: este script só funciona em macOS (precisa de xcodebuild)." >&2
  exit 1
fi

if ! command -v xcodebuild >/dev/null 2>&1; then
  echo "ERRO: xcodebuild não encontrado. Instale o Xcode pela App Store." >&2
  exit 1
fi

mkdir -p "$BUILD_DIR"
rm -rf "$ARCHIVE_PATH" "$EXPORT_DIR"

echo "==> Arquivando ($MODE)..."

case "$MODE" in
  unsigned)
    # Constrói sem assinatura. O .ipa resultante NÃO instala direto no iPhone;
    # você precisará passá-lo pelo AltStore, Sideloadly ou similar.
    xcodebuild \
      -project "$PROJECT" \
      -scheme "$SCHEME" \
      -configuration Release \
      -destination "generic/platform=iOS" \
      -archivePath "$ARCHIVE_PATH" \
      CODE_SIGN_IDENTITY="" \
      CODE_SIGNING_REQUIRED=NO \
      CODE_SIGNING_ALLOWED=NO \
      archive

    # Empacota manualmente o .app dentro de Payload/ -> .ipa
    PAYLOAD_DIR="$BUILD_DIR/Payload"
    rm -rf "$PAYLOAD_DIR"
    mkdir -p "$PAYLOAD_DIR"
    cp -R "$ARCHIVE_PATH/Products/Applications/OlaMundo.app" "$PAYLOAD_DIR/"
    (cd "$BUILD_DIR" && zip -qr "OlaMundo.ipa" "Payload")
    rm -rf "$PAYLOAD_DIR"
    ;;

  development|ad-hoc)
    EXPORT_OPTIONS="$ROOT_DIR/scripts/ExportOptions-$MODE.plist"
    if [[ ! -f "$EXPORT_OPTIONS" ]]; then
      echo "ERRO: $EXPORT_OPTIONS não encontrado." >&2
      exit 1
    fi

    xcodebuild \
      -project "$PROJECT" \
      -scheme "$SCHEME" \
      -configuration Release \
      -destination "generic/platform=iOS" \
      -archivePath "$ARCHIVE_PATH" \
      archive

    xcodebuild \
      -exportArchive \
      -archivePath "$ARCHIVE_PATH" \
      -exportOptionsPlist "$EXPORT_OPTIONS" \
      -exportPath "$EXPORT_DIR"

    cp "$EXPORT_DIR/OlaMundo.ipa" "$BUILD_DIR/OlaMundo.ipa"
    ;;

  *)
    echo "Modo desconhecido: $MODE (use: unsigned | development | ad-hoc)" >&2
    exit 1
    ;;
esac

echo ""
echo "OK: gerado $BUILD_DIR/OlaMundo.ipa"
