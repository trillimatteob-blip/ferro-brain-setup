# ferro-brain-setup

Script di onboarding **one-shot** per i soci di Salute Di Ferro che
accedono al vault Obsidian aziendale `Ferro-Brain-Team`.

## Quick start

Apri il Terminale sul tuo Mac e copia-incolla:

```bash
curl -fsSL https://raw.githubusercontent.com/trillimatteob-blip/ferro-brain-setup/main/install.sh | bash
```

Lo script installa (o aggiorna):

- **Homebrew** — package manager macOS
- **Node.js** — runtime per gli script di automazione
- **Git** — version control
- **Claude Code** — agente AI di Anthropic, da CLI
- **Obsidian** — knowledge base condivisa
- **Cartella vault locale** `~/Documents/Ferro-Brain-Team`
- **Template `.env`** per configurazioni private

Tempo richiesto: **~10 minuti** (la prima volta — Homebrew e dipendenze).

## Cosa NON fa lo script (lo fai tu manualmente dopo)

1. Login Obsidian Sync con account aziendale (te lo passa Matteo)
2. Login Claude Code (`claude login` → browser auth col tuo account `@salutediferro.com`)
3. Inserire l'**Encryption passphrase** del Remote Vault (Matteo te la condivide via 1Password)

## Sicurezza

Lo script è pubblicato come open source per trasparenza:
nessuna credenziale è inclusa. Tutte le credenziali (API keys, passphrase
Obsidian, password) restano private e vengono condivise tramite
**1Password Teams** del workspace SDF.

## Documentazione completa

La guida completa è nel vault stesso, alla path:
```
~/Documents/Ferro-Brain-Team/00_Meta/ONBOARDING-SOCI.md
```

Aprila in Obsidian dopo il primo sync.

## Supporto

- Setup tecnico, problemi installazione → Matteo
- Account aziendali (Obsidian, Anthropic, 1Password) → Matteo
- Il resto → canale Slack `#ferro-brain`

---

© 2026 Salute Di Ferro
