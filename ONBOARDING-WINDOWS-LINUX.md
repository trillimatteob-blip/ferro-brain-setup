---
tags: [meta, onboarding, soci, windows, linux, cross-platform]
status: active
created: 2026-04-27
audience: soci-non-mac
---

# Onboarding soci — Windows / Linux

> Tutorial alternativo per chi NON ha un Mac. Il setup è leggermente diverso ma il risultato è identico: vault Obsidian condiviso + Claude Code agente AI funzionante.
>
> **Tempo richiesto**: ~15 minuti (un po' più del Mac).

---

## Strategia: Claude Code fa il setup per te

L'idea: invece di scrivere uno script `.sh` (Mac/Linux) o `.ps1` (Windows) separato, **installiamo prima Claude Code** (l'agente AI), poi gli **incolliamo un prompt** che esegue il setup automaticamente sul tuo sistema operativo. Funziona su tutti gli OS perché Claude Code è multi-piattaforma.

---

## Step 0 — Verifica i requisiti

| OS | Versione minima |
|---|---|
| **macOS** | 13 (Ventura) o superiore |
| **Windows** | 10 / 11 (Powershell 5.1+) |
| **Linux** | Ubuntu 22.04+ / Fedora 38+ / Arch / Debian 12+ |

Tutti gli OS richiedono:
- Connessione internet
- Permessi amministratore (sudo / Administrator) per installare pacchetti

---

## Step 1 — Installa Claude Code

Vai sul sito ufficiale Anthropic e segui il link di download per il tuo OS:

🔗 **https://claude.com/download** (o https://docs.anthropic.com/en/docs/claude-code/setup)

### macOS
```bash
curl -fsSL https://claude.ai/install.sh | bash
```
oppure: scarica l'installer dalla pagina download.

### Windows
1. Apri **PowerShell** come Amministratore (Win+X → "Windows PowerShell (Admin)")
2. Esegui:
   ```powershell
   irm https://claude.ai/install.ps1 | iex
   ```
   *(se questo URL non funziona, scarica l'installer `.msi` dalla pagina download)*

### Linux
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

### Verifica installazione (tutti gli OS)

Apri il tuo terminale (Terminale su Mac, PowerShell su Windows, qualsiasi shell su Linux) e digita:

```bash
claude --version
```

Se vedi un numero di versione (es. `2.1.119 (Claude Code)`), l'installazione è andata a buon fine.

---

## Step 2 — Login Claude Code col tuo account aziendale

```bash
claude login
```

Si apre il browser. **Accedi col tuo account `@salutediferro.com`** — quello che ti è stato invitato nell'organizzazione "Ferro Team" su Anthropic.

> ⚠️ **NON usare un account personale**. Se ti logghi col personale poi devi sloggarti e riloggarti col team. Una sola sessione attiva alla volta.

Verifica che il login sia OK:
```bash
claude -p "Ciao, mi senti?"
```

Se Claude risponde con un messaggio normale, sei pronto.

---

## Step 3 — Apri Claude Code in modalità chat

Dalla cartella dove vuoi installare il vault (es. la home dell'utente):

```bash
# macOS / Linux
cd ~

# Windows PowerShell
cd $HOME
```

Poi avvia Claude Code:
```bash
claude
```

Si apre una sessione interattiva.

---

## Step 4 — Incolla questo prompt e premi Invio

Copia tutto il blocco qui sotto, incollalo nella sessione `claude`, premi Invio. Claude eseguirà il setup completo.

```
Sei un onboarding assistant per il vault aziendale Salute Di Ferro. Il
mio sistema operativo è probabilmente macOS, Windows o Linux — rilevalo
e usa i comandi appropriati.

OBIETTIVO finale:
- Cartella vault locale `Ferro-Brain-Team` in Documents
- Obsidian app installata
- Git installato
- Node.js installato
- File `.env.example` template creato
- Pronto per login Obsidian Sync (lo farò io manualmente dopo)

ISTRUZIONI:

1. Rileva il sistema operativo (uname -a / OS detection).

2. Verifica e installa (se mancanti) con il package manager dell'OS:
   - macOS: usa `brew` (installalo se manca, ma chiedimi conferma prima)
   - Windows: usa `winget` (preferito) o `choco`
   - Linux Ubuntu/Debian: usa `apt`
   - Linux Fedora/RHEL: usa `dnf`
   - Linux Arch: usa `pacman`

   Pacchetti da installare:
   - git
   - node (LTS, ≥20)
   - obsidian (Mac: brew cask; Windows: winget Obsidian.Obsidian; Linux: snap o flatpak; se nessuno funziona, mostrami l'URL di download manuale)

3. Crea la cartella vault locale:
   - macOS/Linux: ~/Documents/Ferro-Brain-Team
   - Windows: $env:USERPROFILE\Documents\Ferro-Brain-Team

4. Dentro la cartella vault crea:
   - sotto-cartella `99_System/antigravity/`
   - dentro, file `.env.example` con questo contenuto:
     ```
     # Template variabili ambiente — copia in `.env` (gitignored)
     # ANTHROPIC_API_KEY=
     # FATHOM_API_KEY=
     # RESEND_API_KEY=
     USER_NAME=
     USER_EMAIL=
     ```

5. Crea un file README.md nella root del vault con questo contenuto:
   ```
   # Ferro-Brain-Team (vault locale, ancora vuoto)

   Apri Obsidian → "Apri vault" → seleziona questa cartella.
   Quando Obsidian chiede del Sync, fai login con account
   `info@salutediferro.com` (credenziali da Matteo).
   Inserisci la passphrase del Remote Vault (Matteo te la
   condivide via 1Password 1-on-1, mai in chat di gruppo).

   Dopo il primo sync, il vault si popola automaticamente con
   tutto il contenuto aziendale.
   ```

6. NON eseguire login Obsidian o `claude login` se sono già fatti.

7. Alla fine, riassumi:
   - Cosa hai installato (con versione)
   - Cosa hai creato (path)
   - I 3 step manuali che restano per l'utente:
     a) Aprire Obsidian e fare login Sync
     b) Inserire passphrase del Remote Vault
     c) (Opzionale) Configurare `.env` con API key personali

NON installare software che richiede pagamento (es. 1Password).
NON inserire password al posto mio.
Chiedi conferma prima di operazioni con sudo / privilegi admin.
```

Claude eseguirà tutto. Se ti chiede conferma su qualcosa, leggi attentamente e rispondi con `sì` solo se ti torna.

---

## Step 5 — Setup manuale finale (3 cose, 5 minuti)

Dopo che Claude Code ha finito, fai TU manualmente:

### A. Apri Obsidian e accedi al vault

1. Apri **Obsidian** (Launchpad/Menu Start/Launcher)
2. Click **"Apri vault"** → **"Apri cartella come vault"**
3. Seleziona `~/Documents/Ferro-Brain-Team` (o `%USERPROFILE%\Documents\Ferro-Brain-Team` su Windows)
4. Quando Obsidian chiede il Sync, fai login con email aziendale Obsidian — credenziali nel messaggio privato di Matteo (1-on-1, NON in chat di gruppo)
5. Inserisci la **Encryption passphrase** del Remote Vault `Ferro-Brain-Team` (di nuovo: solo da messaggio privato di Matteo)
6. Avvia il sync. Dopo qualche minuto il vault si popola con tutto il contenuto aziendale.

### B. Test Claude Code

Dopo che Obsidian ha sincronizzato, dal terminale:

```bash
cd ~/Documents/Ferro-Brain-Team    # Windows: cd $env:USERPROFILE\Documents\Ferro-Brain-Team
claude
```

Si apre la chat. Prova un comando come:
```
Trova il file ONBOARDING-SOCI.md e fammi un riassunto di 3 punti
```

Se funziona, ottimo. Se non funziona, riguarda il login con `claude login`.

### C. (Opzionale) Configura `.env` personale

Solo se ti serve eseguire script avanzati:

```bash
cd ~/Documents/Ferro-Brain-Team/99_System/antigravity
cp .env.example .env
# Modifica .env col tuo editor preferito
```

Le API key ti vengono fornite in 1Password Teams (vedi messaggio di Matteo). NON salvare API key in chat / email / file Drive.

---

## ❓ Problemi comuni

### "claude: command not found"
- macOS/Linux: chiudi e riapri il terminale dopo l'installazione (PATH si aggiorna)
- Windows: chiudi e riapri PowerShell, oppure aggiungi manualmente la cartella Claude al PATH

### "winget is not recognized" (Windows)
- Aggiorna Windows tramite Microsoft Store (App Installer)
- Alternativa: usa `choco` (https://chocolatey.org/install)

### Obsidian non si installa
- Vai sul sito https://obsidian.md/download e scarica l'installer manuale
- Eseguilo come amministratore

### Sync Obsidian non parte / Login non funziona
- Verifica di essere stato invitato come collaboratore (controlla email da Obsidian)
- Verifica la passphrase è ESATTAMENTE quella di Matteo (case-sensitive)
- Se hai sbagliato 5 volte, attendi qualche minuto poi riprova

---

## 🆘 Supporto

- **Setup tecnico** → Matteo (contatto Slack o WhatsApp diretto)
- **Account aziendali** → Matteo
- **Documentazione completa** → file `00_Meta/ONBOARDING-SOCI.md` dentro il vault (lo vedi dopo il primo sync)

---

**Welcome to Ferro-Brain Team. 💪**
