#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# Ferro-Brain Team — Installer one-shot per soci SDF
# ─────────────────────────────────────────────────────────────────────────────
# Cosa fa:
#   1. Verifica/installa Homebrew (Mac), Node.js, Git
#   2. Installa Claude Code CLI
#   3. Installa Obsidian (via Homebrew Cask)
#   4. Crea ~/Documents/Ferro-Brain-Team se non esiste (chiede dove sincronizzare)
#   5. Crea il template `.env.example` per gli script
#   6. Mostra prossimi step
#
# Come usare:
#   curl -fsSL https://raw.githubusercontent.com/<org>/ferro-brain-setup/main/install.sh | bash
#   OPPURE (se hai il file locale):
#   bash install-ferro-brain.sh
#
# Tempo: ~10 minuti (la prima volta — Homebrew impiega tempo)
# Sicurezza: nessuna credenziale viene inserita o richiesta. Lo script
# fa solo install di software ufficiale.
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

VAULT_PATH="${VAULT_PATH:-$HOME/Documents/Ferro-Brain-Team}"
LOG_FILE="$HOME/.ferro-brain-install.log"

# Colori
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
  echo -e "${BLUE}[ferro-brain]${NC} $1"
  echo "[$(date)] $1" >> "$LOG_FILE"
}

ok() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
err() { echo -e "${RED}✗${NC} $1" >&2; }

OS="$(uname -s)"
case "$OS" in
  Darwin*) PLATFORM=mac ;;
  Linux*) PLATFORM=linux ;;
  *) err "OS non supportato: $OS"; exit 1 ;;
esac

log "Piattaforma rilevata: $PLATFORM"

# ─── 1. Homebrew (Mac only) ──────────────────────────────────────────────────
if [ "$PLATFORM" = "mac" ]; then
  if ! command -v brew &>/dev/null; then
    log "Installo Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Aggiungi brew al PATH per la sessione corrente
    if [ -d /opt/homebrew/bin ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    ok "Homebrew installato"
  else
    ok "Homebrew già presente: $(brew --version | head -1)"
  fi
fi

# ─── 2. Git ──────────────────────────────────────────────────────────────────
if ! command -v git &>/dev/null; then
  log "Installo Git..."
  if [ "$PLATFORM" = "mac" ]; then
    brew install git
  else
    sudo apt-get update && sudo apt-get install -y git
  fi
  ok "Git installato: $(git --version)"
else
  ok "Git già presente: $(git --version)"
fi

# ─── 3. Node.js ──────────────────────────────────────────────────────────────
if ! command -v node &>/dev/null; then
  log "Installo Node.js (versione LTS)..."
  if [ "$PLATFORM" = "mac" ]; then
    brew install node
  else
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
  fi
  ok "Node.js installato: $(node --version)"
else
  NODE_VER=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
  if [ "$NODE_VER" -lt 20 ]; then
    warn "Node.js $NODE_VER < 20. Aggiorno..."
    [ "$PLATFORM" = "mac" ] && brew upgrade node
  else
    ok "Node.js già presente: $(node --version)"
  fi
fi

# ─── 4. Claude Code CLI ──────────────────────────────────────────────────────
if ! command -v claude &>/dev/null; then
  log "Installo Claude Code CLI..."
  # Installer ufficiale Anthropic
  curl -fsSL https://claude.ai/install.sh | bash || {
    warn "Installer principale non disponibile, fallback npm"
    npm install -g @anthropic-ai/claude-code
  }
  ok "Claude Code installato: $(claude --version 2>/dev/null || echo 'verifica con claude --version dopo restart shell')"
else
  ok "Claude Code già presente: $(claude --version)"
fi

# ─── 5. Obsidian ──────────────────────────────────────────────────────────────
if [ "$PLATFORM" = "mac" ]; then
  if [ ! -d "/Applications/Obsidian.app" ]; then
    log "Installo Obsidian..."
    brew install --cask obsidian
    ok "Obsidian installato"
  else
    ok "Obsidian già presente"
  fi
else
  warn "Linux: installa Obsidian manualmente da https://obsidian.md/download"
fi

# ─── 6. Cartella vault locale ────────────────────────────────────────────────
if [ ! -d "$VAULT_PATH" ]; then
  log "Creo cartella vault: $VAULT_PATH"
  mkdir -p "$VAULT_PATH"
  ok "Cartella vault creata. Ora apri Obsidian → 'Apri vault esistente' → seleziona $VAULT_PATH"
  warn "Il vault inizialmente è VUOTO. Dopo aver fatto login Obsidian Sync, il contenuto si scarica automaticamente."
else
  ok "Vault path già esistente: $VAULT_PATH"
  if [ -d "$VAULT_PATH/00_Meta" ]; then
    ok "Il vault contiene già i file aziendali (Sync attivo o precedente install)"
  fi
fi

# ─── 7. Template .env.example ────────────────────────────────────────────────
ENV_TPL="$VAULT_PATH/99_System/antigravity/.env.example"
if [ -d "$VAULT_PATH/99_System/antigravity" ]; then
  if [ ! -f "$ENV_TPL" ]; then
    log "Creo template .env.example"
    cat > "$ENV_TPL" <<'ENVEOF'
# Template ambiente per ferro-router (99_System/antigravity)
# Copia questo file in `.env` e compila con le TUE credenziali (no condivisione).
# .env è gitignored e NON viene mai sincronizzato via Obsidian Sync.

# Anthropic / Claude — usato da `claude` CLI (auto-config dopo `claude login`)
# ANTHROPIC_API_KEY=

# Fathom (meeting recordings) — chiedi a Matteo se ti serve
# FATHOM_API_KEY=

# Resend (email transazionali per siti SDF)
# RESEND_API_KEY=

# Stripe (pagamenti, ruolo dev)
# STRIPE_SECRET_KEY=

# Setup utente
USER_ROLE=member  # member | admin | dev
USER_NAME=
USER_EMAIL=
ENVEOF
    ok "Template .env creato in $ENV_TPL"
  fi
fi

# ─── 8. Riepilogo prossimi step ──────────────────────────────────────────────
echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ Installazione completata${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════════${NC}"
echo ""
echo "Prossimi step (FANNO DA TE):"
echo ""
echo "1. Apri ${BLUE}Obsidian${NC} dal Launchpad"
echo "   → Click 'Apri vault esistente'"
echo "   → Seleziona la cartella: ${YELLOW}$VAULT_PATH${NC}"
echo "   → Quando ti chiede del Sync, fai login con l'account aziendale Obsidian"
echo "     (credenziali in ${BLUE}1Password Teams${NC} → vault Salute Di Ferro)"
echo ""
echo "2. Login Claude Code:"
echo "   ${BLUE}\$ claude login${NC}"
echo "   → Si apre il browser, fai login col tuo account ${YELLOW}@salutediferro.com${NC}"
echo "   → Verifica: ${BLUE}claude -p \"Ciao, mi senti?\"${NC}"
echo ""
echo "3. Apri 1Password e installa l'estensione browser"
echo ""
echo "4. Leggi l'onboarding:"
echo "   ${BLUE}\$ open $VAULT_PATH/00_Meta/ONBOARDING-SOCI.md${NC}"
echo ""
echo "Log dell'installazione: $LOG_FILE"
echo ""
echo -e "${GREEN}Welcome to Ferro-Brain Team. 💪${NC}"
