---
tags: [meta, onboarding, soci, sdf]
status: active
created: 2026-04-27
project: none
audience: soci-salute-di-ferro
---

# Onboarding soci — Ferro-Brain Team

> Questo documento ti guida nel setup completo del workspace SDF. Tempo richiesto: **~30 minuti**.
> Se qualcosa non funziona, scrivi nel canale Slack #tech-support o chiedi a Matteo.

---

## Cos'è Ferro-Brain Team

È il **cervello digitale** di Salute di Ferro: un vault Obsidian condiviso + agente AI Claude Code integrato. Contiene:

- Strategia e roadmap aziendale (`03_Projects/SDF/`)
- Brief e materiali clienti (`03_Projects/Siti-Clienti/`)
- Definizioni dei "ruoli operativi" automatizzati (`30_Agents/`)
- Documentazione tecnica e tool (`99_System/`)
- Memoria condivisa di meeting, decisioni, action items
- Tutta la conoscenza aziendale che oggi vive sparsa tra DM, Drive, Notion

**Tu lo userai per:**
1. Leggere documenti aziendali sempre aggiornati
2. Chattare con Claude Code (l'agente AI) per fare ricerche, scrivere copy, generare brief, analizzare lead
3. Lasciare note di meeting che il team vede subito
4. Eseguire automazioni (es. trovare e analizzare un meeting Fathom, generare un piano d'azione, ecc.)

---

## ⚙️ Setup in 5 step (30 min)

### Step 1 — Account che ti servono

Prima di iniziare, accertati di avere:

1. **Account Obsidian aziendale** — credenziali fornite da Matteo (`info@salutediferro.com`)
   ⚠️ Tieni le credenziali in 1Password Teams (vedi step 5)
2. **Account Anthropic Ferro Team** — il tuo invito è arrivato via email, accedi su [console.anthropic.com](https://console.anthropic.com)
3. **Account 1Password Teams** — il tuo invito è arrivato via email
4. **Mac con macOS 13+** o **Windows 10+** o **Linux** — funzionano tutti, le istruzioni qui sono per Mac

### Step 2 — Esegui lo script di installazione automatica

Apri il **Terminale** (Mac: `Cmd+Spazio` → digita "Terminale" → invio) e copia-incolla questo comando:

```bash
curl -fsSL https://raw.githubusercontent.com/trillimatteob-blip/ferro-brain-setup/main/install.sh | bash
```

Repo pubblico: https://github.com/trillimatteob-blip/ferro-brain-setup

Lo script:
- ✅ Installa Homebrew (se manca)
- ✅ Installa Node.js
- ✅ Installa Claude Code CLI
- ✅ Installa Obsidian
- ✅ Installa Git
- ✅ Configura accesso al vault aziendale
- ✅ Crea i template `.env` per gli script automatici

Lo script richiede la password del Mac (1 sola volta). Niente di più.

### Step 3 — Login Claude Code

Dopo l'installazione, dal Terminale:

```bash
claude login
```

Si apre il browser. **Accedi col tuo account aziendale** (`@salutediferro.com`) — quello dell'organizzazione "Ferro Team" su Anthropic.

Verifica che funzioni:
```bash
claude --version
claude -p "Ciao, mi senti?"
```

### Step 4 — Apri Obsidian e accedi al vault aziendale

1. Apri **Obsidian** (Applicazioni)
2. Click su **"Apri vault esistente"**
3. Seleziona la cartella `~/Documents/Ferro-Brain-Team` (creata dallo script)
4. Quando ti chiede del Sync, **fai login con l'account Obsidian aziendale** (le credenziali sono in 1Password)
5. Attiva il Sync per scaricare l'ultima versione condivisa

Dopo qualche secondo vedi tutto il contenuto. Le modifiche tue arriveranno automaticamente agli altri soci entro 1 minuto.

### Step 5 — 1Password Teams

1. Apri l'invito email 1Password
2. Crea il tuo profilo
3. Salva il **Recovery Key** in un posto sicuro (es. iCloud Keychain) — se perdi password 1Password, senza Recovery Key i dati sono persi
4. Installa l'estensione 1Password sul browser (Chrome/Safari)
5. Trova nel Vault "Salute Di Ferro" le credenziali:
   - Obsidian aziendale
   - API key (Stripe, Resend, Fathom, ecc. — solo se ti servono)
   - Account Vercel, GitHub (se ti servono)

---

## 📂 Come è organizzato il vault

```
Ferro-Brain-Team/
├── 00_Meta/                    Governance, regole, questo documento
├── 03_Projects/
│   ├── SDF/                    Tutto Salute di Ferro (CRM, pipeline, templates messaggi)
│   └── Siti-Clienti/           Mammoli, futuri clienti
├── 05_Resources/               Risorse tematiche
├── 10_Memoria/                 Memoria condivisa team
├── 30_Agents/                  Definizione "ruoli AI" (orchestrator, writer, strategist, ecc.)
├── 99_System/                  Tool tecnici (router Claude/Kimi, automazioni)
└── AGENTS.md                   Registro agenti AI + convenzioni vault
```

**Cose private NON sono nel vault aziendale**: identity, daily personali, finanze. Quelle restano sul vault privato di ognuno.

---

## 📐 Regole di base (5 punti)

### 1. Mai dati clienti reali nel vault
Niente nomi/cognomi/numeri di telefono/email reali dei lead SDF nel vault.
**Perché**: GDPR Art. 9 (dati salute = categoria speciale, base giuridica esplicita richiesta).
Se devi fare riferimento a un lead reale, usa l'ID CRM (es. `SDF-0001`).

### 2. Mai segreti nel vault (API key, password)
Le credenziali vivono in **1Password**, mai in file `.md` o in `.env` committati.
File `.env*` sono già esclusi dal sync. Se per errore qualcosa di sensibile finisce nel vault, **avvisa subito Matteo**.

### 3. Convenzioni nomi file
- Note: `Titolo-In-Kebab.md` (lettere minuscole, parole separate da `-`)
- Meeting: `YYYY-MM-DD-titolo-meeting.md`
- Daily team: `YYYY-MM-DD-team.md` in `03_Projects/SDF/daily/`

### 4. Convenzioni link
- Usa sempre `[[wikilink]]` per riferimenti interni al vault, mai URL `file://`
- Tag in formato `#kebab-case` (es. `#salute-di-ferro`, `#lead-hot`)

### 5. Frontmatter YAML obbligatorio
Ogni file `.md` deve iniziare con:
```yaml
---
tags: []
status: draft | active | archived
created: YYYY-MM-DD
project: SDF | Mammoli | none
---
```

---

## 🤖 Come usare Claude Code (basics)

### Modalità chat (la più comune)
Apri il Terminale nella cartella del vault:
```bash
cd ~/Documents/Ferro-Brain-Team
claude
```
Si apre una sessione interattiva. Chatta con Claude come faresti su claude.ai. Lui legge i file del vault, può scrivere file, eseguire comandi.

Esempio:
> "Trova tutti i meeting di SDF dell'ultima settimana e fammi un riassunto delle decisioni prese."
> "Scrivi un messaggio WhatsApp per il lead Score 13 SDF-0001 basato sui template SDF."

### Modalità router (avanzata, per chi sa)
Per task strutturati (multi-step, classificazione automatica), c'è il **ferro router**:

```bash
ferro "scrivi messaggio per Luigi Score 13"
ferro --plan "analizza i lead Score 4-5 e proponi piano follow-up"
ferro --parallel "estrai pattern outreach"
```

Documentazione completa: [[99_System/skills/antigravity-orchestration]].

### Skill già installate
Il vault contiene già **decine di skill** custom. Per vederle:
```bash
ls 99_System/skills/
ls .claude/agents/
```

Esempi:
- `sdf-morning` — briefing mattutino SDF (lead, KPI, action di oggi)
- `lead-priority` — ordina lead CRM per urgenza
- `sales-copywriter` — scrive messaggi vendita personalizzati
- `funnel-insights` — analisi settimanale funnel SDF

---

## ❓ FAQ

**D: Devo usare il terminale obbligatoriamente?**
R: Per Claude Code sì (non c'è una vera GUI). Per Obsidian no, è una normale app desktop. Per le cose semplici puoi anche usare l'app **Claude Desktop** (claude.ai/desktop) — non ha accesso al filesystem, ma fa chat normali.

**D: Posso usare Cursor / Antigravity / VS Code invece del terminale?**
R: Sì. Cursor e Antigravity hanno Claude Code integrato. Puoi aprire la cartella del vault in quelle app e chattare da lì. Funziona identico.

**D: Cosa succede se modifico un file mentre un altro socio lo modifica?**
R: Obsidian Sync gestisce i conflitti automaticamente quasi sempre. Se c'è un conflitto vero, Obsidian crea un file `nome-conflict-YYYY-MM-DD.md` e tu decidi cosa tenere. Best practice: comunica nel canale Slack se stai facendo lavoro grosso su un file.

**D: Posso lavorare offline?**
R: Sì. Obsidian funziona offline e Claude Code funziona offline per le cose locali. Il sync e le chiamate Claude richiedono internet.

**D: Cosa NON devo fare?**
- ❌ Non installare plugin Obsidian random — chiedi a Matteo prima
- ❌ Non eliminare cartelle del vault (sposta in `06_Archive/` se devi)
- ❌ Non condividere screenshot del vault con esterni senza review
- ❌ Non committare `.env` o credentiali in nessun caso

---

## 🆘 Supporto

| Tipo problema | Chi |
|---|---|
| Setup tecnico (terminal, install) | Matteo |
| Strategia / business | Simone |
| Operations / clienti / lab | Antonio |
| Content / social / contenuti | Giuseppe |
| Tutto il resto | Slack #ferro-brain |

---

**Welcome to Ferro-Brain Team. Buon lavoro.**
